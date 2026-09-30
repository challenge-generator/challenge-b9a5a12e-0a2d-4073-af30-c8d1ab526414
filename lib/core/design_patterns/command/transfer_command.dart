import 'package:mobile_banking_app/domain/entities/transfer_request.dart';
import 'package:mobile_banking_app/domain/entities/transaction.dart';
import 'package:mobile_banking_app/domain/entities/account.dart';
import 'package:mobile_banking_app/domain/usecases/transfer_funds_usecase.dart';
import 'package:mobile_banking_app/core/utils/result.dart';
import 'package:equatable/equatable.dart';

enum TransferCommandStatus {
  pending,
  executing,
  completed,
  failed,
  cancelled,
}

class TransferCommandResult {
  final Transaction? transaction;
  final String? errorMessage;
  final TransferCommandStatus status;
  final Duration executionTime;

  TransferCommandResult({
    this.transaction,
    this.errorMessage,
    required this.status,
    required this.executionTime,
  });

  bool get isSuccessful => status == TransferCommandStatus.completed && transaction != null;
}

abstract class TransferCommand extends Equatable {
  final String id;
  final TransferRequest request;
  final DateTime createdAt;
  final DateTime? startedAt;
  final DateTime? completedAt;
  final TransferCommandStatus status;

  TransferCommand({
    required this.id,
    required this.request,
    required this.createdAt,
    this.startedAt,
    this.completedAt,
    this.status = TransferCommandStatus.pending,
  });

  Future<TransferCommandResult> execute(TransferFundsUseCase transferFundsUseCase);

  TransferCommand copyWith({
    String? id,
    TransferRequest? request,
    DateTime? createdAt,
    DateTime? startedAt,
    DateTime? completedAt,
    TransferCommandStatus? status,
  });

  @override
  List<Object?> get props => [id, request, createdAt, startedAt, completedAt, status];
}

class ExecuteTransferCommand extends TransferCommand {
  final bool checkIdempotency;
  final bool verifyBalance;
  final int maxRetries;

  ExecuteTransferCommand({
    required super.id,
    required super.request,
    required super.createdAt,
    super.startedAt,
    super.completedAt,
    super.status,
    this.checkIdempotency = true,
    this.verifyBalance = true,
    this.maxRetries = 3,
  });

  @override
  Future<TransferCommandResult> execute(TransferFundsUseCase transferFundsUseCase) async {
    final startTime = DateTime.now();
    
    try {
      final updatedThis = copyWith(
        startedAt: DateTime.now(),
        status: TransferCommandStatus.executing,
      );

      final result = await transferFundsUseCase.execute(
        fromAccountId: request.fromAccountId,
        toAccountId: request.toAccountId,
        amount: request.amount,
        description: request.description,
        channel: request.channel,
        referenceNumber: request.referenceNumber,
      );

      final endTime = DateTime.now();
      final executionTime = endTime.difference(startTime);

      if (result.isSuccess) {
        return TransferCommandResult(
          transaction: result.data,
          status: TransferCommandStatus.completed,
          executionTime: executionTime,
        );
      } else {
        return TransferCommandResult(
          errorMessage: result.error,
          status: TransferCommandStatus.failed,
          executionTime: executionTime,
        );
      }
    } catch (e) {
      final endTime = DateTime.now();
      return TransferCommandResult(
        errorMessage: 'Error executing transfer: $e',
        status: TransferCommandStatus.failed,
        executionTime: endTime.difference(startTime),
      );
    }
  }

  @override
  ExecuteTransferCommand copyWith({
    String? id,
    TransferRequest? request,
    DateTime? createdAt,
    DateTime? startedAt,
    DateTime? completedAt,
    TransferCommandStatus? status,
  }) {
    return ExecuteTransferCommand(
      id: id ?? this.id,
      request: request ?? this.request,
      createdAt: createdAt ?? this.createdAt,
      startedAt: startedAt ?? this.startedAt,
      completedAt: completedAt ?? this.completedAt,
      status: status ?? this.status,
      checkIdempotency: checkIdempotency,
      verifyBalance: verifyBalance,
      maxRetries: maxRetries,
    );
  }

  @override
  List<Object?> get props => [
        ...super.props,
        checkIdempotency,
        verifyBalance,
        maxRetries,
      ];
}

class CancelTransferCommand extends TransferCommand {
  ExecuteTransferCommand? _targetCommand;

  CancelTransferCommand({
    required super.id,
    required super.request,
    required super.createdAt,
    ExecuteTransferCommand? targetCommand,
  }) : _targetCommand = targetCommand;

  @override
  Future<TransferCommandResult> execute(TransferFundsUseCase transferFundsUseCase) async {
    final startTime = DateTime.now();

    if (_targetCommand != null && 
        _targetCommand!.status == TransferCommandStatus.pending) {
      _targetCommand = _targetCommand!.copyWith(
        status: TransferCommandStatus.cancelled,
        completedAt: DateTime.now(),
      );

      return TransferCommandResult(
        status: TransferCommandStatus.completed,
        executionTime: DateTime.now().difference(startTime),
      );
    }

    return TransferCommandResult(
      errorMessage: 'No se puede cancelar: comando no encontrado o ya en ejecución',
      status: TransferCommandStatus.failed,
      executionTime: DateTime.now().difference(startTime),
    );
  }

  @override
  CancelTransferCommand copyWith({
    String? id,
    TransferRequest? request,
    DateTime? createdAt,
    DateTime? startedAt,
    DateTime? completedAt,
    TransferCommandStatus? status,
  }) {
    return CancelTransferCommand(
      id: id ?? this.id,
      request: request ?? this.request,
      createdAt: createdAt ?? this.createdAt,
      targetCommand: _targetCommand,
    );
  }
}