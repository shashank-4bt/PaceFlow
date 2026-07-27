import 'package:equatable/equatable.dart';

/// Domain-level failure representation. Never throw these across layer boundaries;
/// wrap in [Result.failure] instead.
sealed class Failure extends Equatable {
  const Failure({required this.message, this.code});

  final String message;
  final String? code;

  @override
  List<Object?> get props => [message, code];
}

final class ServerFailure extends Failure {
  const ServerFailure({required super.message, super.code});
}

final class CacheFailure extends Failure {
  const CacheFailure({required super.message, super.code});
}

final class NetworkFailure extends Failure {
  const NetworkFailure({required super.message, super.code});
}

final class AuthFailure extends Failure {
  const AuthFailure({required super.message, super.code});
}

final class ValidationFailure extends Failure {
  const ValidationFailure({required super.message, super.code});
}

final class LocationFailure extends Failure {
  const LocationFailure({required super.message, super.code});
}

final class PermissionFailure extends Failure {
  const PermissionFailure({required super.message, super.code});
}

final class SyncFailure extends Failure {
  const SyncFailure({required super.message, super.code});
}

final class StorageFailure extends Failure {
  const StorageFailure({required super.message, super.code});
}

final class UnknownFailure extends Failure {
  const UnknownFailure({required super.message, super.code});
}
