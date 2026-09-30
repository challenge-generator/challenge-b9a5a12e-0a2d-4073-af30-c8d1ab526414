class TransferRequest with EquatableMixin {
  final String id;
  final String fromAccountId;
  final String toAccountId;
  final double amount;
  final String currency;
  final String description;
  final String channel;
  final String? referenceNumber;
  final DateTime timestamp;
  final bool requiresBiometric;

  TransferRequest({
    required this.id,
    required this.fromAccountId,
    required this.toAccountId,
    required this.amount,
    required this.currency,
    required this.description,
    required this.channel,
    this.referenceNumber,
    DateTime? timestamp,
    this.requiresBiometric = false,
  }) : timestamp = timestamp ?? DateTime.now();

  TransferRequest copyWith({
    String? id,
    String? fromAccountId,
    String? toAccountId,
    double? amount,
    String? currency,
    String? description,
    String? channel,
    String? referenceNumber,
    DateTime? timestamp,
    bool? requiresBiometric,
  }) {
    return TransferRequest(
      id: id ?? this.id,
      fromAccountId: fromAccountId ?? this.fromAccountId,
      toAccountId: toAccountId ?? this.toAccountId,
      amount: amount ?? this.amount,
      currency: currency ?? this.currency,
      description: description ?? this.description,
      channel: channel ?? this.channel,
      referenceNumber: referenceNumber ?? this.referenceNumber,
      timestamp: timestamp ?? this.timestamp,
      requiresBiometric: requiresBiometric ?? this.requiresBiometric,
    );
  }

  bool get isValid {
    return amount > 0 &&
           currency.isNotEmpty &&
           fromAccountId.isNotEmpty &&
           toAccountId.isNotEmpty &&
           channel.isNotEmpty;
  }

  String generateReferenceNumber() {
    return referenceNumber ?? 'TRF-${DateTime.now().millisecondsSinceEpoch}-${id.substring(0, 8)}';
  }

  @override
  List<Object?> get props => [
    id,
    fromAccountId,
    toAccountId,
    amount,
    currency,
    description,
    channel,
    referenceNumber,
    timestamp,
    requiresBiometric,
  ];
}