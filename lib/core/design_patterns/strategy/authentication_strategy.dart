import 'package:mobile_banking_app/core/utils/result.dart';

abstract class AuthenticationStrategy {
  Future<Result<AuthenticationResult>> authenticate(AuthenticationContext context);
  bool supportsBiometric();
  String get strategyName;
  AuthenticationType get authenticationType;
}

class AuthenticationContext {
  final String userId;
  final String deviceId;
  final Map<String, dynamic> metadata;
  final DateTime timestamp;

  AuthenticationContext({
    required this.userId,
    required this.deviceId,
    Map<String, dynamic>? metadata,
    DateTime? timestamp,
  })  : metadata = metadata ?? {},
        timestamp = timestamp ?? DateTime.now();

  AuthenticationContext copyWith({
    String? userId,
    String? deviceId,
    Map<String, dynamic>? metadata,
    DateTime? timestamp,
  }) {
    return AuthenticationContext(
      userId: userId ?? this.userId,
      deviceId: deviceId ?? this.deviceId,
      metadata: metadata ?? Map.from(this.metadata),
      timestamp: timestamp ?? this.timestamp,
    );
  }
}

class AuthenticationResult {
  final bool isAuthenticated;
  final String? userId;
  final String? sessionToken;
  final DateTime? expiresAt;
  final String? failureReason;
  final AuthenticationType authenticationType;

  AuthenticationResult({
    required this.isAuthenticated,
    this.userId,
    this.sessionToken,
    this.expiresAt,
    this.failureReason,
    required this.authenticationType,
  });

  factory AuthenticationResult.success({
    required String userId,
    required String sessionToken,
    required DateTime expiresAt,
    required AuthenticationType type,
  }) {
    return AuthenticationResult(
      isAuthenticated: true,
      userId: userId,
      sessionToken: sessionToken,
      expiresAt: expiresAt,
      authenticationType: type,
    );
  }

  factory AuthenticationResult.failure({
    required String reason,
    required AuthenticationType type,
  }) {
    return AuthenticationResult(
      isAuthenticated: false,
      failureReason: reason,
      authenticationType: type,
    );
  }
}

enum AuthenticationType {
  pin,
  biometric,
  otp,
  combined,
}

class AuthenticationStrategyContext {
  AuthenticationStrategy? _strategy;
  final List<AuthenticationStrategy> _availableStrategies = [];

  void setStrategy(AuthenticationStrategy strategy) {
    _strategy = strategy;
  }

  void registerStrategy(AuthenticationStrategy strategy) {
    _availableStrategies.add(strategy);
  }

  void unregisterStrategy(AuthenticationStrategy strategy) {
    _availableStrategies.remove(strategy);
  }

  Future<Result<AuthenticationResult>> authenticate(AuthenticationContext context) async {
    if (_strategy == null) {
      return Result.failure(AuthenticationException('No authentication strategy set'));
    }
    return _strategy!.authenticate(context);
  }

  AuthenticationStrategy? get currentStrategy => _strategy;

  List<AuthenticationStrategy> get availableStrategies => List.unmodifiable(_availableStrategies);

  AuthenticationStrategy? getStrategyByType(AuthenticationType type) {
    try {
      return _availableStrategies.firstWhere((s) => s.authenticationType == type);
    } catch (_) {
      return null;
    }
  }

  bool isStrategyAvailable(AuthenticationType type) {
    return _availableStrategies.any((s) => s.authenticationType == type);
  }

  void selectOptimalStrategy(AuthenticationContext context) {
    if (_availableStrategies.isEmpty) return;

    for (final strategy in _availableStrategies) {
      if (strategy.supportsBiometric() && _isBiometricAvailable(context)) {
        setStrategy(strategy);
        return;
      }
    }

    if (_availableStrategies.isNotEmpty) {
      setStrategy(_availableStrategies.first);
    }
  }

  bool _isBiometricAvailable(AuthenticationContext context) {
    final biometricMetadata = context.metadata['biometricAvailable'];
    return biometricMetadata == true;
  }
}

class AuthenticationException implements Exception {
  final String message;
  AuthenticationException(this.message);

  @override
  String toString() => 'AuthenticationException: $message';
}