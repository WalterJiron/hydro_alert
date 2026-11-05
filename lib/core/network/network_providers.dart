import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../app/config/app_config.dart';
import '../../app/constants/api_endpoints.dart';
import 'api_client.dart';

/// Shared Dio clients. Keep timeouts and headers in one place.

final backendDioProvider = Provider<Dio>((ref) {
  return ApiClient.create(baseUrl: AppConfig.normalizedApiBaseUrl);
});

final usgsDioProvider = Provider<Dio>((ref) {
  return ApiClient.create(baseUrl: '${ApiEndpoints.usgsBaseUrl}/');
});

final openWeatherDioProvider = Provider<Dio>((ref) {
  return ApiClient.create(baseUrl: '${ApiEndpoints.openWeatherBaseUrl}/');
});

final rainViewerDioProvider = Provider<Dio>((ref) {
  return ApiClient.create(baseUrl: '${ApiEndpoints.rainViewerBaseUrl}/');
});
