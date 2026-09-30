enum TransactionType { credit, debit }

enum TransactionStatus { pending, completed, failed, reversed }

class Transaction with EquatableMixin {
  final String id;
  final String accountId;
  final double amount;
  final TransactionType type;
  final String description;
  final DateTime timestamp;
  final TransactionStatus status;
  final String? referenceNumber;
  final String? relatedTransactionId;

  Transaction({
    required this.id,
    required this.accountId,
    required this.amount,
    required this.type,
    required this.description,
    required this.timestamp,
    this.status = TransactionStatus.pending,
    this.referenceNumber,
    this.relatedTransactionId,
  });

  Transaction copyWith({
    String? id,
    String? accountId,
    double? amount,
    TransactionType? type,
    String? description,
    DateTime? timestamp,
    TransactionStatus? status,
    String? referenceNumber,
    String? relatedTransactionId,
  }) {
    return Transaction(
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

  bool isIdempotentMatch(String referenceNumber, String channel) {
    return this.referenceNumber == referenceNumber &&
           allowedChannels.contains(channel);
  }

  bool get isSuccessful => status == TransactionStatus.completed;

  List<String> get allowedChannels => ['MOBILE', 'WEB', 'ATM'];

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