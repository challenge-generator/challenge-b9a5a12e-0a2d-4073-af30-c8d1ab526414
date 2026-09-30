part of '../../core/utils/result.dart';

class Account with EquatableMixin {
  final String id;
  final String accountNumber;
  final String accountHolderName;
  final double balance;
  final String currency;
  final DateTime lastUpdated;
  final bool isActive;
  final List<String> allowedChannels;

  Account({
    required this.id,
    required this.accountNumber,
    required this.accountHolderName,
    required this.balance,
    required this.currency,
    required this.lastUpdated,
    this.isActive = true,
    this.allowedChannels = const ['MOBILE', 'WEB', 'ATM'],
  });

  Account copyWith({
    String? id,
    String? accountNumber,
    String? accountHolderName,
    double? balance,
    String? currency,
    DateTime? lastUpdated,
    bool? isActive,
    List<String>? allowedChannels,
  }) {
    return Account(
      id: id ?? this.id,
      accountNumber: accountNumber ?? this.accountNumber,
      accountHolderName: accountHolderName ?? this.accountHolderName,
      balance: balance ?? this.balance,
      currency: currency ?? this.currency,
      lastUpdated: lastUpdated ?? this.lastUpdated,
      isActive: isActive ?? this.isActive,
      allowedChannels: allowedChannels ?? this.allowedChannels,
    );
  }

  Result<Account> applyTransaction(Transaction transaction) {
    if (!isActive) {
      return Result.error('Account is not active');
    }

    if (transaction.type == TransactionType.debit && balance < transaction.amount) {
      return Result.error('Insufficient funds');
    }

    final newBalance = transaction.type == TransactionType.credit
        ? balance + transaction.amount
        : balance - transaction.amount;

    return Result.success(copyWith(
      balance: newBalance,
      lastUpdated: transaction.timestamp,
    ));
  }

  bool canPerformTransfer(String channel) {
    return allowedChannels.contains(channel);
  }

  @override
  List<Object?> get props => [
    id,
    accountNumber,
    accountHolderName,
    balance,
    currency,
    lastUpdated,
    isActive,
    allowedChannels,
  ];
}