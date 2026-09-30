import 'package:dio/dio.dart';
import 'package:uuid/uuid.dart';
import '../../../core/constants/api_constants.dart';
import '../../../core/utils/result.dart';
import '../../models/transaction_model.dart';
import '../api_service.dart';

abstract class TransactionRemoteDataSource {
  Future<Result<TransactionModel>> createTransaction(
    TransactionModel transaction,
  );
  Future<Result<TransactionModel>> getTransactionById(String transactionId);
  Future<Result<List<TransactionModel>>> getTransactionsByAccount(
    String accountId, {
    int? limit,
    int? offset,
    DateTime? startDate,
    DateTime? endDate,
  });
  Future<Result<TransactionModel>> updateTransactionStatus(
    String transactionId,
    String status,
  );
  Future<Result<bool>> validateTransactionIdempotency(
    String referenceNumber,
    String channel,
  );
  Future<Result<List<TransactionModel>>> getPendingTransactions(
    String accountId,
  );
  Future<Result<TransactionModel>> reverseTransaction(
    String transactionId,
    String reason,
  );
}

class TransactionRemoteDataSourceImpl implements TransactionRemoteDataSource {
  final ApiService _apiService;
  final Uuid _uuid;

  TransactionRemoteDataSourceImpl({
    required ApiService apiService,
    Uuid? uuid,
  })  : _apiService = apiService,
        _uuid = uuid ?? const Uuid();

  @override
  Future<Result<TransactionModel>> createTransaction(
    TransactionModel transaction,
  ) async {
    try {
      final idempotencyKey = transaction.referenceNumber ?? _uuid.v4();

      final isIdempotent = await validateTransactionIdempotency(
        idempotencyKey,
        'mobile',
      );

      if (isIdempotent.isSuccess && isIdempotent.data == true) {
        return Result.failure(
          ApiException(
            message: 'Transacción duplicada detectada',
            statusCode: 409,
          ),
        );
      }

      final response = await _apiService.post<Map<String, dynamic>>(
        ApiConstants.transactionsEndpoint,
        data: transaction.toJson(),
        options: Options(
          headers: {'X-Idempotency-Key': idempotencyKey},
        ),
      );

      if (response.statusCode == 201 || response.statusCode == 200) {
        final createdTransaction = TransactionModel.fromJson(response.data!);
        return Result.success(createdTransaction);
      }

      return Result.failure(
        ApiException(
          message: 'Error al crear la transacción',
          statusCode: response.statusCode,
        ),
      );
    } on DioException catch (e) {
      return Result.failure(
        ApiException(
          message: e.error?.toString() ?? 'Error de red',
          statusCode: e.response?.statusCode,
        ),
      );
    } catch (e) {
      return Result.failure(
        ApiException(message: 'Error inesperado: $e'),
      );
    }
  }

  @override
  Future<Result<TransactionModel>> getTransactionById(
    String transactionId,
  ) async {
    try {
      final response = await _apiService.get<Map<String, dynamic>>(
        '${ApiConstants.transactionsEndpoint}/$transactionId',
      );

      if (response.statusCode == 200 && response.data != null) {
        final transaction = TransactionModel.fromJson(response.data!);
        return Result.success(transaction);
      }

      return Result.failure(
        ApiException(
          message: 'Transacción no encontrada',
          statusCode: response.statusCode,
        ),
      );
    } on DioException catch (e) {
      return Result.failure(
        ApiException(
          message: e.error?.toString() ?? 'Error de red',
          statusCode: e.response?.statusCode,
        ),
      );
    } catch (e) {
      return Result.failure(
        ApiException(message: 'Error inesperado: $e'),
      );
    }
  }

  @override
  Future<Result<List<TransactionModel>>> getTransactionsByAccount(
    String accountId, {
    int? limit,
    int? offset,
    DateTime? startDate,
    DateTime? endDate,
  }) async {
    try {
      final queryParams = <String, dynamic>{
        'accountId': accountId,
      };

      if (limit != null) queryParams['limit'] = limit;
      if (offset != null) queryParams['offset'] = offset;
      if (startDate != null) {
        queryParams['startDate'] = startDate.toIso8601String();
      }
      if (endDate != null) {
        queryParams['endDate'] = endDate.toIso8601String();
      }

      final response = await _apiService.get<Map<String, dynamic>>(
        ApiConstants.transactionsEndpoint,
        queryParameters: queryParams,
      );

      if (response.statusCode == 200 && response.data != null) {
        final List<dynamic> transactionsJson =
            response.data!['transactions'] ?? [];
        final transactions = transactionsJson
            .map((json) => TransactionModel.fromJson(json))
            .toList();
        return Result.success(transactions);
      }

      return Result.failure(
        ApiException(
          message: 'Error al obtener las transacciones',
          statusCode: response.statusCode,
        ),
      );
    } on DioException catch (e) {
      return Result.failure(
        ApiException(
          message: e.error?.toString() ?? 'Error de red',
          statusCode: e.response?.statusCode,
        ),
      );
    } catch (e) {
      return Result.failure(
        ApiException(message: 'Error inesperado: $e'),
      );
    }
  }

  @override
  Future<Result<TransactionModel>> updateTransactionStatus(
    String transactionId,
    String status,
  ) async {
    try {
      final response = await _apiService.patch<Map<String, dynamic>>(
        '${ApiConstants.transactionsEndpoint}/$transactionId/status',
        data: {'status': status},
      );

      if (response.statusCode == 200 && response.data != null) {
        final transaction = TransactionModel.fromJson(response.data!);
        return Result.success(transaction);
      }

      return Result.failure(
        ApiException(
          message: 'Error al actualizar el estado de la transacción',
          statusCode: response.statusCode,
        ),
      );
    } on DioException catch (e) {
      return Result.failure(
        ApiException(
          message: e.error?.toString() ?? 'Error de red',
          statusCode: e.response?.statusCode,
        ),
      );
    } catch (e) {
      return Result.failure(
        ApiException(message: 'Error inesperado: $e'),
      );
    }
  }

  @override
  Future<Result<bool>> validateTransactionIdempotency(
    String referenceNumber,
    String channel,
  ) async {
    try {
      final response = await _apiService.get<Map<String, dynamic>>(
        '${ApiConstants.idempotencyEndpoint}/validate',
        queryParameters: {
          'referenceNumber': referenceNumber,
          'channel': channel,
        },
      );

      if (response.statusCode == 200 && response.data != null) {
        final isIdempotent = response.data!['isIdempotent'] as bool? ?? false;
        return Result.success(isIdempotent);
      }

      return Result.failure(
        ApiException(
          message: 'Error al validar idempotencia',
          statusCode: response.statusCode,
        ),
      );
    } on DioException catch (e) {
      return Result.failure(
        ApiException(
          message: e.error?.toString() ?? 'Error de red',
          statusCode: e.response?.statusCode,
        ),
      );
    } catch (e) {
      return Result.failure(
        ApiException(message: 'Error inesperado: $e'),
      );
    }
  }

  @override
  Future<Result<List<TransactionModel>>> getPendingTransactions(
    String accountId,
  ) async {
    try {
      final response = await _apiService.get<Map<String, dynamic>>(
        '${ApiConstants.transactionsEndpoint}/pending',
        queryParameters: {'accountId': accountId},
      );

      if (response.statusCode == 200 && response.data != null) {
        final List<dynamic> transactionsJson =
            response.data!['transactions'] ?? [];
        final transactions = transactionsJson
            .map((json) => TransactionModel.fromJson(json))
            .toList();
        return Result.success(transactions);
      }

      return Result.failure(
        ApiException(
          message: 'Error al obtener las transacciones pendientes',
          statusCode: response.statusCode,
        ),
      );
    } on DioException catch (e) {
      return Result.failure(
        ApiException(
          message: e.error?.toString() ?? 'Error de red',
          statusCode: e.response?.statusCode,
        ),
      );
    } catch (e) {
      return Result.failure(
        ApiException(message: 'Error inesperado: $e'),
      );
    }
  }

  @override
  Future<Result<TransactionModel>> reverseTransaction(
    String transactionId,
    String reason,
  ) async {
    try {
      final response = await _apiService.post<Map<String, dynamic>>(
        '${ApiConstants.transactionsEndpoint}/$transactionId/reverse',
        data: {'reason': reason},
      );

      if (response.statusCode == 200 && response.data != null) {
        final reversedTransaction = TransactionModel.fromJson(response.data!);
        return Result.success(reversedTransaction);
      }

      return Result.failure(
        ApiException(
          message: 'Error al revertir la transacción',
          statusCode: response.statusCode,
        ),
      );
    } on DioException catch (e) {
      return Result.failure(
        ApiException(
          message: e.error?.toString() ?? 'Error de red',
          statusCode: e.response?.statusCode,
        ),
      );
    } catch (e) {
      return Result.failure(
        ApiException(message: 'Error inesperado: $e'),
      );
    }
  }
}