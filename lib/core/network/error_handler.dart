import 'package:dio/dio.dart';

import '../errors/app_failure.dart';

/// Maps low-level errors to safe, user-facing failures.
class ErrorHandler {
  const ErrorHandler._();

  static AppFailure handle(Object error) {
    if (error is AppFailure) {
      return error;
    }

    if (error is DioException) {
      return _fromDio(error);
    }

    if (error is FormatException) {
      return ParsingFailure(cause: error);
    }

    if (error is StateError) {
      return ParsingFailure(cause: error);
    }

    return UnknownFailure(cause: error);
  }

  static AppFailure _fromDio(DioException error) {
    switch (error.type) {
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.sendTimeout:
      case DioExceptionType.receiveTimeout:
      case DioExceptionType.transformTimeout:
        return TimeoutFailure(cause: error);
      case DioExceptionType.badCertificate:
      case DioExceptionType.connectionError:
        return NetworkFailure(cause: error);
      case DioExceptionType.cancel:
        return CancelledFailure(cause: error);
      case DioExceptionType.badResponse:
        return _fromResponse(error);
      case DioExceptionType.unknown:
        return NetworkFailure(cause: error);
    }
  }

  static AppFailure _fromResponse(DioException error) {
    final statusCode = error.response?.statusCode;

    if (statusCode == 401 || statusCode == 403) {
      return UnauthorizedFailure(cause: error);
    }
    if (statusCode == 404) {
      return NotFoundFailure(cause: error);
    }
    if (statusCode == 429) {
      return RateLimitFailure(cause: error);
    }
    if (statusCode != null && statusCode >= 500) {
      return ServerFailure(cause: error, statusCode: statusCode);
    }

    return ServerFailure(
      message: 'La solicitud no pudo completarse. Inténtalo de nuevo.',
      cause: error,
      statusCode: statusCode,
    );
  }
}
