package mobile_banking_app.data.models;

import 'package:equatable/equatable.dart';

class AccountModel extends Equatable {
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

  factory AccountModel.fromJson(Map<String, dynamic> json) {
    return AccountModel(
      id: json['id'] as String,
      accountNumber: json['account_number'] as String,
      accountHolderName: json['account_holder_name'] as String,
      balance: (json['balance'] as num).toDouble(),
      currency: json['currency'] as String,
      lastUpdated: DateTime.parse(json['last_updated'] as String),
      isActive: json['is_active'] as bool,
      allowedChannels: (json['allowed_channels'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'account_number': accountNumber,
      'account_holder_name': accountHolderName,
      'balance': balance,
      'currency': currency,
      'last_updated': lastUpdated.toIso8601String(),
      'is_active': isActive,
      'allowed_channels': allowedChannels,
    };
  }

  AccountModel copyWith({
    String? id,
    String? accountNumber,
    String? accountHolderName,
    double? balance,
    String? currency,
    DateTime? lastUpdated,
    bool? isActive,
    List<String>? allowedChannels,
  }) {
    return AccountModel(
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