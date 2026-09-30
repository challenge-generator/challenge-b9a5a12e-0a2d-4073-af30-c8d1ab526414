import 'package:mobile_banking_app/core/design_patterns/strategy/authentication_strategy.dart';
import 'package:mobile_banking_app/core/utils/result.dart';
import 'package:local_auth/local_auth.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:uuid/uuid.dart';

class BiometricAuthStrategy implements AuthenticationStrategy {
  final LocalAuthentication _localAuth;
  final FlutterSecureStorage _secureStorage;
  final BiometricType _preferredBiometricType;
  final bool _allowLegacyFallback;

  BiometricAuthStrategy({
    LocalAuthentication? localAuth,
    FlutterSecureStorage? secureStorage,
    BiometricType preferredBiometricType = BiometricType.fingerprint,
    bool allowLegacyFallback = true,
  })  : _localAuth = localAuth ?? LocalAuthentication(),
        _secureStorage = secureStorage ?? const FlutterSecureStorage(),
        _preferredBiometricType = preferredBiometricType,
        _allowLegacyFallback = allowLegacyFallback;

  @override
  String get strategyName => 'BiometricAuthentication';

  @override
  AuthenticationType get authenticationType => AuthenticationType.biometric;

  @override
  bool supportsBiometric() => true;

  @override
  Future<Result<AuthenticationResult>> authenticate(AuthenticationContext context) async {
    try {
      final canAuthenticateWithBiometrics = await _localAuth.canCheckBiometrics;
      final canAuthenticate = canAuthenticateWithBiometrics || await _localAuth.isDeviceSupported();

      if (!canAuthenticate) {
        return Result.failure(BiometricNotAvailableException(
          'Biometric authentication is not available on this device',
        ));
      }

      final availableBiometrics = await _localAuth.getAvailableBiometrics();
      if (availableBiometrics.isEmpty) {
        return Result.failure(BiometricNotEnrolledException(
          'No biometric credentials enrolled on this device',
        ));
      }

      final authenticated = await _localAuth.authenticate(
        localizedReason: 'Authenticate to access your banking app',
        options: AuthenticationOptions(
          stickyAuth: true,
          biometricOnly: !_allowLegacyFallback,
          useErrorDialogs: true,
        ),
      );

      if (authenticated) {
        final sessionToken = await _generateSessionToken(context.userId);
        final expiresAt = DateTime.now().add(const Duration(hours: 24));

        await _secureStorage.write(
          key: 'biometric_session_${context.userId}',
          value: sessionToken,
        );

        return Result.success(AuthenticationResult.success(
          userId: context.userId,
          sessionToken: sessionToken,
          expiresAt: expiresAt,
          type: AuthenticationType.biometric,
        ));
      } else {
        return Result.failure(AuthenticationResult.failure(
          reason: 'Biometric authentication failed',
          type: AuthenticationType.biometric,
        ));
      }
    } on BiometricNotAvailableException catch (e) {
      return Result.failure(e);
    } on BiometricNotEnrolledException catch (e) {
      return Result.failure(e);
    } catch (e) {
      return Result.failure(BiometricAuthenticationException(
        'Unexpected error during biometric authentication: ${e.toString()}',
      ));
    }
  }

  Future<String> _generateSessionToken(String userId) async {
    final uuid = const Uuid();
    final timestamp = DateTime.now().millisecondsSinceEpoch;
    return '${userId}_${uuid.v4()}_$timestamp';
  }

  Future<bool> validateExistingSession(String userId, String sessionToken) async {
    final storedToken = await _secureStorage.read(key: 'biometric_session_$userId');
    return storedToken == sessionToken;
  }

  Future<void> revokeSession(String userId) async {
    await _secureStorage.delete(key: 'biometric_session_$userId');
  }

  Future<List<BiometricType>> getAvailableBiometricTypes() async {
    return await _localAuth.getAvailableBiometrics();
  }

  Future<bool> isDeviceSupported() async {
    return await _localAuth.isDeviceSupported();
  }

  Future<bool> canCheckBiometrics() async {
    return await _localAuth.canCheckBiometrics;
  }
}

class BiometricNotAvailableException implements Exception {
  final String message;
  BiometricNotAvailableException(this.message);

  @override
  String toString() => 'BiometricNotAvailableException: $message';
}

class BiometricNotEnrolledException implements Exception {
  final String message;
  BiometricNotEnrolledException(this.message);

  @override
  String toString() => 'BiometricNotEnrolledException: $message';
}

class BiometricAuthenticationException implements Exception {
  final String message;
  BiometricAuthenticationException(this.message);

  @override
  String toString() => 'BiometricAuthenticationException: $message';
}

enum BiometricType {
  fingerprint,
  face,
  iris,
}