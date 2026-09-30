import 'package:equatable/equatable.dart';
import '../../core/utils/result.dart';
import '../entities/account.dart';
import '../repositories/account_repository.dart';

class GetBalanceUseCase extends Equatable {
  final AccountRepository accountRepository;

  const GetBalanceUseCase({required this.accountRepository});

  Future<Result<BalanceResponse>> execute(String accountId) async {
    final stopwatch = Stopwatch()..start();
    
    final accountResult = await accountRepository.getAccountById(accountId);
    
    stopwatch.stop();
    final elapsedMilliseconds = stopwatch.elapsedMilliseconds;
    final elapsedSeconds = stopwatch.elapsed.inSeconds;

    return accountResult.when(
      success: (account) {
        if (elapsedSeconds >= 2) {
          return Result.failure(
            const BalanceTimeoutException(
              'La consulta de saldo excedió el límite de latencia de 2 segundos',
            ),
          );
        }
        
        final response = BalanceResponse(
          accountId: account.id,
          balance: account.balance,
          currency: account.currency,
          lastUpdated: account.lastUpdated,
          latencyMs: elapsedMilliseconds,
          meetsSla: elapsedSeconds < 2,
        );
        
        return Result.success(response);
      },
      failure: (error) {
        return Result.failure(error);
      },
    );
  }

  Future<Result<Account>> getAccountDetails(String accountId) async {
    return accountRepository.getAccountById(accountId);
  }

  Future<Result<bool>> validateAccountAccess(String accountId, String channel) async {
    final accountResult = await accountRepository.getAccountById(accountId);
    return accountResult.when(
      success: (account) {
        final hasAccess = account.canPerformTransfer(channel);
        return Result.success(hasAccess);
      },
      failure: (error) => Result.failure(error),
    );
  }

  @override
  List<Object?> get props => [accountRepository];
}

class BalanceResponse extends Equatable {
  final String accountId;
  final double balance;
  final String currency;
  final DateTime lastUpdated;
  final int latencyMs;
  final bool meetsSla;

  const BalanceResponse({
    required this.accountId,
    required this.balance,
    required this.currency,
    required this.lastUpdated,
    required this.latencyMs,
    required this.meetsSla,
  });

  String get formattedBalance {
    return '$currency ${balance.toStringAsFixed(2)}';
  }

  @override
  List<Object?> get props => [
        accountId,
        balance,
        currency,
        lastUpdated,
        latencyMs,
        meetsSla,
      ];
}

class BalanceTimeoutException implements Exception {
  final String message;
  const BalanceTimeoutException(this.message);
  @override
  String toString() => 'BalanceTimeoutException: $message';
}