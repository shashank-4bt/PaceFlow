/// Data-layer exceptions thrown by datasources and caught by repositories.
sealed class AppException implements Exception {
  const AppException({required this.message, this.code, this.cause});

  final String message;
  final String? code;
  final Object? cause;

  @override
  String toString() =>
      '$runtimeType(message: $message, code: $code, cause: $cause)';
}

final class ServerException extends AppException {
  const ServerException({required super.message, super.code, super.cause});
}

final class CacheException extends AppException {
  const CacheException({required super.message, super.code, super.cause});
}

final class NetworkException extends AppException {
  const NetworkException({required super.message, super.code, super.cause});
}

final class AuthException extends AppException {
  const AuthException({required super.message, super.code, super.cause});
}

final class ValidationException extends AppException {
  const ValidationException({required super.message, super.code, super.cause});
}

final class LocationException extends AppException {
  const LocationException({required super.message, super.code, super.cause});
}

final class PermissionException extends AppException {
  const PermissionException({required super.message, super.code, super.cause});
}

final class SyncException extends AppException {
  const SyncException({required super.message, super.code, super.cause});
}

final class StorageException extends AppException {
  const StorageException({required super.message, super.code, super.cause});
}
