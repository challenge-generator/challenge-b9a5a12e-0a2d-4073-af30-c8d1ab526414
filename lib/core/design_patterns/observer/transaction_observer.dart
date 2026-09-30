import 'package:mobile_banking_app/domain/entities/transaction.dart';
import 'package:mobile_banking_app/domain/entities/transfer_request.dart';
import 'package:mobile_banking_app/core/utils/result.dart';

abstract class TransactionObserver {
  void onTransactionCreated(Transaction transaction);
  void onTransactionCompleted(Transaction transaction);
  void onTransactionFailed(Transaction transaction, String reason);
  void onTransactionReversed(Transaction transaction, String reversalReason);
}

class TransactionObserverImpl implements TransactionObserver {
  final List<void Function(Transaction)> _createdCallbacks = [];
  final List<void Function(Transaction)> _completedCallbacks = [];
  final List<void Function(Transaction, String)> _failedCallbacks = [];
  final List<void Function(Transaction, String)> _reversedCallbacks = [];
  final Map<String, Transaction> _transactionCache = {};

  void registerCreatedCallback(void Function(Transaction) callback) {
    _createdCallbacks.add(callback);
  }

  void registerCompletedCallback(void Function(Transaction) callback) {
    _completedCallbacks.add(callback);
  }

  void registerFailedCallback(void Function(Transaction, String) callback) {
    _failedCallbacks.add(callback);
  }

  void registerReversedCallback(void Function(Transaction, String) callback) {
    _reversedCallbacks.add(callback);
  }

  @override
  void onTransactionCreated(Transaction transaction) {
    _transactionCache[transaction.id] = transaction;
    for (final callback in _createdCallbacks) {
      callback(transaction);
    }
  }

  @override
  void onTransactionCompleted(Transaction transaction) {
    final cached = _transactionCache[transaction.id];
    if (cached != null) {
      final completed = cached.copyWith(status: TransactionStatus.completed);
      _transactionCache[transaction.id] = completed;
    }
    for (final callback in _completedCallbacks) {
      callback(transaction);
    }
  }

  @override
  void onTransactionFailed(Transaction transaction, String reason) {
    final cached = _transactionCache[transaction.id];
    if (cached != null) {
      final failed = cached.copyWith(status: TransactionStatus.failed);
      _transactionCache[transaction.id] = failed;
    }
    for (final callback in _failedCallbacks) {
      callback(transaction, reason);
    }
  }

  @override
  void onTransactionReversed(Transaction transaction, String reversalReason) {
    final cached = _transactionCache[transaction.id];
    if (cached != null) {
      final reversed = cached.copyWith(status: TransactionStatus.reversed);
      _transactionCache[transaction.id] = reversed;
    }
    for (final callback in _reversedCallbacks) {
      callback(transaction, reversalReason);
    }
  }

  Transaction? getTransactionById(String id) {
    return _transactionCache[id];
  }

  List<Transaction> getRecentTransactions({int limit = 10}) {
    final sorted = _transactionCache.values.toList()
      ..sort((a, b) => b.timestamp.compareTo(a.timestamp));
    return sorted.take(limit).toList();
  }

  List<Transaction> getTransactionsByAccount(String accountId) {
    return _transactionCache.values
        .where((t) => t.accountId == accountId)
        .toList()
      ..sort((a, b) => b.timestamp.compareTo(a.timestamp));
  }

  void clearCache() {
    _transactionCache.clear();
  }

  void dispose() {
    _createdCallbacks.clear();
    _completedCallbacks.clear();
    _failedCallbacks.clear();
    _reversedCallbacks.clear();
    _transactionCache.clear();
  }
}

class TransactionAnalyticsObserver implements TransactionObserver {
  int _totalTransactions = 0;
  int _successfulTransactions = 0;
  int _failedTransactions = 0;
  double _totalAmount = 0.0;
  final Map<TransactionType, int> _countByType = {};

  @override
  void onTransactionCreated(Transaction transaction) {
    _totalTransactions++;
    _countByType[transaction.type] = (_countByType[transaction.type] ?? 0) + 1;
  }

  @override
  void onTransactionCompleted(Transaction transaction) {
    _successfulTransactions++;
    _totalAmount += transaction.amount;
  }

  @override
  void onTransactionFailed(Transaction transaction, String reason) {
    _failedTransactions++;
  }

  @override
  void onTransactionReversed(Transaction transaction, String reversalReason) {
    _successfulTransactions--;
    _totalAmount -= transaction.amount;
  }

  double get successRate {
    if (_totalTransactions == 0) return 0.0;
    return (_successfulTransactions / _totalTransactions) * 100;
  }

  double get averageTransactionAmount {
    if (_successfulTransactions == 0) return 0.0;
    return _totalAmount / _successfulTransactions;
  }

  int get totalTransactions => _totalTransactions;
  int get successfulTransactions => _successfulTransactions;
  int get failedTransactions => _failedTransactions;
  Map<TransactionType, int> get countByType => Map.unmodifiable(_countByType);
}