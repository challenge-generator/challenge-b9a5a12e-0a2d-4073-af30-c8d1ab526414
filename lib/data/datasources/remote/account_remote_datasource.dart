import 'package:dio/dio.dart';
import '../../../core/constants/api_constants.dart';
import '../../../core/utils/result.dart';
import '../../models/account_model.dart';
import '../api_service.dart';

abstract class AccountRemoteDataSource {
  Future<Result<AccountModel>> getAccountById(String accountId);
  Future<Result<AccountModel>> getAccountByNumber(String accountNumber);
  Future<Result<List<AccountModel>>> getAccountsByHolder(String holderId);
  Future<Result<AccountModel>> updateAccountBalance(
    String accountId,
    double newBalance,
  );
  Future<Result<bool>> validateAccountStatus(String accountId);
  Future<Result<List<String>>> getAllowedChannels(String accountId);
}

class AccountRemoteDataSourceImpl implements AccountRemoteDataSource {
  final ApiService _apiService;

  AccountRemoteDataSourceImpl({required ApiService apiService})
      : _apiService = apiService;

  @override
  Future<Result<AccountModel>> getAccountById(String accountId) async {
    try {
      final response = await _apiService.get<Map<String, dynamic>>(
        '${ApiConstants.accountsEndpoint}/$accountId',
      );

      if (response.statusCode == 200 && response.data != null) {
        final account = AccountModel.fromJson(response.data!);
        return Result.success(account);
      }

      return Result.failure(
        ApiException(
          message: 'Error al obtener la cuenta',
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
  Future<Result<AccountModel>> getAccountByNumber(String accountNumber) async {
    try {
      final response = await _apiService.get<Map<String, dynamic>>(
        ApiConstants.accountsEndpoint,
        queryParameters: {'accountNumber': accountNumber},
      );

      if (response.statusCode == 200 && response.data != null) {
        final account = AccountModel.fromJson(response.data!);
        return Result.success(account);
      }

      return Result.failure(
        ApiException(
          message: 'Cuenta no encontrada',
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
  Future<Result<List<AccountModel>>> getAccountsByHolder(
    String holderId,
  ) async {
    try {
      final response = await _apiService.get<Map<String, dynamic>>(
        '${ApiConstants.holdersEndpoint}/$holderId/accounts',
      );

      if (response.statusCode == 200 && response.data != null) {
        final List<dynamic> accountsJson = response.data!['accounts'] ?? [];
        final accounts =
            accountsJson.map((json) => AccountModel.fromJson(json)).toList();
        return Result.success(accounts);
      }

      return Result.failure(
        ApiException(
          message: 'Error al obtener las cuentas del titular',
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
  Future<Result<AccountModel>> updateAccountBalance(
    String accountId,
    double newBalance,
  ) async {
    try {
      final response = await _apiService.patch<Map<String, dynamic>>(
        '${ApiConstants.accountsEndpoint}/$accountId/balance',
        data: {'balance': newBalance},
      );

      if (response.statusCode == 200 && response.data != null) {
        final account = AccountModel.fromJson(response.data!);
        return Result.success(account);
      }

      return Result.failure(
        ApiException(
          message: 'Error al actualizar el saldo',
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
  Future<Result<bool>> validateAccountStatus(String accountId) async {
    try {
      final response = await _apiService.get<Map<String, dynamic>>(
        '${ApiConstants.accountsEndpoint}/$accountId/status',
      );

      if (response.statusCode == 200 && response.data != null) {
        final isActive = response.data!['isActive'] as bool? ?? false;
        return Result.success(isActive);
      }

      return Result.failure(
        ApiException(
          message: 'Error al validar el estado de la cuenta',
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
  Future<Result<List<String>>> getAllowedChannels(String accountId) async {
    try {
      final response = await _apiService.get<Map<String, dynamic>>(
        '${ApiConstants.accountsEndpoint}/$accountId/channels',
      );

      if (response.statusCode == 200 && response.data != null) {
        final List<dynamic> channelsJson =
            response.data!['allowedChannels'] ?? [];
        final channels = channelsJson.cast<String>();
        return Result.success(channels);
      }

      return Result.failure(
        ApiException(
          message: 'Error al obtener los canales permitidos',
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

class ApiException implements Exception {
  final String message;
  final int? statusCode;

  ApiException({required this.message, this.statusCode});

  @override
  String toString() => 'ApiException: $message (status: $statusCode)';
}