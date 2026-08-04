import '../errors/failures.dart';

/// Functional result type for use-case and repository boundaries.
sealed class Result<T> {
  const Result();

  bool get isSuccess => this is Success<T>;
  bool get isFailure => this is FailureResult<T>;

  T? get valueOrNull => switch (this) {
        Success<T>(:final value) => value,
        FailureResult<T>() => null,
      };

  Failure? get failureOrNull => switch (this) {
        Success<T>() => null,
        FailureResult<T>(:final failure) => failure,
      };

  Result<R> map<R>(R Function(T value) transform) {
    return switch (this) {
      Success<T>(:final value) => Result.success(transform(value)),
      FailureResult<T>(:final failure) => Result.failure(failure),
    };
  }

  Result<R> flatMap<R>(Result<R> Function(T value) transform) {
    return switch (this) {
      Success<T>(:final value) => transform(value),
      FailureResult<T>(:final failure) => Result.failure(failure),
    };
  }

  R fold<R>({
    required R Function(T value) onSuccess,
    required R Function(Failure failure) onFailure,
  }) {
    return switch (this) {
      Success<T>(:final value) => onSuccess(value),
      FailureResult<T>(:final failure) => onFailure(failure),
    };
  }

  static Result<T> success<T>(T value) => Success<T>(value);

  static Result<T> failure<T>(Failure failure) => FailureResult<T>(failure);
}

final class Success<T> extends Result<T> {
  const Success(this.value);

  final T value;
}

final class FailureResult<T> extends Result<T> {
  const FailureResult(this.failure);

  final Failure failure;
}
