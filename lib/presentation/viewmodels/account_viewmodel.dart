import 'package:flutter/foundation.dart';
import 'package:equatable/equatable.dart';
import 'package:get_it/get_it.dart';
import '../../domain/entities/account.dart';
import '../../domain/entities/transaction.dart';
import '../../domain/usecases/get_balance_usecase.dart';
import '../../core/utils/result.dart';
import '../../core/design_patterns/observer/account_balance_observer.dart';

enum AccountViewState { initial, loading, loaded, error }

class AccountViewModel extends ChangeNotifier implements AccountBalanceObserver {
  final GetBalanceUseCase _getBalanceUseCase;
  
  AccountViewState _state = AccountViewState.initial;
  Account? _account;
  String? _errorMessage;
  DateTime? _lastRefresh;
  bool _isRefreshing = false;

  AccountViewModel({GetBalanceUseCase? getBalanceUseCase})
      : _getBalanceUseCase = getBalanceUseCase ?? GetIt.I<GetBalanceUseCase>() {
    AccountBalanceObserver.register(this);
  }

  AccountViewState get state => _state;
  Account? get account => _account;
  String? get errorMessage => _errorMessage;
  DateTime? get lastRefresh => _lastRefresh;
  bool get isRefreshing => _isRefreshing;
  bool get hasAccount => _account != null;
  bool get canRefresh => _state != AccountViewState.loading && !_isRefreshing;

  String get formattedBalance {
    if (_account == null) return '—';
    return '${_account!.currency} ${_account!.balance.toStringAsFixed(2)}';
  }

  Future<void> loadAccount({String? accountId}) async {
    if (_state == AccountViewState.loading) return;
    
    _state = AccountViewState.loading;
    _errorMessage = null;
    notifyListeners();

    try {
      final accountIdToFetch = accountId ?? _account?.id ?? 'ACC-001';
      final result = await _getBalanceUseCase.execute(accountIdToFetch);
      
      result.when(
        success: (account) {
          _account = account;
          _lastRefresh = DateTime.now();
          _state = AccountViewState.loaded;
        },
        failure: (error) {
          _errorMessage = _mapErrorToMessage(error);
          _state = AccountViewState.error;
        }
      );
    } catch (e) {
      _errorMessage = 'Error inesperado al cargar la cuenta';
      _state = AccountViewState.error;
    }
    
    notifyListeners();
  }

  Future<void> refreshAccount() async {
    if (!canRefresh) return;
    
    _isRefreshing = true;
    notifyListeners();

    await loadAccount();
    
    _isRefreshing = false;
    notifyListeners();
  }

  bool canPerformTransfer(String channel) {
    return _account?.canPerformTransfer(channel) ?? false;
  }

  Result<Account> applyTransaction(Transaction transaction) {
    if (_account == null) {
      return Result.failure('No hay cuenta cargada');
    }
    final result = _account!.applyTransaction(transaction);
    notifyListeners();
    return result;
  }

  @override
  void onBalanceChanged(Account account, double oldBalance, double newBalance) {
    _account = account;
    notifyListeners();
  }

  @override
  void onTransactionApplied(Transaction transaction) {
    if (_account != null && transaction.accountId == _account!.id) {
      final result = _account!.applyTransaction(transaction);
      result.when(
        success: (updatedAccount) {
          _account = updatedAccount;
          notifyListeners();
        },
        failure: (_) {}
      );
    }
  }

  @override
  void dispose() {
    AccountBalanceObserver.unregister(this);
    super.dispose();
  }

  String _mapErrorToMessage(String error) {
    if (error.contains('network') || error.contains('conexión')) {
      return 'Error de conexión. Verifica tu red e intenta nuevamente.';
    }
    if (error.contains('timeout') || error.contains('tiempo')) {
      return 'La operación tardó demasiado. Intenta en unos segundos.';
    }
    if (error.contains('not found') || error.contains('no encontrada')) {
      return 'Cuenta no encontrada.';
    }
    return 'Error al cargar la cuenta: $error';
  }
}

class AccountViewModelState extends Equatable {
  final AccountViewState state;
  final Account? account;
  final String? errorMessage;
  final DateTime? lastRefresh;
  final bool isRefreshing;

  const AccountViewModelState({
    required this.state,
    this.account,
    this.errorMessage,
    this.lastRefresh,
    this.isRefreshing = false,
  });

  @override
  List<Object?> get props => [state, account, errorMessage, lastRefresh, isRefreshing];
}