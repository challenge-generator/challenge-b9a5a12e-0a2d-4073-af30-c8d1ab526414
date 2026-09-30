import 'package:equatable/equatable.dart';
import '../../core/utils/result.dart';
import '../entities/transaction.dart';

abstract class TransactionRepository extends Equatable {
  const TransactionRepository();

  Future<Result<Transaction>> getTransactionById(String transactionId);

  Future<Result<List<Transaction>>> getTransactionsByAccount(
    String accountId, {
    DateTime? startDate,
    DateTime? endDate,
    int? limit,
    int? offset,
  });

  Future<Result<Transaction>> createTransaction(Transaction transaction);

  Future<Result<Transaction>> updateTransactionStatus(
    String transactionId,
    TransactionStatus newStatus,
  );

  Future<Result<bool>> validateIdempotency(
    String referenceNumber,
    String channel,
  );

  Future<Result<Transaction?>> findByReferenceNumber(
    String referenceNumber,
    String channel,
  );

  Future<Result<List<Transaction>>> getPendingTransactions(String accountId);

  Future<Result<Transaction>> reverseTransaction(
    String transactionId,
    String reason,
  );
}

class TransactionRepositoryImpl implements TransactionRepository {
  final TransactionRemoteDataSource remoteDataSource;

  const TransactionRepositoryImpl({required this.remoteDataSource});

  @override
  Future<Result<Transaction>> getTransactionById(String transactionId) async {
    try {
      final transactionModel = await remoteDataSource.getTransactionById(transactionId);
      final transaction = transactionModel.toEntity();
      return Result.success(transaction);
    } on NetworkException catch (e) {
      return Result.failure(e);
    } on ServerException catch (e) {
      return Result.failure(e);
    } catch (e) {
      return Result.failure(UnexpectedException('Error al obtener transacción: $e'));
    }
  }

  @override
  Future<Result<List<Transaction>>> getTransactionsByAccount(
    String accountId, {
    DateTime? startDate,
    DateTime? endDate,
    int? limit,
    int? offset,
  }) async {
    try {
      final transactions = await remoteDataSource.getTransactionsByAccount(
        accountId,
        startDate: startDate,
        endDate: endDate,
        limit: limit,
        offset: offset,
      );
      return Result.success(transactions.map((m) => m.toEntity()).toList());
    } on NetworkException catch (e) {
      return Result.failure(e);
    } on ServerException catch (e) {
      return Result.failure(e);
    } catch (e) {
      return Result.failure(UnexpectedException('Error al obtener transacciones: $e'));
    }
  }

  @override
  Future<Result<Transaction>> createTransaction(Transaction transaction) async {
    try {
      final transactionModel = TransactionModel.fromEntity(transaction);
      final createdModel = await remoteDataSource.createTransaction(transactionModel);
      final created = createdModel.toEntity();
      return Result.success(created);
    } on NetworkException catch (e) {
      return Result.failure(e);
    } on ServerException catch (e) {
      return Result.failure(e);
    } catch (e) {
      return Result.failure(UnexpectedException('Error al crear transacción: $e'));
    }
  }

  @override
  Future<Result<Transaction>> updateTransactionStatus(
    String transactionId,
    TransactionStatus newStatus,
  ) async {
    try {
      final updatedModel = await remoteDataSource.updateTransactionStatus(
        transactionId,
        newStatus.name,
      );
      final updated = updatedModel.toEntity();
      return Result.success(updated);
    } on NetworkException catch (e) {
      return Result.failure(e);
    } on ServerException catch (e) {
      return Result.failure(e);
    } catch (e) {
      return Result.failure(UnexpectedException('Error al actualizar estado: $e'));
    }
  }

  @override
  Future<Result<bool>> validateIdempotency(
    String referenceNumber,
    String channel,
  ) async {
    try {
      final existing = await remoteDataSource.findByReferenceAndChannel(
        referenceNumber,
        channel,
      );
      return Result.success(existing != null);
    } catch (e) {
      return Result.failure(UnexpectedException('Error al validar idempotencia: $e'));
    }
  }

  @override
  Future<Result<Transaction?>> findByReferenceNumber(
    String referenceNumber,
    String channel,
  ) async {
    try {
      final transactionModel = await remoteDataSource.findByReferenceAndChannel(
        referenceNumber,
        channel,
      );
      if (transactionModel == null) {
        return Result.success(null);
      }
      return Result.success(transactionModel.toEntity());
    } catch (e) {
      return Result.failure(UnexpectedException('Error al buscar por referencia: $e'));
    }
  }

  @override
  Future<Result<List<Transaction>>> getPendingTransactions(String accountId) async {
    final allTransactions = await getTransactionsByAccount(accountId);
    return allTransactions.when(
      success: (transactions) {
        final pending = transactions
            .where((t) => t.status == TransactionStatus.pending)
            .toList();
        return Result.success(pending);
      },
      failure: (error) => Result.failure(error),
    );
  }

  @override
  Future<Result<Transaction>> reverseTransaction(
    String transactionId,
    String reason,
  ) async {
    final transactionResult = await getTransactionById(transactionId);
    return transactionResult.when(
      success: (transaction) async {
        if (!transaction.isSuccessful) {
          return Result.failure(
            const UnexpectedException('Solo se pueden revertir transacciones exitosas'),
          );
        }
        try {
          final reversedModel = await remoteDataSource.reverseTransaction(
            transactionId,
            reason,
          );
          return Result.success(reversedModel.toEntity());
        } catch (e) {
          return Result.failure(UnexpectedException('Error al revertir transacción: $e'));
        }
      },
      failure: (error) => Result.failure(error),
    );
  }

  @override
  List<Object?> get props => [remoteDataSource];
}

class NetworkException implements Exception {
  final String message;
  const NetworkException(this.message);
  @override
  String toString() => 'NetworkException: $message';
}

class ServerException implements Exception {
  final String message;
  final int? statusCode;
  const ServerException(this.message, {this.statusCode});
  @override
  String toString() => 'ServerException: $message (status: $statusCode)';
}

class UnexpectedException implements Exception {
  final String message;
  const UnexpectedException(this.message);
  @override
  String toString() => 'UnexpectedException: $message';
}

abstract class TransactionRemoteDataSource {
  Future<TransactionModel> getTransactionById(String transactionId);
  Future<List<TransactionModel>> getTransactionsByAccount(
    String accountId, {
    DateTime? startDate,
    DateTime? endDate,
    int? limit,
    int? offset,
  });
  Future<TransactionModel> createTransaction(TransactionModel transaction);
  Future<TransactionModel> updateTransactionStatus(
    String transactionId,
    String newStatus,
  );
  Future<TransactionModel?> findByReferenceAndChannel(
    String referenceNumber,
    String channel,
  );
  Future<TransactionModel> reverseTransaction(
    String transactionId,
    String reason,
  );
}

class TransactionModel {
  final String id;
  final String accountId;
  final double amount;
  final String type;
  final String description;
  final DateTime timestamp;
  final String status;
  final String? referenceNumber;
  final String? relatedTransactionId;

  const TransactionModel({
    required this.id,
    required this.accountId,
    required this.amount,
    required this.type,
    required this.description,
    required this.timestamp,
    required this.status,
    this.referenceNumber,
    this.relatedTransactionId,
  });

  factory TransactionModel.fromEntity(Transaction transaction) {
    return TransactionModel(
      id: transaction.id,
      accountId: transaction.accountId,
      amount: transaction.amount,
      type: transaction.type.name,
      description: transaction.description,
      timestamp: transaction.timestamp,
      status: transaction.status.name,
      referenceNumber: transaction.referenceNumber,
      relatedTransactionId: transaction.relatedTransactionId,
    );
  }

  Transaction toEntity() {
    return Transaction(
      id: id,
      accountId: accountId,
      amount: amount,
      type: TransactionType.values.firstWhere((e) => e.name == type),
      description: description,
      timestamp: timestamp,
      status: TransactionStatus.values.firstWhere((e) => e.name == status),
      referenceNumber: referenceNumber,
      relatedTransactionId: relatedTransactionId,
    );
  }
}