class ApiConstants {
  static const String baseUrl = 'https://api.bancomovil.com/v1';
  static const String apiVersion = 'v1';
  static const Duration connectionTimeout = Duration(seconds: 30);
  static const Duration receiveTimeout = Duration(seconds: 30);
  static const int maxRetries = 3;
  static const Duration retryDelay = Duration(seconds: 2);

  static const String accountsEndpoint = '/accounts';
  static const String transactionsEndpoint = '/transactions';
  static const String transferEndpoint = '/transfer';
  static const String balanceEndpoint = '/balance';
  static const String historyEndpoint = '/history';
  static const String authEndpoint = '/auth';
  static const String biometricEndpoint = '/auth/biometric';
  static const String pinEndpoint = '/auth/pin';

  static const Map<String, String> defaultHeaders = {
    'Content-Type': 'application/json',
    'Accept': 'application/json',
    'X-API-Version': apiVersion,
    'X-Client-Version': '1.0.0',
    'X-Platform': 'mobile',
  };

  static const List<int> successStatusCodes = [200, 201, 202, 204];
  static const int unauthorizedCode = 401;
  static const int forbiddenCode = 403;
  static const int notFoundCode = 404;
  static const int tooManyRequestsCode = 429;
  static const int serverErrorCode = 500;

  static const double minTransferAmount = 0.01;
  static const double maxTransferAmount = 100000.00;
  static const String defaultCurrency = 'USD';
  static const int maxDescriptionLength = 200;
  static const int maxReferenceNumberLength = 50;

  static const List<String> supportedCurrencies = ['USD', 'EUR', 'GBP', 'MXN', 'COP'];
  static const List<String> supportedChannels = ['mobile', 'web', 'atm', 'branch'];

  static const Map<String, String> channelDisplayNames = {
    'mobile': 'Aplicación Móvil',
    'web': 'Portal Web',
    'atm': 'Cajero Automático',
    'branch': 'Sucursal',
  };

  static const Map<String, String> errorMessages = {
    'network_error': 'Error de conexión. Verifica tu conexión a internet.',
    'timeout_error': 'La solicitud tardó demasiado. Intenta de nuevo.',
    'server_error': 'Error del servidor. Intenta más tarde.',
    'unauthorized': 'Sesión expirada. Inicia sesión nuevamente.',
    'insufficient_funds': 'Saldo insuficiente para esta operación.',
    'invalid_account': 'La cuenta destinataria no es válida.',
    'duplicate_transaction': 'Esta transacción ya fue procesada.',
    'limit_exceeded': 'Has excedido el límite de transferencia.',
  };

  static String getErrorMessage(String errorCode) {
    return errorMessages[errorCode] ?? 'Ocurrió un error inesperado.';
  }

  static bool isRetryableError(int statusCode) {
    return statusCode == 429 || 
           (statusCode >= 500 && statusCode < 600);
  }

  static bool isAuthError(int statusCode) {
    return statusCode == 401 || statusCode == 403;
  }
}

class CacheConstants {
  static const Duration accountCacheDuration = Duration(minutes: 5);
  static const Duration balanceCacheDuration = Duration(seconds: 30);
  static const Duration transactionCacheDuration = Duration(minutes: 2);
  static const int maxCacheSize = 100;
  static const String accountCacheKey = 'cached_accounts';
  static const String balanceCacheKey = 'cached_balance';
  static const String transactionCacheKey = 'cached_transactions';
}

class ValidationConstants {
  static const int minPinLength = 4;
  static const int maxPinLength = 6;
  static const int minPasswordLength = 8;
  static const int maxPasswordLength = 32;
  static const RegExp emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
  static const RegExp phoneRegex = RegExp(r'^\+?[1-9]\d{1,14}$');
  static const RegExp accountNumberRegex = RegExp(r'^\d{10,20}$');
}