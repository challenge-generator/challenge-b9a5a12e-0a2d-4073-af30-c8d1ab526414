package mobile_banking_app.core.design_patterns.factory;

import 'package:mobile_banking_app/domain/entities/transaction.dart';
import 'package:mobile_banking_app/core/utils/result.dart';
import 'package:uuid/uuid.dart';

class TransactionFactory {
  static final TransactionFactory _instance = TransactionFactory._internal();
  final Uuid _uuid = const Uuid();
  
  TransactionFactory._internal();
  
  static TransactionFactory get instance {
    return _instance;
  }
  
  Result<Transaction> createCreditTransaction({
    required String accountId,
    required double amount,
    required String description,
    String? referenceNumber,
  }) {
    try {
      if (amount <= 0) {
        return Result.failure(
          ArgumentError('El monto debe ser mayor a cero'),
        );
      }
      
      final transaction = Transaction(
        id: _uuid.v4(),
        accountId: accountId,
        amount: amount,
        type: TransactionType.credit,
        description: description,
        timestamp: DateTime.now(),
        status: TransactionStatus.pending,
        referenceNumber: referenceNumber ?? _generateReferenceNumber(),
      );
      
      return Result.success(transaction);
    } catch (e) {
      return Result.failure(e);
    }
  }
  
  Result<Transaction> createDebitTransaction({
    required String accountId,
    required double amount,
    required String description,
    String? referenceNumber,
  }) {
    try {
      if (amount <= 0) {
        return Result.failure(
          ArgumentError('El monto debe ser mayor a cero'),
        );
      }
      
      final transaction = Transaction(
        id: _uuid.v4(),
        accountId: accountId,
        amount: amount,
        type: TransactionType.debit,
        description: description,
        timestamp: DateTime.now(),
        status: TransactionStatus.pending,
        referenceNumber: referenceNumber ?? _generateReferenceNumber(),
      );
      
      return Result.success(transaction);
    } catch (e) {
      return Result.failure(e);
    }
  }
  
  Result<Transaction> createTransferTransaction({
    required String accountId,
    required double amount,
    required String description,
    required String relatedTransactionId,
    required TransactionType type,
    String? referenceNumber,
  }) {
    try {
      if (amount <= 0) {
        return Result.failure(
          ArgumentError('El monto debe ser mayor a cero'),
        );
      }
      
      if (type != TransactionType.credit && type != TransactionType.debit) {
        return Result.failure(
          ArgumentError('Tipo de transacción inválido para transferencia'),
        );
      }
      
      final transaction = Transaction(
        id: _uuid.v4(),
        accountId: accountId,
        amount: amount,
        type: type,
        description: description,
        timestamp: DateTime.now(),
        status: TransactionStatus.pending,
        referenceNumber: referenceNumber ?? _generateReferenceNumber(),
        relatedTransactionId: relatedTransactionId,
      );
      
      return Result.success(transaction);
    } catch (e) {
      return Result.failure(e);
    }
  }
  
  Result<Transaction> createPendingTransaction({
    required String accountId,
    required double amount,
    required TransactionType type,
    required String description,
    String? referenceNumber,
  }) {
    try {
      final transaction = Transaction(
        id: _uuid.v4(),
        accountId: accountId,
        amount: amount,
        type: type,
        description: description,
        timestamp: DateTime.now(),
        status: TransactionStatus.pending,
        referenceNumber: referenceNumber ?? _generateReferenceNumber(),
      );
      
      return Result.success(transaction);
    } catch (e) {
      return Result.failure(e);
    }
  }
  
  Result<Transaction> createReversedTransaction(Transaction originalTransaction) {
    try {
      final reversedType = originalTransaction.type == TransactionType.credit
          ? TransactionType.debit
          : TransactionType.credit;
      
      final transaction = Transaction(
        id: _uuid.v4(),
        accountId: originalTransaction.accountId,
        amount: originalTransaction.amount,
        type: reversedType,
        description: 'Reversión de: ${originalTransaction.description}',
        timestamp: DateTime.now(),
        status: TransactionStatus.reversed,
        referenceNumber: _generateReferenceNumber(),
        relatedTransactionId: originalTransaction.id,
      );
      
      return Result.success(transaction);
    } catch (e) {
      return Result.failure(e);
    }
  }
  
  String _generateReferenceNumber() {
    final timestamp = DateTime.now().millisecondsSinceEpoch;
    final uuidShort = _uuid.v4().substring(0, 8);
    return 'TXN-$timestamp-$uuidShort';
  }
  
  Transaction createFailedTransaction(Transaction originalTransaction) {
    return originalTransaction.copyWith(
      status: TransactionStatus.failed,
    );
  }
  
  Transaction createCompletedTransaction(Transaction pendingTransaction) {
    return pendingTransaction.copyWith(
      status: TransactionStatus.completed,
    );
  }
  
  bool isValidTransactionType(String type) {
    return type == 'credit' || type == 'debit';
  }
  
  TransactionType parseTransactionType(String type) {
    switch (type.toLowerCase()) {
      case 'credit':
        return TransactionType.credit;
      case 'debit':
        return TransactionType.debit;
      default:
        throw ArgumentError('Tipo de transacción desconocido: $type');
    }
  }
  
  TransactionStatus parseTransactionStatus(String status) {
    switch (status.toLowerCase()) {
      case 'pending':
        return TransactionStatus.pending;
      case 'completed':
        return TransactionStatus.completed;
      case 'failed':
        return TransactionStatus.failed;
      case 'reversed':
        return TransactionStatus.reversed;
      default:
        throw ArgumentError('Estado de transacción desconocido: $status');
    }
  }
}