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
    final backendError = _BackendError.from(error.response?.data);

    switch (backendError?.code) {
      case 'email_already_registered':
        return ServerFailure(
          message: 'Ese correo ya tiene una cuenta. Inicia sesión.',
          cause: error,
          statusCode: statusCode,
        );
      case 'cedula_already_registered':
        return ServerFailure(
          message: 'Esa cédula ya está registrada. Inicia sesión.',
          cause: error,
          statusCode: statusCode,
        );
      case 'invalid_credentials':
        return UnauthorizedFailure(
          message: 'Correo o contraseña incorrectos.',
          cause: error,
        );
      case 'invalid_token':
        return UnauthorizedFailure(
          message: 'Tu sesión expiró. Inicia sesión de nuevo.',
          cause: error,
        );
      case 'invalid_registration':
      case 'invalid_login':
      case 'invalid_request':
        return ServerFailure(
          message:
              _translateValidationMessage(backendError?.message) ??
              'Revisa los datos e inténtalo de nuevo.',
          cause: error,
          statusCode: statusCode,
        );
      case 'invalid_report':
        return ServerFailure(
          message:
              _translateValidationMessage(backendError?.message) ??
              'El reporte no es válido. Revisa los datos e inténtalo de nuevo.',
          cause: error,
          statusCode: statusCode,
        );
      case 'photo_too_large':
        return ServerFailure(
          message: 'La foto supera el tamaño máximo permitido (5 MB).',
          cause: error,
          statusCode: statusCode,
        );
      case 'unsupported_photo':
        return ServerFailure(
          message: 'La foto debe ser JPG, PNG o WebP.',
          cause: error,
          statusCode: statusCode,
        );
      case 'rate_limited':
        return RateLimitFailure(cause: error);
      case 'ineter_unavailable':
        return ServerFailure(
          message:
              'INETER no está disponible en este momento. Inténtalo más tarde.',
          cause: error,
          statusCode: statusCode,
        );
      case 'not_found':
        return NotFoundFailure(cause: error);
    }

    if (statusCode == 401 || statusCode == 403) {
      return UnauthorizedFailure(
        message: 'Tu sesión expiró. Inicia sesión de nuevo.',
        cause: error,
      );
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

  static String? _translateValidationMessage(String? raw) {
    final message = raw?.trim();
    if (message == null || message.isEmpty) {
      return null;
    }

    final normalized = message.toLowerCase();
    if (normalized.contains('name is required')) {
      return 'El nombre es obligatorio.';
    }
    if (normalized.contains('name must be at least')) {
      return 'El nombre debe tener al menos 3 caracteres.';
    }
    if (normalized.contains('name cannot exceed')) {
      return 'El nombre no puede superar los 80 caracteres.';
    }
    if (normalized.contains('email is required')) {
      return 'El correo es obligatorio.';
    }
    if (normalized.contains('email format is invalid')) {
      return 'El correo no tiene un formato válido.';
    }
    if (normalized.contains('password is required')) {
      return 'La contraseña es obligatoria.';
    }
    if (normalized.contains('password must be at least')) {
      return 'La contraseña debe tener al menos 8 caracteres.';
    }
    if (normalized.contains('password cannot exceed')) {
      return 'La contraseña es demasiado larga.';
    }
    if (normalized.contains('cédula is required') ||
        normalized.contains('cedula is required')) {
      return 'La cédula es obligatoria.';
    }
    if (normalized.contains('official nicaraguan format')) {
      return 'La cédula debe tener el formato 000-000000-0000A.';
    }
    if (normalized.contains('birth date included in cédula')) {
      return 'La fecha de nacimiento de la cédula no es válida.';
    }
    if (normalized.contains('invalid email or password')) {
      return 'Correo o contraseña incorrectos.';
    }
    if (normalized.contains('description')) {
      return 'La descripción debe tener entre 10 y 500 caracteres.';
    }
    if (normalized.contains('latitude') ||
        normalized.contains('longitude') ||
        normalized.contains('location')) {
      return 'La ubicación del reporte no es válida.';
    }
    if (normalized.contains('category')) {
      return 'Selecciona una categoría válida.';
    }

    return null;
  }
}

/// Shape used by the HydroAlert backend: `{ "error": { "code", "message" } }`.
class _BackendError {
  const _BackendError({required this.code, required this.message});

  final String? code;
  final String? message;

  static _BackendError? from(Object? data) {
    if (data is! Map) {
      return null;
    }

    final error = data['error'];
    if (error is Map) {
      return _BackendError(
        code: _asString(error['code']),
        message: _asString(error['message']) ?? _asString(data['message']),
      );
    }

    final code = _asString(data['code']);
    final message = _asString(data['message']);
    if (code == null && message == null) {
      return null;
    }
    return _BackendError(code: code, message: message);
  }

  static String? _asString(Object? value) {
    return value is String && value.trim().isNotEmpty ? value.trim() : null;
  }
}
