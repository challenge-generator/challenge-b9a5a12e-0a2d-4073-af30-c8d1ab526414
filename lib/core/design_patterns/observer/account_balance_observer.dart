import 'package:mobile_banking_app/domain/entities/account.dart';
import 'package:mobile_banking_app/domain/entities/transaction.dart';
import 'package:mobile_banking_app/core/utils/result.dart';

abstract class AccountBalanceObserver {
  void onBalanceChanged(Account account, double oldBalance, double newBalance);
  void onLowBalanceWarning(Account account, double threshold);
  void onHighValueTransaction(Account account, Transaction transaction);
}

class AccountBalanceObserverImpl implements AccountBalanceObserver {
  final List<void Function(Account, double, double)> _balanceChangeCallbacks = [];
  final List<void Function(Account, double)> _lowBalanceCallbacks = [];
  final List<void Function(Account, Transaction)> _highValueCallbacks = [];
  final double _lowBalanceThreshold;
  final double _highValueThreshold;

  AccountBalanceObserverImpl({
    double lowBalanceThreshold = 100.0,
    double highValueThreshold = 5000.0,
  })  : _lowBalanceThreshold = lowBalanceThreshold,
        _highValueThreshold = highValueThreshold;

  void registerBalanceChangeCallback(void Function(Account, double, double) callback) {
    _balanceChangeCallbacks.add(callback);
  }

  void registerLowBalanceCallback(void Function(Account, double) callback) {
    _lowBalanceCallbacks.add(callback);
  }

  void registerHighValueCallback(void Function(Account, Transaction) callback) {
    _highValueCallbacks.add(callback);
  }

  void unregisterBalanceChangeCallback(void Function(Account, double, double) callback) {
    _balanceChangeCallbacks.remove(callback);
  }

  void unregisterLowBalanceCallback(void Function(Account, double) callback) {
    _lowBalanceCallbacks.remove(callback);
  }

  void unregisterHighValueCallback(void Function(Account, Transaction) callback) {
    _highValueCallbacks.remove(callback);
  }

  @override
  void onBalanceChanged(Account account, double oldBalance, double newBalance) {
    for (final callback in _balanceChangeCallbacks) {
      callback(account, oldBalance, newBalance);
    }
    if (newBalance < _lowBalanceThreshold && oldBalance >= _lowBalanceThreshold) {
      onLowBalanceWarning(account, _lowBalanceThreshold);
    }
  }

  @override
  void onLowBalanceWarning(Account account, double threshold) {
    for (final callback in _lowBalanceCallbacks) {
      callback(account, threshold);
    }
  }

  @override
  void onHighValueTransaction(Account account, Transaction transaction) {
    if (transaction.amount.abs() >= _highValueThreshold) {
      for (final callback in _highValueCallbacks) {
        callback(account, transaction);
      }
    }
  }

  void notifyBalanceFromTransaction(Account account, Transaction transaction) {
    final oldBalance = account.balance;
    final result = account.applyTransaction(transaction);
    if (result is Success<Account>) {
      final newAccount = result.data;
      onBalanceChanged(newAccount, oldBalance, newAccount.balance);
      onHighValueTransaction(newAccount, transaction);
    }
  }

  void dispose() {
    _balanceChangeCallbacks.clear();
    _lowBalanceCallbacks.clear();
    _highValueCallbacks.clear();
  }
}

class CompositeAccountBalanceObserver implements AccountBalanceObserver {
  final List<AccountBalanceObserver> _observers = [];

  void addObserver(AccountBalanceObserver observer) {
    _observers.add(observer);
  }

  void removeObserver(AccountBalanceObserver observer) {
    _observers.remove(observer);
  }

  @override
  void onBalanceChanged(Account account, double oldBalance, double newBalance) {
    for (final observer in _observers) {
      observer.onBalanceChanged(account, oldBalance, newBalance);
    }
  }

  @override
  void onLowBalanceWarning(Account account, double threshold) {
    for (final observer in _observers) {
      observer.onLowBalanceWarning(account, threshold);
    }
  }

  @override
  void onHighValueTransaction(Account account, Transaction transaction) {
    for (final observer in _observers) {
      observer.onHighValueTransaction(account, transaction);
    }
  }
}