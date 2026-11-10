import 'package:dio/dio.dart';

import '../../../../app/constants/api_endpoints.dart';
import '../../../../core/errors/app_failure.dart';
import '../../../../core/network/api_client.dart';
import '../../domain/entities/app_user.dart';
import '../../domain/entities/auth_session.dart';

/// REST access to the HydroAlert reporter accounts.
class AuthRemoteDataSource {
  const AuthRemoteDataSource(this._dio);

  final Dio _dio;

  Future<AuthSession> register({
    required String name,
    required String email,
    required String password,
    required String cedula,
  }) async {
    final response = await ApiClient.run(
      () => _dio.post<Object?>(
        ApiEndpoints.authRegisterPath,
        data: <String, dynamic>{
          'name': name.trim(),
          'email': email.trim(),
          'password': password,
          'cedula': cedula.trim(),
        },
      ),
    );
    return _parseSession(response.data);
  }

  Future<AuthSession> login({
    required String email,
    required String password,
  }) async {
    final response = await ApiClient.run(
      () => _dio.post<Object?>(
        ApiEndpoints.authLoginPath,
        data: <String, dynamic>{'email': email.trim(), 'password': password},
      ),
    );
    return _parseSession(response.data);
  }

  AuthSession _parseSession(Object? data) {
    if (data is! Map) {
      throw const ParsingFailure(
        message: 'La respuesta de la cuenta tiene un formato inesperado.',
      );
    }

    final token = data['token'];
    final user = data['user'];
    if (token is! String || token.trim().isEmpty || user is! Map) {
      throw const ParsingFailure(
        message: 'La respuesta de la cuenta tiene un formato inesperado.',
      );
    }

    final id = _asString(user['id']);
    final name = _asString(user['name']);
    if (id == null || name == null) {
      throw const ParsingFailure(
        message: 'La respuesta de la cuenta tiene un formato inesperado.',
      );
    }

    return AuthSession(
      token: token.trim(),
      user: AppUser(
        id: id,
        displayName: name,
        email: _asString(user['email']),
        isGuest: false,
      ),
    );
  }

  String? _asString(Object? value) {
    return value is String && value.trim().isNotEmpty ? value.trim() : null;
  }
}
