import 'package:equatable/equatable.dart';
import '../../core/utils/result.dart';
import '../entities/transaction.dart';
import '../repositories/transaction_repository.dart';

class GetTransactionHistoryParams extends Equatable {
  final String accountId;
  final DateTime? startDate;
  final DateTime? endDate;
  final TransactionType? type;
  final TransactionStatus? status;
  final int? limit;
  final int? offset;

  const GetTransactionHistoryParams({
    required this.accountId,
    this.startDate,
    this.endDate,
    this.type,
    this.status,
    this.limit,
    this.offset,
  });

  @override
  List<Object?> get props => [
        accountId,
        startDate,
        endDate,
        type,
        status,
        limit,
        offset,
      ];
}

class TransactionHistoryResult extends Equatable {
  final List<Transaction> transactions;
  final int totalCount;
  final bool hasMore;
  final DateTime? oldestTransactionDate;
  final DateTime? newestTransactionDate;

  const TransactionHistoryResult({
    required this.transactions,
    required this.totalCount,
    required this.hasMore,
    this.oldestTransactionDate,
    this.newestTransactionDate,
  });

  @override
  List<Object?> get props => [
        transactions,
        totalCount,
        hasMore,
        oldestTransactionDate,
        newestTransactionDate,
      ];
}

class GetTransactionHistoryUseCase {
  final TransactionRepository _transactionRepository;
  static const int defaultLimit = 20;
  static const int maxLimit = 100;

  GetTransactionHistoryUseCase({
    required TransactionRepository transactionRepository,
  }) : _transactionRepository = transactionRepository;

  Future<Result<TransactionHistoryResult>> call(
    GetTransactionHistoryParams params,
  ) async {
    if (params.accountId.isEmpty) {
      return Result.failure(
        const ValidationError('El ID de cuenta no puede estar vacío'),
      );
    }

    if (params.startDate != null &&
        params.endDate != null &&
        params.startDate!.isAfter(params.endDate!)) {
      return Result.failure(
        const ValidationError(
          'La fecha de inicio no puede ser posterior a la fecha fin',
        ),
      );
    }

    final effectiveLimit = _calculateEffectiveLimit(params.limit);
    final effectiveOffset = params.offset ?? 0;

    try {
      final fetchResult = await _transactionRepository.getTransactions(
        accountId: params.accountId,
        startDate: params.startDate,
        endDate: params.endDate,
        type: params.type,
        status: params.status,
        limit: effectiveLimit,
        offset: effectiveOffset,
      );

      return fetchResult.when(
        success: (transactions) {
          final sortedTransactions = List<Transaction>.from(transactions)
            ..sort((a, b) => b.timestamp.compareTo(a.timestamp));

          final hasMore = sortedTransactions.length >= effectiveLimit;
          final resultTransactions = hasMore
              ? sortedTransactions.sublist(0, effectiveLimit)
              : sortedTransactions;

          final oldestDate = resultTransactions.isNotEmpty
              ? resultTransactions.last.timestamp
              : null;
          final newestDate = resultTransactions.isNotEmpty
              ? resultTransactions.first.timestamp
              : null;

          return Result.success(
            TransactionHistoryResult(
              transactions: resultTransactions,
              totalCount: resultTransactions.length,
              hasMore: hasMore,
              oldestTransactionDate: oldestDate,
              newestTransactionDate: newestDate,
            ),
          );
        },
        failure: (error) => Result.failure(error),
      );
    } on NetworkException catch (e) {
      return Result.failure(e);
    } on ServerException catch (e) {
      return Result.failure(e);
    } catch (e) {
      return Result.failure(
        UnexpectedError('Error inesperado al obtener historial: $e'),
      );
    }
  }

  int _calculateEffectiveLimit(int? requestedLimit) {
    if (requestedLimit == null || requestedLimit <= 0) {
      return defaultLimit;
    }
    return requestedLimit > maxLimit ? maxLimit : requestedLimit;
  }

  Future<Result<List<Transaction>>> getRecentTransactions(
    String accountId, {
    int count = 5,
  }) async {
    final params = GetTransactionHistoryParams(
      accountId: accountId,
      limit: count,
      status: TransactionStatus.completed,
    );

    final result = await call(params);
    return result.when(
      success: (history) => Result.success(history.transactions),
      failure: (error) => Result.failure(error),
    );
  }

  Future<Result<Map<TransactionType, double>>> getTotalByType(
    String accountId, {
    DateTime? startDate,
    DateTime? endDate,
  }) async {
    final params = GetTransactionHistoryParams(
      accountId: accountId,
      startDate: startDate,
      endDate: endDate,
      status: TransactionStatus.completed,
    );

    final result = await call(params);
    return result.when(
      success: (history) {
        final totals = <TransactionType, double>{};
        for (final transaction in history.transactions) {
          totals[transaction.type] =
              (totals[transaction.type] ?? 0) + transaction.amount;
        }
        return Result.success(totals);
      },
      failure: (error) => Result.failure(error),
    );
  }
}

class ValidationError implements Exception {
  final String message;
  const ValidationError(this.message);

  @override
  String toString() => message;
}

class NetworkException implements Exception {
  final String message;
  final int? statusCode;
  const NetworkException(this.message, {this.statusCode});

  @override
  String toString() => 'NetworkException: $message (status: $statusCode)';
}

class ServerException implements Exception {
  final String message;
  final int? statusCode;
  const ServerException(this.message, {this.statusCode});

  @override
  String toString() => 'ServerException: $message (status: $statusCode)';
}

class UnexpectedError implements Exception {
  final String message;
  const UnexpectedError(this.message);

  @override
  String toString() => message;
}