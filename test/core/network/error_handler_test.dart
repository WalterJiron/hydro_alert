import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hydro_alert/core/errors/app_failure.dart';
import 'package:hydro_alert/core/network/error_handler.dart';

void main() {
  group('ErrorHandler backend error translation', () {
    test('maps duplicate email to a Spanish message', () {
      final failure = ErrorHandler.handle(
        _badResponse(409, 'email_already_registered'),
      );

      expect(failure, isA<ServerFailure>());
      expect(failure.message, contains('correo ya tiene una cuenta'));
    });

    test('maps duplicate cedula to a Spanish message', () {
      final failure = ErrorHandler.handle(
        _badResponse(409, 'cedula_already_registered'),
      );

      expect(failure, isA<ServerFailure>());
      expect(failure.message, contains('cédula ya está registrada'));
    });

    test('maps invalid credentials to an unauthorized failure', () {
      final failure = ErrorHandler.handle(
        _badResponse(401, 'invalid_credentials'),
      );

      expect(failure, isA<UnauthorizedFailure>());
      expect(failure.message, 'Correo o contraseña incorrectos.');
    });

    test('maps an expired token to an unauthorized failure', () {
      final failure = ErrorHandler.handle(_badResponse(401, 'invalid_token'));

      expect(failure, isA<UnauthorizedFailure>());
      expect(failure.message, contains('sesión expiró'));
    });

    test('translates registration validation messages', () {
      final failure = ErrorHandler.handle(
        _badResponse(
          400,
          'invalid_registration',
          message: 'Password must be at least 8 characters long.',
        ),
      );

      expect(failure, isA<ServerFailure>());
      expect(
        failure.message,
        'La contraseña debe tener al menos 8 caracteres.',
      );
    });

    test('maps oversized photos to a Spanish message', () {
      final failure = ErrorHandler.handle(_badResponse(413, 'photo_too_large'));

      expect(failure, isA<ServerFailure>());
      expect(failure.message, contains('5 MB'));
    });

    test('maps unsupported photos to a Spanish message', () {
      final failure = ErrorHandler.handle(
        _badResponse(422, 'unsupported_photo'),
      );

      expect(failure, isA<ServerFailure>());
      expect(failure.message, contains('JPG, PNG o WebP'));
    });

    test('maps rate limiting to a rate limit failure', () {
      final failure = ErrorHandler.handle(_badResponse(429, 'rate_limited'));

      expect(failure, isA<RateLimitFailure>());
      expect(failure.message, contains('límite de consultas'));
    });

    test('maps unexpected server errors without leaking backend text', () {
      final failure = ErrorHandler.handle(
        _badResponse(500, 'database_error', message: 'Connection refused'),
      );

      expect(failure, isA<ServerFailure>());
      expect(failure.message, contains('no está disponible'));
      expect(failure.message, isNot(contains('Connection refused')));
    });

    test('maps connection errors to a friendly network failure', () {
      final failure = ErrorHandler.handle(
        DioException(
          requestOptions: RequestOptions(path: '/api/v1/reports/active'),
          type: DioExceptionType.connectionError,
        ),
      );

      expect(failure, isA<NetworkFailure>());
    });
  });
}

DioException _badResponse(
  int statusCode,
  String code, {
  String message = 'Backend message',
}) {
  final options = RequestOptions(path: '/api/v1/test');
  return DioException(
    requestOptions: options,
    type: DioExceptionType.badResponse,
    response: Response<Object?>(
      requestOptions: options,
      statusCode: statusCode,
      data: <String, dynamic>{
        'error': <String, dynamic>{'code': code, 'message': message},
        'message': message,
      },
    ),
  );
}
