import 'package:firebase_auth/firebase_auth.dart';

import 'exceptions.dart';
import 'failures.dart';
import '../logging/app_logger.dart';

/// Maps exceptions and platform errors to domain [Failure] instances.
abstract final class ErrorHandler {
  static final AppLogger _logger = AppLogger('ErrorHandler');

  static Failure mapException(Object error, [StackTrace? stackTrace]) {
    _logger.error('Mapping exception', error, stackTrace);

    if (error is Failure) {
      return error;
    }

    if (error is AppException) {
      return _mapAppException(error);
    }

    if (error is FirebaseAuthException) {
      return AuthFailure(
        message: _firebaseAuthMessage(error),
        code: error.code,
      );
    }

    if (error is FirebaseException) {
      return ServerFailure(
        message: error.message ?? 'A server error occurred.',
        code: error.code,
      );
    }

    if (error is FormatException) {
      return ValidationFailure(
        message: error.message,
        code: 'format_error',
      );
    }

    if (error is StateError) {
      return UnknownFailure(
        message: error.message,
        code: 'state_error',
      );
    }

    return UnknownFailure(
      message: error.toString(),
      code: 'unknown',
    );
  }

  static Failure _mapAppException(AppException exception) {
    return switch (exception) {
      ServerException() => ServerFailure(
          message: exception.message,
          code: exception.code,
        ),
      CacheException() => CacheFailure(
          message: exception.message,
          code: exception.code,
        ),
      NetworkException() => NetworkFailure(
          message: exception.message,
          code: exception.code,
        ),
      AuthException() => AuthFailure(
          message: exception.message,
          code: exception.code,
        ),
      ValidationException() => ValidationFailure(
          message: exception.message,
          code: exception.code,
        ),
      LocationException() => LocationFailure(
          message: exception.message,
          code: exception.code,
        ),
      PermissionException() => PermissionFailure(
          message: exception.message,
          code: exception.code,
        ),
      SyncException() => SyncFailure(
          message: exception.message,
          code: exception.code,
        ),
      StorageException() => StorageFailure(
          message: exception.message,
          code: exception.code,
        ),
    };
  }

  static String _firebaseAuthMessage(FirebaseAuthException error) {
    return switch (error.code) {
      'invalid-email' => 'The email address is not valid.',
      'user-disabled' => 'This account has been disabled.',
      'user-not-found' => 'No account found for this email.',
      'wrong-password' => 'Incorrect password. Please try again.',
      'email-already-in-use' =>
        'An account already exists with this email address.',
      'weak-password' => 'Password is too weak. Use at least 8 characters.',
      'operation-not-allowed' => 'This sign-in method is not enabled.',
      'too-many-requests' =>
        'Too many attempts. Please wait a moment and try again.',
      'network-request-failed' =>
        'Network error. Check your connection and try again.',
      'requires-recent-login' =>
        'Please sign in again to complete this sensitive action.',
      'invalid-credential' => 'Invalid credentials. Please try again.',
      'account-exists-with-different-credential' =>
        'An account already exists with a different sign-in method.',
      'credential-already-in-use' =>
        'This credential is already linked to another account.',
      _ => error.message ?? 'Authentication failed. Please try again.',
    };
  }

  static String userMessage(Failure failure) => failure.message;
}
