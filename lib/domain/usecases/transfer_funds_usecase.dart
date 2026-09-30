import 'package:equatable/equatable.dart';
import 'package:uuid/uuid.dart';
import '../../core/utils/result.dart';
import '../entities/account.dart';
import '../entities/transaction.dart';
import '../entities/transfer_request.dart';
import '../repositories/account_repository.dart';
import '../repositories/transaction_repository.dart';

class TransferFundsUseCase extends Equatable {
  final AccountRepository accountRepository;
  final TransactionRepository transactionRepository;
  final Uuid uuid;

  const TransferFundsUseCase({
    required this.accountRepository,
    required this.transactionRepository,
    Uuid? uuid,
  }) : uuid = uuid ?? const Uuid();

  Future<Result<TransferResult>> execute(TransferRequest request) async {
    if (request.referenceNumber != null) {
      final idempotencyCheck = await _checkIdempotency(request);
      if (idempotencyCheck != null) return idempotencyCheck;
    }

    final sourceAccountResult = await accountRepository.getAccountById(
      request.fromAccountId,
    );
    final targetAccountResult = await accountRepository.getAccountById(
      request.toAccountId,
    );

    final accountValidation = _validateAccounts(
      sourceAccountResult,
      targetAccountResult,
      request,
    );
    if (accountValidation != null) return accountValidation;

    final sourceAccount = sourceAccountResult.getOrThrow();
    final targetAccount = targetAccountResult.getOrThrow();

    if (sourceAccount.balance < request.amount) {
      return Result.failure(
        const InsufficientFundsException('Saldo insuficiente para la transferencia'),
      );
    }

    final referenceNumber = request.referenceNumber ??
        request.generateReferenceNumber();

    final transaction = _createDebitTransaction(
      sourceAccount.id,
      request.amount,
      request.description,
      referenceNumber,
      request.channel,
    );

    final transactionResult = await transactionRepository.createTransaction(transaction);
    
    final updatedSourceResult = await accountRepository.applyTransaction(
      sourceAccount.id,
      transaction,
    );

    final creditTransaction = _createCreditTransaction(
      targetAccount.id,
      request.amount,
      request.description,
      referenceNumber,
      request.channel,
      transaction.id,
    );

    await transactionRepository.createTransaction(creditTransaction);
    
    final updatedTargetResult = await accountRepository.applyTransaction(
      targetAccount.id,
      creditTransaction,
    );

    return updatedSourceResult.when(
      success: (updatedSource) {
        return updatedTargetResult.when(
          success: (updatedTarget) {
            final result = TransferResult(
              transactionId: transaction.id,
              referenceNumber: referenceNumber,
              fromAccountId: request.fromAccountId,
              toAccountId: request.toAccountId,
              amount: request.amount,
              currency: request.currency,
              status: TransferStatus.completed,
              timestamp: DateTime.now(),
              newSourceBalance: updatedSource.balance,
              newTargetBalance: updatedTarget.balance,
            );
            return Result.success(result);
          },
          failure: (error) => Result.failure(error),
        );
      },
      failure: (error) => Result.failure(error),
    );
  }

  Future<Result<TransferResult>?> _checkIdempotency(TransferRequest request) async {
    final existingResult = await transactionRepository.findByReferenceNumber(
      request.referenceNumber!,
      request.channel,
    );
    
    return existingResult.when(
      success: (existingTransaction) {
        if (existingTransaction != null) {
          return Result.success(
            TransferResult(
              transactionId: existingTransaction.id,
              referenceNumber: request.referenceNumber!,
              fromAccountId: request.fromAccountId,
              toAccountId: request.toAccountId,
              amount: request.amount,
              currency: request.currency,
              status: TransferStatus.duplicated,
              timestamp: existingTransaction.timestamp,
              newSourceBalance: 0,
              newTargetBalance: 0,
              isIdempotentResult: true,
            ),
          );
        }
        return null;
      },
      failure: (error) => Result.failure(error),
    );
  }

  Result<TransferResult>? _validateAccounts(
    Result<Account> sourceResult,
    Result<Account> targetResult,
    TransferRequest request,
  ) {
    return sourceResult.when(
      success: (source) {
        return targetResult.when(
          success: (target) {
            if (!source.isActive) {
              return Result.failure(
                const AccountInactiveException('La cuenta de origen está inactiva'),
              );
            }
            if (!target.isActive) {
              return Result.failure(
                const AccountInactiveException('La cuenta de destino está inactiva'),
              );
            }
            if (!source.canPerformTransfer(request.channel)) {
              return Result.failure(
                ChannelNotAllowedException(
                  'El canal ${request.channel} no está permitido para esta cuenta',
                ),
              );
            }
            return null;
          },
          failure: (error) => Result.failure(error),
        );
      },
      failure: (error) => Result.failure(error),
    );
  }

  Transaction _createDebitTransaction(
    String accountId,
    double amount,
    String description,
    String referenceNumber,
    String channel,
  ) {
    return Transaction(
      id: uuid.v4(),
      accountId: accountId,
      amount: amount,
      type: TransactionType.debit,
      description: description,
      timestamp: DateTime.now(),
      status: TransactionStatus.completed,
      referenceNumber: referenceNumber,
    );
  }

  Transaction _createCreditTransaction(
    String accountId,
    double amount,
    String description,
    String referenceNumber,
    String channel,
    String relatedTransactionId,
  ) {
    return Transaction(
      id: uuid.v4(),
      accountId: accountId,
      amount: amount,
      type: TransactionType.credit,
      description: description,
      timestamp: DateTime.now(),
      status: TransactionStatus.completed,
      referenceNumber: referenceNumber,
      relatedTransactionId: relatedTransactionId,
    );
  }

  @override
  List<Object?> get props => [accountRepository, transactionRepository, uuid];
}

class TransferResult extends Equatable {
  final String transactionId;
  final String referenceNumber;
  final String fromAccountId;
  final String toAccountId;
  final double amount;
  final String currency;
  final TransferStatus status;
  final DateTime timestamp;
  final double newSourceBalance;
  final double newTargetBalance;
  final bool isIdempotentResult;

  const TransferResult({
    required this.transactionId,
    required this.referenceNumber,
    required this.fromAccountId,
    required this.toAccountId,
    required this.amount,
    required this.currency,
    required this.status,
    required this.timestamp,
    required this.newSourceBalance,
    required this.newTargetBalance,
    this.isIdempotentResult = false,
  });

  @override
  List<Object?> get props => [
        transactionId,
        referenceNumber,
        fromAccountId,
        toAccountId,
        amount,
        currency,
        status,
        timestamp,
        newSourceBalance,
        newTargetBalance,
        isIdempotentResult,
      ];
}

enum TransferStatus {
  pending,
  completed,
  failed,
  duplicated,
  reversed,
}

class InsufficientFundsException implements Exception {
  final String message;
  const InsufficientFundsException(this.message);
  @override
  String toString() => 'InsufficientFundsException: $message';
}

class AccountInactiveException implements Exception {
  final String message;
  const AccountInactiveException(this.message);
  @override
  String toString() => 'AccountInactiveException: $message';
}

class ChannelNotAllowedException implements Exception {
  final String message;
  const ChannelNotAllowedException(this.message);
  @override
  String toString() => 'ChannelNotAllowedException: $message';
}