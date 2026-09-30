package mobile_banking_app.core.design_patterns.singleton;

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:uuid/uuid.dart';

class SecureStorage {
  static SecureStorage? _instance;
  final FlutterSecureStorage _storage;
  final Uuid _uuid = const Uuid();
  
  SecureStorage._internal()
      : _storage = const FlutterSecureStorage(
          aOptions: AndroidOptions(
            encryptedSharedPreferences: true,
            accessibility: KeychainAccessibility.first_unlock_this_device,
          ),
          iOptions: IOSOptions(
            accessibility: KeychainAccessibility.first_unlock_this_device,
          ),
        );
  
  static SecureStorage get instance {
    _instance ??= SecureStorage._internal();
    return _instance!;
  }
  
  Future<void> saveCredentials(String key, String value) async {
    await _storage.write(key: key, value: value);
  }
  
  Future<String?> getCredentials(String key) async {
    return await _storage.read(key: key);
  }
  
  Future<void> deleteCredentials(String key) async {
    await _storage.delete(key: key);
  }
  
  Future<void> saveAuthToken(String token) async {
    await saveCredentials('auth_token', token);
    await saveCredentials('token_timestamp', DateTime.now().toIso8601String());
  }
  
  Future<String?> getAuthToken() async {
    final token = await getCredentials('auth_token');
    if (token == null) return null;
    
    final timestampStr = await getCredentials('token_timestamp');
    if (timestampStr != null) {
      final timestamp = DateTime.parse(timestampStr);
      final expiry = timestamp.add(const Duration(hours: 24));
      if (DateTime.now().isAfter(expiry)) {
        await deleteCredentials('auth_token');
        await deleteCredentials('token_timestamp');
        return null;
      }
    }
    return token;
  }
  
  Future<void> clearAllCredentials() async {
    await _storage.deleteAll();
  }
  
  Future<void> saveUserCredentials(String userId, String pin) async {
    final salt = _uuid.v4();
    final hashedPin = _hashPin(pin, salt);
    await saveCredentials('user_$userId_pin', hashedPin);
    await saveCredentials('user_$userId_salt', salt);
  }
  
  Future<bool> validateUserPin(String userId, String pin) async {
    final storedHash = await getCredentials('user_$userId_pin');
    final storedSalt = await getCredentials('user_$userId_salt');
    
    if (storedHash == null || storedSalt == null) return false;
    
    final inputHash = _hashPin(pin, storedSalt);
    return storedHash == inputHash;
  }
  
  String _hashPin(String pin, String salt) {
    var combined = '$salt$pin$salt';
    var hash = 0;
    for (var i = 0; i < combined.length; i++) {
      hash = ((hash << 5) - hash) + combined.codeUnitAt(i);
      hash = hash & 0xFFFFFFFF;
    }
    return hash.toRadixString(16);
  }
  
  Future<void> saveBiometricKey(String userId, String biometricData) async {
    await saveCredentials('biometric_$userId', biometricData);
  }
  
  Future<String?> getBiometricKey(String userId) async {
    return await getCredentials('biometric_$userId');
  }
  
  Future<bool> hasBiometricSetup(String userId) async {
    final key = await getBiometricKey(userId);
    return key != null && key.isNotEmpty;
  }
  
  Future<void> saveLastLogin(String userId) async {
    await saveCredentials('last_login_$userId', DateTime.now().toIso8601String());
  }
  
  Future<DateTime?> getLastLogin(String userId) async {
    final timestamp = await getCredentials('last_login_$userId');
    if (timestamp == null) return null;
    return DateTime.tryParse(timestamp);
  }
  
  Future<void> saveAccountCredentials(String accountId, String credentials) async {
    await saveCredentials('account_$accountId_credentials', credentials);
  }
  
  Future<String?> getAccountCredentials(String accountId) async {
    return await getCredentials('account_$accountId_credentials');
  }
}