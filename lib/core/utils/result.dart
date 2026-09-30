library;

sealed class Result<T> {
  const Result();

  bool get isSuccess => this is Success<T>;
  bool get isFailure => this is Failure<T>;

  T? get data => this is Success<T> ? (this as Success<T>).value : null;
  AppException? get error => this is Failure<T> ? (this as Failure<T>).exception : null;

  R when<R>({
    required R Function(T value) success,
    required R Function(AppException exception) failure,
  }) {
    return switch (this) {
      Success<T>(:final value) => success(value),
      Failure<T>(:final exception) => failure(exception),
    };
  }

  R? whenOrNull<R>({
    R Function(T value)? success,
    R Function(AppException exception)? failure,
  }) {
    return switch (this) {
      Success<T>(:final value) => success?.call(value),
      Failure<T>(:final exception) => failure?.call(exception),
    };
  }

  Result<R> map<R>(R Function(T value) mapper) {
    return switch (this) {
      Success<T>(:final value) => Success(mapper(value)),
      Failure<T>(:final exception) => Failure(exception),
    };
  }

  Result<R> flatMap<R>(Result<R> Function(T value) mapper) {
    return switch (this) {
      Success<T>(:final value) => mapper(value),
      Failure<T>(:final exception) => Failure(exception),
    };
  }

  T getOrElse(T defaultValue) {
    return switch (this) {
      Success<T>(:final value) => value,
      Failure<T>() => defaultValue,
    };
  }

  T getOrThrow() {
    return switch (this) {
      Success<T>(:final value) => value,
      Failure<T>(:final exception) => throw exception,
    };
  }
}

final class Success<T> extends Result<T> {
  final T value;
  const Success(this.value);

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is Success<T> && other.value == value;
  }

  @override
  int get hashCode => value.hashCode;

  @override
  String toString() => 'Success($value)';
}

final class Failure<T> extends Result<T> {
  final AppException exception;
  const Failure(this.exception);

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is Failure<T> && other.exception == exception;
  }

  @override
  int get hashCode => exception.hashCode;

  @override
  String toString() => 'Failure($exception)';
}

sealed class AppException implements Exception {
  final String message;
  final String? code;
  final dynamic originalError;
  final StackTrace? stackTrace;

  const AppException({
    required this.message,
    this.code,
    this.originalError,
    this.stackTrace,
  });

  @override
  String toString() => 'AppException: $message (code: $code)';
}

final class NetworkException extends AppException {
  final int? statusCode;

  const NetworkException({
    required super.message,
    super.code,
    super.originalError,
    super.stackTrace,
    this.statusCode,
  });

  @override
  String toString() => 'NetworkException: $message (status: $statusCode)';
}

final class ServerException extends AppException {
  final int statusCode;

  const ServerException({
    required super.message,
    super.code,
    super.originalError,
    super.stackTrace,
    required this.statusCode,
  });

  @override
  String toString() => 'ServerException: $message (status: $statusCode)';
}

final class CacheException extends AppException {
  const CacheException({
    required super.message,
    super.code,
    super.originalError,
    super.stackTrace,
  });

  @override
  String toString() => 'CacheException: $message';
}

final class ValidationException extends AppException {
  final Map<String, String>? fieldErrors;

  const ValidationException({
    required super.message,
    super.code,
    super.originalError,
    super.stackTrace,
    this.fieldErrors,
  });

  @override
  String toString() => 'ValidationException: $message';
}

final class AuthenticationException extends AppException {
  final bool isLocked;
  final DateTime? lockedUntil;

  const AuthenticationException({
    required super.message,
    super.code,
    super.originalError,
    super.stackTrace,
    this.isLocked = false,
    this.lockedUntil,
  });

  @override
  String toString() => 'AuthenticationException: $message (locked: $isLocked)';
}

final class BiometricException extends AppException {
  final BiometricErrorType errorType;

  const BiometricException({
    required super.message,
    super.code,
    super.originalError,
    super.stackTrace,
    required this.errorType,
  });

  @override
  String toString() => 'BiometricException: $message (type: $errorType)';
}

enum BiometricErrorType {
  notAvailable,
  notEnrolled,
  lockout,
  failed,
  cancelled,
}

final class TimeoutException extends AppException {
  final Duration timeout;

  const TimeoutException({
    required super.message,
    super.code,
    super.originalError,
    super.stackTrace,
    required this.timeout,
  });

  @override
  String toString() => 'TimeoutException: $message (timeout: $timeout)';
}

final class BusinessException extends AppException {
  final String? businessCode;

  const BusinessException({
    required super.message,
    super.code,
    super.originalError,
    super.stackTrace,
    this.businessCode,
  });

  @override
  String toString() => 'BusinessException: $message (code: $businessCode)';
}

extension ResultExtensions<T> on Result<T> {
  Result<R> then<R>(R Function(T) action) {
    return map(action);
  }

  Future<Result<R>> thenAsync<R>(Future<R> Function(T) action) async {
    return map((value) => action(value));
  }

  Future<Result<R>> flatMapAsync<R>(Future<Result<R>> Function(T) action) async {
    return switch (this) {
      Success<T>(:final value) => await action(value),
      Failure<T>(:final exception) => Failure(exception),
    };
  }
}