import 'package:dio/dio.dart';

import '../errors/app_failure.dart';
import 'error_handler.dart';

/// Factory for Dio instances with consistent timeouts and headers.
class ApiClient {
  const ApiClient._();

  static Dio create({required String baseUrl, Map<String, String>? headers}) {
    final normalizedBaseUrl = baseUrl.isEmpty
        ? ''
        : (baseUrl.endsWith('/') ? baseUrl : '$baseUrl/');

    return Dio(
      BaseOptions(
        baseUrl: normalizedBaseUrl,
        connectTimeout: const Duration(seconds: 15),
        receiveTimeout: const Duration(seconds: 25),
        sendTimeout: const Duration(seconds: 25),
        responseType: ResponseType.json,
        headers: <String, String>{'Accept': 'application/json', ...?headers},
      ),
    );
  }

  /// Runs a request and converts low-level exceptions to [AppFailure].
  static Future<T> run<T>(Future<T> Function() request) async {
    try {
      return await request();
    } catch (error, stackTrace) {
      Error.throwWithStackTrace(ErrorHandler.handle(error), stackTrace);
    }
  }
}
