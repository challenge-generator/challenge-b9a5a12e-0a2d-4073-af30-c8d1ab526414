import 'dart:async';
import 'package:mobile_banking_app/core/design_patterns/command/transfer_command.dart';
import 'package:mobile_banking_app/domain/usecases/transfer_funds_usecase.dart';
import 'package:equatable/equatable.dart';

enum CommandQueueStatus {
  idle,
  processing,
  paused,
  stopped,
}

class CommandQueueStats {
  final int totalCommands;
  final int pendingCommands;
  final int completedCommands;
  final int failedCommands;
  final Duration totalProcessingTime;

  CommandQueueStats({
    required this.totalCommands,
    required this.pendingCommands,
    required this.completedCommands,
    required this.failedCommands,
    required this.totalProcessingTime,
  });
}

class CommandQueueEvent {
  final String commandId;
  final TransferCommandStatus previousStatus;
  final TransferCommandStatus newStatus;
  final DateTime timestamp;
  final String? errorMessage;

  CommandQueueEvent({
    required this.commandId,
    required this.previousStatus,
    required this.newStatus,
    required this.timestamp,
    this.errorMessage,
  });
}

typedef CommandQueueListener = void Function(CommandQueueEvent event);

class CommandQueue extends Equatable {
  final String id;
  final int maxConcurrent;
  final Duration commandTimeout;
  final bool autoRetry;
  final int maxRetries;

  final List<TransferCommand> _commands = [];
  final List<TransferCommand> _completedCommands = [];
  final List<TransferCommand> _failedCommands = [];
  final Map<String, TransferCommandResult> _results = {};
  final List<CommandQueueListener> _listeners = [];
  
  CommandQueueStatus _status = CommandQueueStatus.idle;
  int _runningCount = 0;
  Duration _totalProcessingTime = Duration.zero;
  TransferFundsUseCase? _transferFundsUseCase;

  CommandQueue({
    required this.id,
    this.maxConcurrent = 3,
    this.commandTimeout = const Duration(seconds: 30),
    this.autoRetry = true,
    this.maxRetries = 3,
  });

  CommandQueueStatus get status => _status;
  List<TransferCommand> get pendingCommands => List.unmodifiable(_commands);
  List<TransferCommand> get completedCommands => List.unmodifiable(_completedCommands);
  List<TransferCommand> get failedCommands => List.unmodifiable(_failedCommands);
  int get pendingCount => _commands.length;
  int get runningCount => _runningCount;

  void setTransferFundsUseCase(TransferFundsUseCase useCase) {
    _transferFundsUseCase = useCase;
  }

  void addListener(CommandQueueListener listener) {
    _listeners.add(listener);
  }

  void removeListener(CommandQueueListener listener) {
    _listeners.remove(listener);
  }

  void _notifyListeners(CommandQueueEvent event) {
    for (final listener in _listeners) {
      listener(event);
    }
  }

  Future<void> enqueue(TransferCommand command) async {
    _commands.add(command);
    _notifyListeners(CommandQueueEvent(
      commandId: command.id,
      previousStatus: TransferCommandStatus.pending,
      newStatus: command.status,
      timestamp: DateTime.now(),
    ));

    if (_status == CommandQueueStatus.idle) {
      await _processQueue();
    }
  }

  Future<void> enqueueAll(List<TransferCommand> commands) async {
    _commands.addAll(commands);
    
    if (_status == CommandQueueStatus.idle) {
      await _processQueue();
    }
  }

  Future<void> pause() async {
    _status = CommandQueueStatus.paused;
  }

  Future<void> resume() async {
    if (_status == CommandQueueStatus.paused) {
      _status = CommandQueueStatus.idle;
      await _processQueue();
    }
  }

  Future<void> stop() async {
    _status = CommandQueueStatus.stopped;
  }

  Future<void> clear() async {
    _commands.clear();
    _completedCommands.clear();
    _failedCommands.clear();
    _results.clear();
  }

  CommandQueueStats getStats() {
    return CommandQueueStats(
      totalCommands: _completedCommands.length + _failedCommands.length + _commands.length,
      pendingCommands: _commands.length,
      completedCommands: _completedCommands.length,
      failedCommands: _failedCommands.length,
      totalProcessingTime: _totalProcessingTime,
    );
  }

  TransferCommandResult? getResult(String commandId) {
    return _results[commandId];
  }

  Future<void> _processQueue() async {
    if (_transferFundsUseCase == null) {
      throw StateError('TransferFundsUseCase not set. Call setTransferFundsUseCase first.');
    }

    _status = CommandQueueStatus.processing;

    while (_commands.isNotEmpty && _status != CommandQueueStatus.stopped) {
      if (_status == CommandQueueStatus.paused) {
        await Future.delayed(const Duration(milliseconds: 100));
        continue;
      }

      if (_runningCount >= maxConcurrent) {
        await Future.delayed(const Duration(milliseconds: 100));
        continue;
      }

      final command = _commands.removeAt(0);
      _runningCount++;
      _executeCommand(command);
    }

    if (_commands.isEmpty) {
      _status = CommandQueueStatus.idle;
    }
  }

  Future<void> _executeCommand(TransferCommand command) async {
    final previousStatus = command.status;
    
    try {
      final result = await _executeWithTimeout(command);
      _results[command.id] = result;

      if (result.isSuccessful) {
        _completedCommands.add(command.copyWith(
          status: TransferCommandStatus.completed,
          completedAt: DateTime.now(),
        ));
        _notifyListeners(CommandQueueEvent(
          commandId: command.id,
          previousStatus: previousStatus,
          newStatus: TransferCommandStatus.completed,
          timestamp: DateTime.now(),
        ));
      } else {
        _failedCommands.add(command.copyWith(
          status: TransferCommandStatus.failed,
          completedAt: DateTime.now(),
        ));
        _notifyListeners(CommandQueueEvent(
          commandId: command.id,
          previousStatus: previousStatus,
          newStatus: TransferCommandStatus.failed,
          timestamp: DateTime.now(),
          errorMessage: result.errorMessage,
        ));

        if (autoRetry && command is ExecuteTransferCommand) {
          await _retryCommand(command);
        }
      }

      _totalProcessingTime += result.executionTime;
    } catch (e) {
      _failedCommands.add(command.copyWith(
        status: TransferCommandStatus.failed,
        completedAt: DateTime.now(),
      ));
      _notifyListeners(CommandQueueEvent(
        commandId: command.id,
        previousStatus: previousStatus,
        newStatus: TransferCommandStatus.failed,
        timestamp: DateTime.now(),
        errorMessage: e.toString(),
      ));
    } finally {
      _runningCount--;
    }
  }

  Future<TransferCommandResult> _executeWithTimeout(TransferCommand command) async {
    final completer = Completer<TransferCommandResult>();

    final timeout = Timer(commandTimeout, () {
      if (!completer.isCompleted) {
        completer.complete(TransferCommandResult(
          errorMessage: 'Command timed out after ${commandTimeout.inSeconds} seconds',
          status: TransferCommandStatus.failed,
          executionTime: commandTimeout,
        ));
      }
    });

    try {
      final result = await command.execute(_transferFundsUseCase!);
      if (!completer.isCompleted) {
        completer.complete(result);
      }
    } catch (e) {
      if (!completer.isCompleted) {
        completer.complete(TransferCommandResult(
          errorMessage: e.toString(),
          status: TransferCommandStatus.failed,
          executionTime: Duration.zero,
        ));
      }
    } finally {
      timeout.cancel();
    }

    return completer.future;
  }

  Future<void> _retryCommand(ExecuteTransferCommand command) async {
    if (command.maxRetries > 0) {
      final retryCommand = ExecuteTransferCommand(
        id: '${command.id}_retry_${DateTime.now().millisecondsSinceEpoch}',
        request: command.request,
        createdAt: DateTime.now(),
        maxRetries: command.maxRetries - 1,
        checkIdempotency: command.checkIdempotency,
        verifyBalance: command.verifyBalance,
      );

      await Future.delayed(const Duration(seconds: 1));
      await enqueue(retryCommand);
    }
  }

  @override
  List<Object?> get props => [
        id,
        maxConcurrent,
        commandTimeout,
        autoRetry,
        maxRetries,
        _status,
        _runningCount,
      ];
}