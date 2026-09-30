package mobile_banking_app.core.design_patterns.factory;

import 'package:mobile_banking_app/domain/entities/transfer_request.dart';
import 'package:mobile_banking_app/core/utils/result.dart';
import 'package:uuid/uuid.dart';

class TransferFactory {
  static final TransferFactory _instance = TransferFactory._internal();
  final Uuid _uuid = const Uuid();
  
  TransferFactory._internal();
  
  static TransferFactory get instance {
    return _instance;
  }
  
  Result<TransferRequest> createInternalTransfer({
    required String fromAccountId,
    required String toAccountId,
    required double amount,
    required String currency,
    required String description,
    required String channel,
    bool requiresBiometric = false,
    String? referenceNumber,
  }) {
    try {
      if (fromAccountId == toAccountId) {
        return Result.failure(
          ArgumentError('No se puede transferir a la misma cuenta'),
        );
      }
      
      if (amount <= 0) {
        return Result.failure(
          ArgumentError('El monto debe ser mayor a cero'),
        );
      }
      
      if (!_isValidCurrency(currency)) {
        return Result.failure(
          ArgumentError('Moneda no soportada: $currency'),
        );
      }
      
      final transfer = TransferRequest(
        id: _uuid.v4(),
        fromAccountId: fromAccountId,
        toAccountId: toAccountId,
        amount: amount,
        currency: currency,
        description: description,
        channel: channel,
        referenceNumber: referenceNumber ?? _generateReferenceNumber(),
        timestamp: DateTime.now(),
        requiresBiometric: requiresBiometric,
      );
      
      return Result.success(transfer);
    } catch (e) {
      return Result.failure(e);
    }
  }
  
  Result<TransferRequest> createExternalTransfer({
    required String fromAccountId,
    required String toAccountId,
    required double amount,
    required String currency,
    required String description,
    required String channel,
    required String bankCode,
    required String bankName,
    bool requiresBiometric = true,
    String? referenceNumber,
  }) {
    try {
      if (amount <= 0) {
        return Result.failure(
          ArgumentError('El monto debe ser mayor a cero'),
        );
      }
      
      if (amount > 10000) {
        return Result.failure(
          ArgumentError('Monto excede el límite para transferencias externas'),
        );
      }
      
      if (bankCode.isEmpty || bankName.isEmpty) {
        return Result.failure(
          ArgumentError('Código y nombre del banco son requeridos'),
        );
      }
      
      final fullDescription = '$description - Banco: $bankName ($bankCode)';
      
      final transfer = TransferRequest(
        id: _uuid.v4(),
        fromAccountId: fromAccountId,
        toAccountId: toAccountId,
        amount: amount,
        currency: currency,
        description: fullDescription,
        channel: channel,
        referenceNumber: referenceNumber ?? _generateReferenceNumber(),
        timestamp: DateTime.now(),
        requiresBiometric: requiresBiometric,
      );
      
      return Result.success(transfer);
    } catch (e) {
      return Result.failure(e);
    }
  }
  
  Result<TransferRequest> createScheduledTransfer({
    required String fromAccountId,
    required String toAccountId,
    required double amount,
    required String currency,
    required String description,
    required String channel,
    required DateTime scheduledDate,
    bool requiresBiometric = true,
    String? referenceNumber,
  }) {
    try {
      if (scheduledDate.isBefore(DateTime.now())) {
        return Result.failure(
          ArgumentError('La fecha programada debe ser futura'),
        );
      }
      
      if (scheduledDate.isAfter(DateTime.now().add(const Duration(days: 365)))) {
        return Result.failure(
          ArgumentError('No se puede programar más de un año ahead'),
        );
      }
      
      final transfer = TransferRequest(
        id: _uuid.v4(),
        fromAccountId: fromAccountId,
        toAccountId: toAccountId,
        amount: amount,
        currency: currency,
        description: 'Programada: $description',
        channel: channel,
        referenceNumber: referenceNumber ?? _generateReferenceNumber(),
        timestamp: scheduledDate,
        requiresBiometric: requiresBiometric,
      );
      
      return Result.success(transfer);
    } catch (e) {
      return Result.failure(e);
    }
  }
  
  Result<TransferRequest> createRecurringTransfer({
    required String fromAccountId,
    required String toAccountId,
    required double amount,
    required String currency,
    required String description,
    required String channel,
    required int frequencyDays,
    required DateTime endDate,
    bool requiresBiometric = true,
    String? referenceNumber,
  }) {
    try {
      if (frequencyDays < 1 || frequencyDays > 90) {
        return Result.failure(
          ArgumentError('Frecuencia debe estar entre 1 y 90 días'),
        );
      }
      
      if (endDate.isBefore(DateTime.now())) {
        return Result.failure(
          ArgumentError('La fecha de fin debe ser futura'),
        );
      }
      
      final transfer = TransferRequest(
        id: _uuid.v4(),
        fromAccountId: fromAccountId,
        toAccountId: toAccountId,
        amount: amount,
        currency: currency,
        description: 'Recurrente ($frequencyDays días): $description',
        channel: channel,
        referenceNumber: referenceNumber ?? _generateReferenceNumber(),
        timestamp: DateTime.now(),
        requiresBiometric: requiresBiometric,
      );
      
      return Result.success(transfer);
    } catch (e) {
      return Result.failure(e);
    }
  }
  
  Result<TransferRequest> createBulkTransfer({
    required String fromAccountId,
    required List<Map<String, dynamic>> transfers,
    required String currency,
    required String channel,
    bool requiresBiometric = true,
  }) {
    try {
      if (transfers.isEmpty) {
        return Result.failure(
          ArgumentError('La lista de transferencias no puede estar vacía'),
        );
      }
      
      if (transfers.length > 50) {
        return Result.failure(
          ArgumentError('Máximo 50 transferencias por lote'),
        );
      }
      
      double totalAmount = 0;
      for (final t in transfers) {
        final amount = (t['amount'] as num).toDouble();
        if (amount <= 0) {
          return Result.failure(
            ArgumentError('Todos los montos deben ser mayores a cero'),
          );
        }
        totalAmount += amount;
      }
      
      if (totalAmount > 50000) {
        return Result.failure(
          ArgumentError('Monto total excede el límite de lote'),
        );
      }
      
      final transfer = TransferRequest(
        id: _uuid.v4(),
        fromAccountId: fromAccountId,
        toAccountId: 'BULK',
        amount: totalAmount,
        currency: currency,
        description: 'Transferencia masiva de ${transfers.length} operaciones',
        channel: channel,
        referenceNumber: _generateReferenceNumber(),
        timestamp: DateTime.now(),
        requiresBiometric: requiresBiometric,
      );
      
      return Result.success(transfer);
    } catch (e) {
      return Result.failure(e);
    }
  }
  
  String _generateReferenceNumber() {
    final timestamp = DateTime.now().millisecondsSinceEpoch;
    final uuidShort = _uuid.v4().substring(0, 8);
    return 'TRF-$timestamp-$uuidShort';
  }
  
  bool _isValidCurrency(String currency) {
    const supportedCurrencies = ['USD', 'EUR', 'GBP', 'MXN', 'COP', 'PEN'];
    return supportedCurrencies.contains(currency.toUpperCase());
  }
  
  bool validateTransferLimit(double amount, String accountType) {
    const limits = {
      'standard': 5000.0,
      'premium': 25000.0,
      'business': 100000.0,
    };
    
    final limit = limits[accountType] ?? 5000.0;
    return amount <= limit;
  }
  
  String getTransferTypeDescription(TransferRequest transfer) {
    if (transfer.toAccountId == 'BULK') {
      return 'Transferencia Masiva';
    }
    if (transfer.description.contains('Programada')) {
      return 'Transferencia Programada';
    }
    if (transfer.description.contains('Recurrente')) {
      return 'Transferencia Recurrente';
    }
    return 'Transferencia Estándar';
  }
}