package mobile_banking_app.data.repositories;

import 'package:mobile_banking_app/data/datasources/remote/account_remote_datasource.dart';
import 'package:mobile_banking_app/data/models/account_model.dart';
import 'package:mobile_banking_app/domain/repositories/account_repository.dart';
import 'package:mobile_banking_app/domain/entities/transaction.dart';
import 'package:mobile_banking_app/core/utils/result.dart';

class AccountRepositoryImpl implements AccountRepository {
  final AccountRemoteDataSource remoteDataSource;

  AccountRepositoryImpl({required this.remoteDataSource});

  @override
  Future<Result<AccountModel>> getAccountById(String accountId) async {
    try {
      final accountData = await remoteDataSource.fetchAccount(accountId);
      if (accountData == null) {
        return Result.failure(Exception('Cuenta no encontrada'));
      }
      return Result.success(accountData);
    } catch (e) {
      return Result.failure(e);
    }
  }

  @override
  Future<Result<List<AccountModel>>> getAllAccounts() async {
    try {
      final accounts = await remoteDataSource.fetchAllAccounts();
      return Result.success(accounts);
    } catch (e) {
      return Result.failure(e);
    }
  }

  @override
  Future<Result<AccountModel>> getAccountBalance(String accountId) async {
    try {
      final accountData = await remoteDataSource.fetchAccount(accountId);
      if (accountData == null) {
        return Result.failure(Exception('Cuenta no encontrada'));
      }
      return Result.success(accountData);
    } catch (e) {
      return Result.failure(e);
    }
  }

  @override
  Future<Result<AccountModel>> updateAccount(AccountModel account) async {
    try {
      final updatedAccount = await remoteDataSource.updateAccount(account);
      return Result.success(updatedAccount);
    } catch (e) {
      return Result.failure(e);
    }
  }

  @override
  Future<Result<AccountModel>> applyTransaction(
    String accountId,
    Transaction transaction,
  ) async {
    try {
      final accountData = await remoteDataSource.fetchAccount(accountId);
      if (accountData == null) {
        return Result.failure(Exception('Cuenta no encontrada'));
      }

      final updatedAccount = _applyTransactionToAccount(accountData, transaction);
      final result = await remoteDataSource.updateAccount(updatedAccount);
      return Result.success(result);
    } catch (e) {
      return Result.failure(e);
    }
  }

  AccountModel _applyTransactionToAccount(
    AccountModel account,
    Transaction transaction,
  ) {
    double newBalance = account.balance;

    if (transaction.type == TransactionType.credit) {
      newBalance += transaction.amount;
    } else if (transaction.type == TransactionType.debit) {
      newBalance -= transaction.amount;
    }

    return account.copyWith(
      balance: newBalance,
      lastUpdated: DateTime.now(),
    );
  }

  @override
  Future<Result<bool>> validateAccountStatus(String accountId) async {
    try {
      final account = await remoteDataSource.fetchAccount(accountId);
      if (account == null) {
        return Result.failure(Exception('Cuenta no encontrada'));
      }
      return Result.success(account.isActive);
    } catch (e) {
      return Result.failure(e);
    }
  }

  @override
  Future<Result<List<String>>> getAllowedChannels(String accountId) async {
    try {
      final account = await remoteDataSource.fetchAccount(accountId);
      if (account == null) {
        return Result.failure(Exception('Cuenta no encontrada'));
      }
      return Result.success(account.allowedChannels);
    } catch (e) {
      return Result.failure(e);
    }
  }
}