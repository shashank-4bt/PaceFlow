import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import '../constants/storage_keys.dart';
import '../errors/exceptions.dart';
import '../logging/app_logger.dart';

/// Secure key-value storage for tokens and sensitive preferences.
class SecureStorageService {
  SecureStorageService({FlutterSecureStorage? storage})
      : _storage = storage ??
            const FlutterSecureStorage(
              aOptions: AndroidOptions(encryptedSharedPreferences: true),
            );

  final FlutterSecureStorage _storage;
  final AppLogger _logger = AppLogger('SecureStorageService');

  Future<String?> read(String key) async {
    try {
      return await _storage.read(key: key);
    } catch (error, stackTrace) {
      _logger.error('Failed to read secure key: $key', error, stackTrace);
      throw StorageException(
        message: 'Failed to read secure storage.',
        cause: error,
      );
    }
  }

  Future<void> write(String key, String value) async {
    try {
      await _storage.write(key: key, value: value);
    } catch (error, stackTrace) {
      _logger.error('Failed to write secure key: $key', error, stackTrace);
      throw StorageException(
        message: 'Failed to write secure storage.',
        cause: error,
      );
    }
  }

  Future<void> delete(String key) async {
    try {
      await _storage.delete(key: key);
    } catch (error, stackTrace) {
      _logger.error('Failed to delete secure key: $key', error, stackTrace);
      throw StorageException(
        message: 'Failed to delete secure storage entry.',
        cause: error,
      );
    }
  }

  Future<void> deleteAll() async {
    try {
      await _storage.deleteAll();
    } catch (error, stackTrace) {
      _logger.error('Failed to clear secure storage', error, stackTrace);
      throw StorageException(
        message: 'Failed to clear secure storage.',
        cause: error,
      );
    }
  }

  Future<bool> containsKey(String key) async {
    try {
      return await _storage.containsKey(key: key);
    } catch (error, stackTrace) {
      _logger.error('Failed to check secure key: $key', error, stackTrace);
      throw StorageException(
        message: 'Failed to access secure storage.',
        cause: error,
      );
    }
  }

  Future<void> saveAuthTokens({
    required String idToken,
    String? refreshToken,
  }) async {
    await write(StorageKeys.authIdToken, idToken);
    if (refreshToken != null) {
      await write(StorageKeys.authRefreshToken, refreshToken);
    }
  }

  Future<void> clearAuthTokens() async {
    await delete(StorageKeys.authIdToken);
    await delete(StorageKeys.authRefreshToken);
  }

  Future<String?> getIdToken() => read(StorageKeys.authIdToken);

  Future<String?> getRefreshToken() => read(StorageKeys.authRefreshToken);
}
