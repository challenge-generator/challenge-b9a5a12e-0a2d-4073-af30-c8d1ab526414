import 'package:equatable/equatable.dart';
import '../../core/utils/result.dart';
import '../entities/account.dart';
import '../entities/transaction.dart';

abstract class AccountRepository extends Equatable {
  const AccountRepository();

  Future<Result<Account>> getAccountById(String accountId);

  Future<Result<Account>> getAccountByNumber(String accountNumber);

  Future<Result<double>> getBalance(String accountId);

  Future<Result<Account>> updateBalance(
    String accountId,
    double newBalance,
  );

  Future<Result<Account>> applyTransaction(
    String accountId,
    Transaction transaction,
  );

  Future<Result<List<Account>>> getAccountsByHolder(String holderId);

  Future<Result<bool>> validateAccountStatus(String accountId);

  Future<Result<Account>> refreshAccountData(String accountId);
}

class AccountRepositoryImpl implements AccountRepository {
  final AccountRemoteDataSource remoteDataSource;

  const AccountRepositoryImpl({required this.remoteDataSource});

  @override
  Future<Result<Account>> getAccountById(String accountId) async {
    try {
      final accountModel = await remoteDataSource.getAccountById(accountId);
      final account = accountModel.toEntity();
      return Result.success(account);
    } on NetworkException catch (e) {
      return Result.failure(e);
    } on ServerException catch (e) {
      return Result.failure(e);
    } catch (e) {
      return Result.failure(UnexpectedException('Error al obtener cuenta: $e'));
    }
  }

  @override
  Future<Result<Account>> getAccountByNumber(String accountNumber) async {
    try {
      final accountModel = await remoteDataSource.getAccountByNumber(accountNumber);
      final account = accountModel.toEntity();
      return Result.success(account);
    } on NetworkException catch (e) {
      return Result.failure(e);
    } on ServerException catch (e) {
      return Result.failure(e);
    } catch (e) {
      return Result.failure(UnexpectedException('Error al buscar cuenta: $e'));
    }
  }

  @override
  Future<Result<double>> getBalance(String accountId) async {
    final stopwatch = Stopwatch()..start();
    try {
      final accountResult = await getAccountById(accountId);
      stopwatch.stop();
      
      if (stopwatch.elapsed.inSeconds > 2) {
        return Result.failure(
          TimeoutException('La consulta excedió el límite de 2 segundos'),
        );
      }
      
      return accountResult.when(
        success: (account) => Result.success(account.balance),
        failure: (error) => Result.failure(error),
      );
    } catch (e) {
      stopwatch.stop();
      return Result.failure(UnexpectedException('Error al obtener saldo: $e'));
    }
  }

  @override
  Future<Result<Account>> updateBalance(
    String accountId,
    double newBalance,
  ) async {
    try {
      final accountModel = await remoteDataSource.updateBalance(
        accountId,
        newBalance,
      );
      final account = accountModel.toEntity();
      return Result.success(account);
    } on NetworkException catch (e) {
      return Result.failure(e);
    } on ServerException catch (e) {
      return Result.failure(e);
    } catch (e) {
      return Result.failure(UnexpectedException('Error al actualizar saldo: $e'));
    }
  }

  @override
  Future<Result<Account>> applyTransaction(
    String accountId,
    Transaction transaction,
  ) async {
    final accountResult = await getAccountById(accountId);
    return accountResult.when(
      success: (account) {
        final updatedAccount = account.applyTransaction(transaction);
        return updateBalance(accountId, updatedAccount.balance);
      },
      failure: (error) => Result.failure(error),
    );
  }

  @override
  Future<Result<List<Account>>> getAccountsByHolder(String holderId) async {
    try {
      final accounts = await remoteDataSource.getAccountsByHolder(holderId);
      return Result.success(accounts.map((m) => m.toEntity()).toList());
    } on NetworkException catch (e) {
      return Result.failure(e);
    } on ServerException catch (e) {
      return Result.failure(e);
    } catch (e) {
      return Result.failure(UnexpectedException('Error al obtener cuentas: $e'));
    }
  }

  @override
  Future<Result<bool>> validateAccountStatus(String accountId) async {
    final accountResult = await getAccountById(accountId);
    return accountResult.when(
      success: (account) => Result.success(account.isActive),
      failure: (error) => Result.failure(error),
    );
  }

  @override
  Future<Result<Account>> refreshAccountData(String accountId) async {
    try {
      final accountModel = await remoteDataSource.refreshAccount(accountId);
      final account = accountModel.toEntity();
      return Result.success(account);
    } on NetworkException catch (e) {
      return Result.failure(e);
    } on ServerException catch (e) {
      return Result.failure(e);
    } catch (e) {
      return Result.failure(UnexpectedException('Error al refrescar cuenta: $e'));
    }
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

class TimeoutException implements Exception {
  final String message;
  const TimeoutException(this.message);
  @override
  String toString() => 'TimeoutException: $message';
}

class UnexpectedException implements Exception {
  final String message;
  const UnexpectedException(this.message);
  @override
  String toString() => 'UnexpectedException: $message';
}

abstract class AccountRemoteDataSource {
  Future<AccountModel> getAccountById(String accountId);
  Future<AccountModel> getAccountByNumber(String accountNumber);
  Future<AccountModel> updateBalance(String accountId, double newBalance);
  Future<List<AccountModel>> getAccountsByHolder(String holderId);
  Future<AccountModel> refreshAccount(String accountId);
}

class AccountModel {
  final String id;
  final String accountNumber;
  final String accountHolderName;
  final double balance;
  final String currency;
  final DateTime lastUpdated;
  final bool isActive;
  final List<String> allowedChannels;

  const AccountModel({
    required this.id,
    required this.accountNumber,
    required this.accountHolderName,
    required this.balance,
    required this.currency,
    required this.lastUpdated,
    required this.isActive,
    required this.allowedChannels,
  });

  Account toEntity() {
    return Account(
      id: id,
      accountNumber: accountNumber,
      accountHolderName: accountHolderName,
      balance: balance,
      currency: currency,
      lastUpdated: lastUpdated,
      isActive: isActive,
      allowedChannels: allowedChannels,
    );
  }
}