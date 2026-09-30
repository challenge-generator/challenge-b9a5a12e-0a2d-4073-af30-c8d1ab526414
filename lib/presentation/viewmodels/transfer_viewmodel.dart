import 'package:flutter/foundation.dart';
import 'package:equatable/equatable.dart';
import 'package:get_it/get_it.dart';
import '../../domain/entities/transfer_request.dart';
import '../../domain/entities/transaction.dart';
import '../../domain/usecases/transfer_funds_usecase.dart';
import '../../core/utils/result.dart';
import '../../core/design_patterns/command/transfer_command.dart';
import '../../core/design_patterns/command/command_queue.dart';
import '../../core/design_patterns/strategy/authentication_strategy.dart';
import '../../core/design_patterns/strategy/biometric_auth_strategy.dart';
import '../../core/design_patterns/strategy/pin_auth_strategy.dart';

enum TransferViewState { initial, validating, authenticating, processing, success, error }

class TransferViewModel extends ChangeNotifier {
  final TransferFundsUseCase _transferFundsUseCase;
  final CommandQueue _commandQueue;
  final BiometricAuthStrategy _biometricStrategy;
  final PinAuthStrategy _pinStrategy;
  
  TransferViewState _state = TransferViewState.initial;
  TransferRequest? _pendingRequest;
  Transaction? _completedTransaction;
  String? _errorMessage;
  List<TransferCommand> _commandHistory = [];
  String _selectedAuthMethod = 'biometric';
  double _currentAmount = 0.0;
  String _targetAccountId = '';
  String _transferDescription = '';

  TransferViewModel({
    TransferFundsUseCase? transferFundsUseCase,
    CommandQueue? commandQueue,
    BiometricAuthStrategy? biometricStrategy,
    PinAuthStrategy? pinStrategy,
  })  : _transferFundsUseCase = transferFundsUseCase ?? GetIt.I<TransferFundsUseCase>(),
        _commandQueue = commandQueue ?? CommandQueue(),
        _biometricStrategy = biometricStrategy ?? BiometricAuthStrategy(),
        _pinStrategy = pinStrategy ?? PinAuthStrategy();

  TransferViewState get state => _state;
  TransferRequest? get pendingRequest => _pendingRequest;
  Transaction? get completedTransaction => _completedTransaction;
  String? get errorMessage => _errorMessage;
  List<TransferCommand> get commandHistory => List.unmodifiable(_commandHistory);
  String get selectedAuthMethod => _selectedAuthMethod;
  bool get isProcessing => _state == TransferViewState.processing;
  bool get canSubmit => _isFormValid() && _state != TransferViewState.processing;

  void updateAmount(double amount) {
    _currentAmount = amount;
    _validateForm();
  }

  void updateTargetAccount(String accountId) {
    _targetAccountId = accountId;
    _validateForm();
  }

  void updateDescription(String description) {
    _transferDescription = description;
  }

  void setAuthMethod(String method) {
    _selectedAuthMethod = method;
    notifyListeners();
  }

  void _validateForm() {
    if (_currentAmount > 0 && _targetAccountId.isNotEmpty) {
      _generatePendingRequest();
    } else {
      _pendingRequest = null;
    }
    notifyListeners();
  }

  bool _isFormValid() {
    return _currentAmount > 0 && 
           _targetAccountId.isNotEmpty && 
           _targetAccountId != 'ACC-001';
  }

  void _generatePendingRequest() {
    _pendingRequest = TransferRequest(
      id: 'TRF-${DateTime.now().millisecondsSinceEpoch}',
      fromAccountId: 'ACC-001',
      toAccountId: _targetAccountId,
      amount: _currentAmount,
      currency: 'USD',
      description: _transferDescription,
      channel: 'mobile_app',
      referenceNumber: null,
      timestamp: DateTime.now(),
      requiresBiometric: _selectedAuthMethod == 'biometric',
    );
  }

  Future<void> initiateTransfer() async {
    if (!canSubmit || _pendingRequest == null) return;

    _state = TransferViewState.validating;
    _errorMessage = null;
    notifyListeners();

    try {
      final validationResult = await _validateTransferLimits(_pendingRequest!);
      if (validationResult.isFailure) {
        _state = TransferViewState.error;
        _errorMessage = validationResult.error;
        notifyListeners();
        return;
      }

      _state = TransferViewState.authenticating;
      notifyListeners();

      final authResult = await _authenticateUser();
      if (authResult.isFailure) {
        _state = TransferViewState.error;
        _errorMessage = authResult.error;
        notifyListeners();
        return;
      }

      await _executeTransfer();
    } catch (e) {
      _state = TransferViewState.error;
      _errorMessage = 'Error inesperado durante la transferencia';
      notifyListeners();
    }
  }

  Future<Result<void>> _validateTransferLimits(TransferRequest request) async {
    const double maxSingleTransfer = 10000.0;
    const double dailyLimit = 25000.0;

    if (request.amount > maxSingleTransfer) {
      return Result.failure('El monto excede el límite máximo de \$$maxSingleTransfer');
    }

    final dailyTotal = _calculateDailyTotal();
    if (dailyTotal + request.amount > dailyLimit) {
      return Result.failure('La transferencia excede el límite diario de \$$dailyLimit');
    }

    if (request.amount <= 0) {
      return Result.failure('El monto debe ser mayor a cero');
    }

    return Result.success(null);
  }

  double _calculateDailyTotal() {
    final today = DateTime.now();
    return _commandHistory
        .where((cmd) => cmd.timestamp.day == today.day && 
                        cmd.timestamp.month == today.month &&
                        cmd.timestamp.year == today.year)
        .fold(0.0, (sum, cmd) => sum + cmd.amount);
  }

  Future<Result<bool>> _authenticateUser() async {
    final AuthenticationStrategy strategy = _selectedAuthMethod == 'biometric'
        ? _biometricStrategy
        : _pinStrategy;

    final authenticated = await strategy.authenticate(
      reason: 'Autentícate para confirmar la transferencia de \$$_currentAmount'
    );

    if (!authenticated) {
      return Result.failure('Autenticación fallida. Intenta nuevamente.');
    }

    return Result.success(true);
  }

  Future<void> _executeTransfer() async {
    _state = TransferViewState.processing;
    notifyListeners();

    final command = TransferCommand(
      transferRequest: _pendingRequest!,
      onExecute: () => _transferFundsUseCase.execute(_pendingRequest!),
    );

    await _commandQueue.enqueue(command);
    _commandHistory.add(command);

    final result = await command.execute();

    result.when(
      success: (transaction) {
        _completedTransaction = transaction;
        _state = TransferViewState.success;
      },
      failure: (error) {
        _errorMessage = _mapErrorToMessage(error);
        _state = TransferViewState.error;
      }
    );

    notifyListeners();
  }

  void reset() {
    _state = TransferViewState.initial;
    _pendingRequest = null;
    _completedTransaction = null;
    _errorMessage = null;
    _currentAmount = 0.0;
    _targetAccountId = '';
    _transferDescription = '';
    notifyListeners();
  }

  String _mapErrorToMessage(String error) {
    if (error.contains('insufficient') || error.contains('saldo')) {
      return 'Saldo insuficiente para realizar la transferencia.';
    }
    if (error.contains('account') || error.contains('cuenta')) {
      return 'La cuenta de destino no es válida.';
    }
    if (error.contains('duplicate') || error.contains('duplicada')) {
      return 'Esta transferencia ya fue procesada.';
    }
    return 'Error al procesar la transferencia: $error';
  }
}

class TransferFormState extends Equatable {
  final double amount;
  final String targetAccountId;
  final String description;
  final bool isValid;

  const TransferFormState({
    this.amount = 0.0,
    this.targetAccountId = '',
    this.description = '',
    this.isValid = false,
  });

  TransferFormState copyWith({
    double? amount,
    String? targetAccountId,
    String? description,
    bool? isValid,
  }) {
    return TransferFormState(
      amount: amount ?? this.amount,
      targetAccountId: targetAccountId ?? this.targetAccountId,
      description: description ?? this.description,
      isValid: isValid ?? this.isValid,
    );
  }

  @override
  List<Object?> get props => [amount, targetAccountId, description, isValid];
}