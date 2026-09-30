import 'package:mobile_banking_app/core/design_patterns/strategy/authentication_strategy.dart';
import 'package:mobile_banking_app/core/utils/result.dart';
import 'package:mobile_banking_app/domain/entities/account.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get_it/get_it.dart';

class PinAuthStrategy implements AuthenticationStrategy {
  static const String _pinKey = 'user_pin_hash';
  static const String _failedAttemptsKey = 'failed_pin_attempts';
  static const int _maxAttempts = 3;
  static const Duration _lockoutDuration = Duration(minutes: 5);

  final FlutterSecureStorage _secureStorage;
  DateTime? _lockoutUntil;

  PinAuthStrategy({FlutterSecureStorage? secureStorage})
      : _secureStorage = secureStorage ?? GetIt.instance<FlutterSecureStorage>();

  @override
  Future<Result<Account>> authenticate(Account account) async {
    if (_isLockedOut()) {
      final remainingTime = _lockoutUntil!.difference(DateTime.now());
      return Result.failure(
        'Cuenta bloqueada. Intenta de nuevo en ${remainingTime.inMinutes} minutos',
      );
    }

    return Result.success(account);
  }

  @override
  Future<bool> validateCredentials(String pin) async {
    if (_isLockedOut()) {
      return false;
    }

    final storedHash = await _secureStorage.read(key: _pinKey);
    if (storedHash == null) {
      return false;
    }

    final isValid = _verifyPin(pin, storedHash);
    
    if (!isValid) {
      await _incrementFailedAttempts();
    } else {
      await _resetFailedAttempts();
    }

    return isValid;
  }

  @override
  Future<Result<void>> setupAuthentication(Account account) async {
    try {
      final pin = _generateInitialPin();
      final hash = _hashPin(pin);
      await _secureStorage.write(key: _pinKey, value: hash);
      await _resetFailedAttempts();
      return Result.success(null);
    } catch (e) {
      return Result.failure('Error al configurar PIN: $e');
    }
  }

  @override
  Future<Result<void>> changePin(String currentPin, String newPin) async {
    final isValid = await validateCredentials(currentPin);
    if (!isValid) {
      return Result.failure('PIN actual incorrecto');
    }

    final newHash = _hashPin(newPin);
    await _secureStorage.write(key: _pinKey, value: newHash);
    return Result.success(null);
  }

  @override
  bool get requiresBiometric => false;

  @override
  String get authType => 'PIN';

  bool _isLockedOut() {
    if (_lockoutUntil == null) return false;
    if (DateTime.now().isAfter(_lockoutUntil!)) {
      _lockoutUntil = null;
      return false;
    }
    return true;
  }

  Future<void> _incrementFailedAttempts() async {
    final currentAttempts = await _secureStorage.read(key: _failedAttemptsKey);
    final attempts = int.tryParse(currentAttempts ?? '0') ?? 0;
    final newAttempts = attempts + 1;
    await _secureStorage.write(key: _failedAttemptsKey, value: newAttempts.toString());

    if (newAttempts >= _maxAttempts) {
      _lockoutUntil = DateTime.now().add(_lockoutDuration);
    }
  }

  Future<void> _resetFailedAttempts() async {
    await _secureStorage.delete(key: _failedAttemptsKey);
    _lockoutUntil = null;
  }

  String _hashPin(String pin) {
    var hash = 0;
    for (var i = 0; i < pin.length; i++) {
      hash = ((hash << 5) - hash) + pin.codeUnitAt(i);
      hash = hash & 0xFFFFFFFF;
    }
    return hash.toRadixString(16);
  }

  bool _verifyPin(String pin, String storedHash) {
    return _hashPin(pin) == storedHash;
  }

  String _generateInitialPin() {
    return '1234';
  }

  Future<bool> hasPinConfigured() async {
    final storedHash = await _secureStorage.read(key: _pinKey);
    return storedHash != null;
  }

  Future<int> getFailedAttempts() async {
    final attempts = await _secureStorage.read(key: _failedAttemptsKey);
    return int.tryParse(attempts ?? '0') ?? 0;
  }
}