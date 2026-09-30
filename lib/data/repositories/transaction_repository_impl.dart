package mobile_banking_app.data.repositories;

import 'package:mobile_banking_app/data/datasources/remote/transaction_remote_datasource.dart';
import 'package:mobile_banking_app/data/models/transaction_model.dart';
import 'package:mobile_banking_app/domain/repositories/transaction_repository.dart';
import 'package:mobile_banking_app/core/utils/result.dart';

class TransactionRepositoryImpl implements TransactionRepository {
  final TransactionRemoteDataSource remoteDataSource;

  TransactionRepositoryImpl({required this.remoteDataSource});

  @override
  Future<Result<TransactionModel>> getTransactionById(String transactionId) async {
    try {
      final transaction = await remoteDataSource.fetchTransaction(transactionId);
      if (transaction == null) {
        return Result.failure(Exception('Transacción no encontrada'));
      }
      return Result.success(transaction);
    } catch (e) {
      return Result.failure(e);
    }
  }

  @override
  Future<Result<List<TransactionModel>>> getTransactionsByAccountId(
    String accountId, {
    int limit = 50,
    int offset = 0,
  }) async {
    try {
      final transactions = await remoteDataSource.fetchTransactionsByAccount(
        accountId,
        limit: limit,
        offset: offset,
      );
      return Result.success(transactions);
    } catch (e) {
      return Result.failure(e);
    }
  }

  @override
  Future<Result<List<TransactionModel>>> getTransactionHistory(
    String accountId, {
    DateTime? startDate,
    DateTime? endDate,
    TransactionStatusModel? status,
  }) async {
    try {
      var transactions = await remoteDataSource.fetchTransactionsByAccount(
        accountId,
        limit: 100,
        offset: 0,
      );

      if (startDate != null) {
        transactions = transactions
            .where((t) => t.timestamp.isAfter(startDate))
            .toList();
      }

      if (endDate != null) {
        transactions = transactions
            .where((t) => t.timestamp.isBefore(endDate))
            .toList();
      }

      if (status != null) {
        transactions = transactions
            .where((t) => t.status == status)
            .toList();
      }

      transactions.sort((a, b) => b.timestamp.compareTo(a.timestamp));

      return Result.success(transactions);
    } catch (e) {
      return Result.failure(e);
    }
  }

  @override
  Future<Result<TransactionModel>> createTransaction(
    TransactionModel transaction,
  ) async {
    try {
      final createdTransaction = await remoteDataSource.createTransaction(transaction);
      return Result.success(createdTransaction);
    } catch (e) {
      return Result.failure(e);
    }
  }

  @override
  Future<Result<TransactionModel>> updateTransactionStatus(
    String transactionId,
    TransactionStatusModel newStatus,
  ) async {
    try {
      final transaction = await remoteDataSource.fetchTransaction(transactionId);
      if (transaction == null) {
        return Result.failure(Exception('Transacción no encontrada'));
      }

      final updatedTransaction = transaction.copyWith(status: newStatus);
      final result = await remoteDataSource.updateTransaction(updatedTransaction);
      return Result.success(result);
    } catch (e) {
      return Result.failure(e);
    }
  }

  @override
  Future<Result<bool>> checkIdempotency(
    String accountId,
    String referenceNumber,
    String channel,
  ) async {
    try {
      final transactions = await remoteDataSource.fetchTransactionsByAccount(
        accountId,
        limit: 100,
        offset: 0,
      );

      final existingTransaction = transactions.where(
        (t) =>
            t.referenceNumber == referenceNumber &&
            t.allowedChannels.contains(channel),
      );

      return Result.success(existingTransaction.isNotEmpty);
    } catch (e) {
      return Result.failure(e);
    }
  }

  @override
  Future<Result<List<TransactionModel>>> getPendingTransactions(
    String accountId,
  ) async {
    try {
      final transactions = await remoteDataSource.fetchTransactionsByAccount(
        accountId,
        limit: 50,
        offset: 0,
      );

      final pendingTransactions = transactions
          .where((t) => t.status == TransactionStatusModel.pending)
          .toList();

      return Result.success(pendingTransactions);
    } catch (e) {
      return Result.failure(e);
    }
  }

  @override
  Future<Result<TransactionModel>> reverseTransaction(
    String transactionId,
    String reason,
  ) async {
    try {
      final originalTransaction = await remoteDataSource.fetchTransaction(transactionId);
      if (originalTransaction == null) {
        return Result.failure(Exception('Transacción no encontrada'));
      }

      if (originalTransaction.status != TransactionStatusModel.completed) {
        return Result.failure(
          Exception('Solo se pueden revertir transacciones completadas'),
        );
      }

      final reversedTransaction = TransactionModel(
        id: 'rev_${DateTime.now().millisecondsSinceEpoch}',
        accountId: originalTransaction.accountId,
        amount: originalTransaction.amount,
        type: originalTransaction.type == TransactionTypeModel.credit
            ? TransactionTypeModel.debit
            : TransactionTypeModel.credit,
        description: 'Reversión: $reason',
        timestamp: DateTime.now(),
        status: TransactionStatusModel.reversed,
        referenceNumber: 'REV_${originalTransaction.referenceNumber}',
        relatedTransactionId: transactionId,
      );

      final created = await remoteDataSource.createTransaction(reversedTransaction);
      return Result.success(created);
    } catch (e) {
      return Result.failure(e);
    }
  }
}