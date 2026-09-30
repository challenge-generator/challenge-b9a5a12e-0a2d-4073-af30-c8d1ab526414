import 'package:flutter/foundation.dart';
import 'package:equatable/equatable.dart';
import 'package:get_it/get_it.dart';
import '../../domain/entities/transaction.dart';
import '../../domain/usecases/get_transaction_history_usecase.dart';
import '../../core/utils/result.dart';
import '../../core/design_patterns/observer/transaction_observer.dart';

enum HistoryViewState { initial, loading, loaded, error }
enum TransactionFilter { all, credit, debit }
enum DateRangeFilter { all, today, week, month }

class HistoryViewModel extends ChangeNotifier implements TransactionObserver {
  final GetTransactionHistoryUseCase _getTransactionHistoryUseCase;
  
  HistoryViewState _state = HistoryViewState.initial;
  List<Transaction> _transactions = [];
  List<Transaction> _filteredTransactions = [];
  String? _errorMessage;
  TransactionFilter _currentFilter = TransactionFilter.all;
  DateRangeFilter _dateRangeFilter = DateRangeFilter.all;
  String _searchQuery = '';
  bool _isLoadingMore = false;
  int _currentPage = 0;
  static const int _pageSize = 20;

  HistoryViewModel({GetTransactionHistoryUseCase? getTransactionHistoryUseCase})
      : _getTransactionHistoryUseCase = getTransactionHistoryUseCase ?? 
          GetIt.I<GetTransactionHistoryUseCase>() {
    TransactionObserver.register(this);
  }

  HistoryViewState get state => _state;
  List<Transaction> get transactions => _filteredTransactions;
  List<Transaction> get allTransactions => _transactions;
  String? get errorMessage => _errorMessage;
  TransactionFilter get currentFilter => _currentFilter;
  DateRangeFilter get dateRangeFilter => _dateRangeFilter;
  String get searchQuery => _searchQuery;
  bool get isLoadingMore => _isLoadingMore;
  bool get hasMoreTransactions => _filteredTransactions.length >= _currentPage * _pageSize;
  bool get isEmpty => _transactions.isEmpty && _state == HistoryViewState.loaded;

  double get totalCredits {
    return _transactions
        .where((t) => t.type == TransactionType.credit && t.isSuccessful)
        .fold(0.0, (sum, t) => sum + t.amount);
  }

  double get totalDebits {
    return _transactions
        .where((t) => t.type == TransactionType.debit && t.isSuccessful)
        .fold(0.0, (sum, t) => sum + t.amount);
  }

  Map<DateTime, List<Transaction>> get transactionsByDate {
    final Map<DateTime, List<Transaction>> grouped = {};
    for (final transaction in _filteredTransactions) {
      final dateKey = DateTime(
        transaction.timestamp.year,
        transaction.timestamp.month,
        transaction.timestamp.day,
      );
      grouped.putIfAbsent(dateKey, () => []).add(transaction);
    }
    return grouped;
  }

  Future<void> loadTransactions({String? accountId, bool refresh = false}) async {
    if (_state == HistoryViewState.loading && !refresh) return;

    if (refresh) {
      _currentPage = 0;
      _transactions = [];
    }

    _state = HistoryViewState.loading;
    _errorMessage = null;
    notifyListeners();

    try {
      final accountIdToFetch = accountId ?? 'ACC-001';
      final result = await _getTransactionHistoryUseCase.execute(
        accountId: accountIdToFetch,
        page: _currentPage,
        pageSize: _pageSize,
      );
      
      result.when(
        success: (transactions) {
          if (refresh) {
            _transactions = transactions;
          } else {
            _transactions = [..._transactions, ...transactions];
          }
          _applyFilters();
          _state = HistoryViewState.loaded;
        },
        failure: (error) {
          _errorMessage = _mapErrorToMessage(error);
          _state = HistoryViewState.error;
        }
      );
    } catch (e) {
      _errorMessage = 'Error inesperado al cargar el historial';
      _state = HistoryViewState.error;
    }
    
    notifyListeners();
  }

  Future<void> loadMoreTransactions({String? accountId}) async {
    if (_isLoadingMore || !hasMoreTransactions) return;
    
    _isLoadingMore = true;
    notifyListeners();

    _currentPage++;
    await loadTransactions(accountId: accountId);

    _isLoadingMore = false;
    notifyListeners();
  }

  void setFilter(TransactionFilter filter) {
    _currentFilter = filter;
    _applyFilters();
    notifyListeners();
  }

  void setDateRangeFilter(DateRangeFilter filter) {
    _dateRangeFilter = filter;
    _applyFilters();
    notifyListeners();
  }

  void setSearchQuery(String query) {
    _searchQuery = query.toLowerCase();
    _applyFilters();
    notifyListeners();
  }

  void _applyFilters() {
    var filtered = List<Transaction>.from(_transactions);

    if (_currentFilter != TransactionFilter.all) {
      final targetType = _currentFilter == TransactionFilter.credit
          ? TransactionType.credit
          : TransactionType.debit;
      filtered = filtered.where((t) => t.type == targetType).toList();
    }

    if (_dateRangeFilter != DateRangeFilter.all) {
      final now = DateTime.now();
      final DateTime startDate;
      
      switch (_dateRangeFilter) {
        case DateRangeFilter.today:
          startDate = DateTime(now.year, now.month, now.day);
          break;
        case DateRangeFilter.week:
          startDate = now.subtract(const Duration(days: 7));
          break;
        case DateRangeFilter.month:
          startDate = DateTime(now.year, now.month - 1, now.day);
          break;
        default:
          startDate = DateTime(1970);
      }
      
      filtered = filtered.where((t) => t.timestamp.isAfter(startDate)).toList();
    }

    if (_searchQuery.isNotEmpty) {
      filtered = filtered.where((t) =>
          t.description.toLowerCase().contains(_searchQuery) ||
          (t.referenceNumber?.toLowerCase().contains(_searchQuery) ?? false) ||
          t.id.toLowerCase().contains(_searchQuery)).toList();
    }

    filtered.sort((a, b) => b.timestamp.compareTo(a.timestamp));
    _filteredTransactions = filtered;
  }

  void clearFilters() {
    _currentFilter = TransactionFilter.all;
    _dateRangeFilter = DateRangeFilter.all;
    _searchQuery = '';
    _applyFilters();
    notifyListeners();
  }

  @override
  void onTransactionCreated(Transaction transaction) {
    _transactions.insert(0, transaction);
    _applyFilters();
    notifyListeners();
  }

  @override
  void onTransactionUpdated(Transaction transaction) {
    final index = _transactions.indexWhere((t) => t.id == transaction.id);
    if (index != -1) {
      _transactions[index] = transaction;
      _applyFilters();
      notifyListeners();
    }
  }

  @override
  void dispose() {
    TransactionObserver.unregister(this);
    super.dispose();
  }

  String _mapErrorToMessage(String error) {
    if (error.contains('network') || error.contains('conexión')) {
      return 'Error de conexión. Verifica tu red e intenta nuevamente.';
    }
    if (error.contains('timeout') || error.contains('tiempo')) {
      return 'La operación tardó demasiado. Intenta en unos segundos.';
    }
    return 'Error al cargar el historial: $error';
  }
}

class HistoryViewModelState extends Equatable {
  final HistoryViewState state;
  final List<Transaction> transactions;
  final String? errorMessage;
  final TransactionFilter filter;
  final DateRangeFilter dateRange;
  final bool isLoadingMore;

  const HistoryViewModelState({
    required this.state,
    this.transactions = const [],
    this.errorMessage,
    this.filter = TransactionFilter.all,
    this.dateRange = DateRangeFilter.all,
    this.isLoadingMore = false,
  });

  @override
  List<Object?> get props => [state, transactions, errorMessage, filter, dateRange, isLoadingMore];
}