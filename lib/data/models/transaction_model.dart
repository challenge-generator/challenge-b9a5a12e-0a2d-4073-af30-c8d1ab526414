package mobile_banking_app.data.models;

import 'package:equatable/equatable.dart';

enum TransactionTypeModel { credit, debit }

enum TransactionStatusModel { pending, completed, failed, reversed }

class TransactionModel extends Equatable {
  final String id;
  final String accountId;
  final double amount;
  final TransactionTypeModel type;
  final String description;
  final DateTime timestamp;
  final TransactionStatusModel status;
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

  factory TransactionModel.fromJson(Map<String, dynamic> json) {
    return TransactionModel(
      id: json['id'] as String,
      accountId: json['account_id'] as String,
      amount: (json['amount'] as num).toDouble(),
      type: TransactionTypeModel.values.firstWhere(
        (e) => e.name == json['type'],
        orElse: () => TransactionTypeModel.debit,
      ),
      description: json['description'] as String,
      timestamp: DateTime.parse(json['timestamp'] as String),
      status: TransactionStatusModel.values.firstWhere(
        (e) => e.name == json['status'],
        orElse: () => TransactionStatusModel.pending,
      ),
      referenceNumber: json['reference_number'] as String?,
      relatedTransactionId: json['related_transaction_id'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'account_id': accountId,
      'amount': amount,
      'type': type.name,
      'description': description,
      'timestamp': timestamp.toIso8601String(),
      'status': status.name,
      'reference_number': referenceNumber,
      'related_transaction_id': relatedTransactionId,
    };
  }

  TransactionModel copyWith({
    String? id,
    String? accountId,
    double? amount,
    TransactionTypeModel? type,
    String? description,
    DateTime? timestamp,
    TransactionStatusModel? status,
    String? referenceNumber,
    String? relatedTransactionId,
  }) {
    return TransactionModel(
      id: id ?? this.id,
      accountId: accountId ?? this.accountId,
      amount: amount ?? this.amount,
      type: type ?? this.type,
      description: description ?? this.description,
      timestamp: timestamp ?? this.timestamp,
      status: status ?? this.status,
      referenceNumber: referenceNumber ?? this.referenceNumber,
      relatedTransactionId: relatedTransactionId ?? this.relatedTransactionId,
    );
  }

  bool get isSuccessful =>
      status == TransactionStatusModel.completed ||
      status == TransactionStatusModel.credit;

  List<String> get allowedChannels => ['mobile', 'web', 'atm', 'branch'];

  @override
  List<Object?> get props => [
        id,
        accountId,
        amount,
        type,
        description,
        timestamp,
        status,
        referenceNumber,
        relatedTransactionId,
      ];
}