library;

class AppConstants {
  AppConstants._();

  static const String appName = 'Mobile Banking App';
  static const String appVersion = '1.0.0';

  static const int defaultTimeoutSeconds = 30;
  static const int balanceQueryTimeoutSeconds = 2;
  static const int transferTimeoutSeconds = 60;

  static const double maxTransferAmount = 50000.0;
  static const double minTransferAmount = 0.01;
  static const double defaultMinBalance = 100.0;

  static const int maxTransactionHistoryDays = 90;
  static const int maxTransactionsPerPage = 50;
  static const int transactionCacheValidityMinutes = 5;

  static const int maxPinAttempts = 3;
  static const int lockoutDurationMinutes = 15;
  static const int sessionTimeoutMinutes = 5;

  static const String defaultCurrency = 'USD';
  static const List<String> supportedCurrencies = ['USD', 'EUR', 'GBP', 'MXN'];

  static const List<String> allowedChannels = [
    'mobile_app',
    'web',
    'atm',
    'branch',
    'api',
  ];

  static const String defaultChannel = 'mobile_app';
  static const String biometricChannel = 'biometric';

  static const int retryAttempts = 3;
  static const int retryDelayMilliseconds = 1000;

  static const String apiBaseUrl = 'https://api.bank.example.com/v1';
  static const String apiHealthEndpoint = '/health';
  static const String apiAccountsEndpoint = '/accounts';
  static const String apiTransactionsEndpoint = '/transactions';
  static const String apiTransferEndpoint = '/transfers';
  static const String apiAuthEndpoint = '/auth';

  static const String secureStorageKeyPin = 'user_pin_hash';
  static const String secureStorageKeyBiometricEnabled = 'biometric_enabled';
  static const String secureStorageKeySessionToken = 'session_token';
  static const String secureStorageKeyLastSync = 'last_sync_timestamp';
  static const String secureStorageKeyUserId = 'user_id';

  static const String errorNetwork = 'Error de conexión. Verifica tu conexión a internet.';
  static const String errorTimeout = 'La operación tardó demasiado. Intenta de nuevo.';
  static const String errorServer = 'Error del servidor. Intenta más tarde.';
  static const String errorInvalidAmount = 'Monto inválido. Ingresa un valor entre 0.01 y 50000.00';
  static const String errorInsufficientFunds = 'Saldo insuficiente para esta operación.';
  static const String errorAccountNotFound = 'Cuenta no encontrada.';
  static const String errorBiometricNotAvailable = 'Biometría no disponible en este dispositivo.';
  static const String errorBiometricFailed = 'Autenticación biométrica fallida.';
  static const String errorPinLocked = 'Demasiados intentos. Cuenta bloqueada por 15 minutos.';
  static const String errorSessionExpired = 'Sesión expirada. Inicia sesión nuevamente.';

  static const String successTransfer = 'Transferencia realizada exitosamente.';
  static const String successBalanceUpdate = 'Saldo actualizado correctamente.';

  static const double availabilityTarget = 99.9;
  static const int maxLatencyMs = 2000;
}

class StorageKeys {
  StorageKeys._();

  static const String pinHash = 'pin_hash';
  static const String biometricEnabled = 'biometric_enabled';
  static const String sessionToken = 'session_token';
  static const String lastSync = 'last_sync';
  static const String userId = 'user_id';
  static const String accountCache = 'account_cache';
  static const String transactionCache = 'transaction_cache';
}

class ApiEndpoints {
  ApiEndpoints._();

  static const String health = '/health';
  static const String accounts = '/accounts';
  static const String accountById = '/accounts/{id}';
  static const String accountBalance = '/accounts/{id}/balance';
  static const String transactions = '/transactions';
  static const String transactionById = '/transactions/{id}';
  static const String transactionHistory = '/accounts/{id}/transactions';
  static const String transfers = '/transfers';
  static const String transferById = '/transfers/{id}';
  static const String authLogin = '/auth/login';
  static const String authVerify = '/auth/verify';
  static const String authBiometric = '/auth/biometric';
}

class CacheConfig {
  CacheConfig._();

  static const int accountCacheMinutes = 5;
  static const int balanceCacheSeconds = 30;
  static const int transactionCacheMinutes = 3;
  static const int maxCacheEntries = 100;
}

class ValidationRules {
  ValidationRules._();

  static const int minPinLength = 4;
  static const int maxPinLength = 6;
  static const int accountNumberLength = 10;
  static const int minDescriptionLength = 1;
  static const int maxDescriptionLength = 200;
  static final RegExp accountNumberPattern = RegExp(r'^[0-9]{10}$');
  static final RegExp amountPattern = RegExp(r'^\d+(\.\d{1,2})?$');
}