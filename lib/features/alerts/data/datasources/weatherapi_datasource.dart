import 'package:dio/dio.dart';

import '../../../../app/config/app_config.dart';
import '../../../../app/constants/api_endpoints.dart';
import '../../../../core/errors/app_failure.dart';
import '../../../../core/network/api_client.dart';
import '../../domain/entities/weather_snapshot.dart';
import '../models/weatherapi_model.dart';
import '../weatherapi_mapper.dart';
import 'weather_data_source.dart';

/// Primary weather provider backed by WeatherAPI `forecast.json`.
class WeatherApiDataSource implements WeatherDataSource {
  const WeatherApiDataSource(this._dio);

  final Dio _dio;

  @override
  Future<WeatherSnapshot> fetchCurrentWeather({
    double latitude = AppConfig.defaultLatitude,
    double longitude = AppConfig.defaultLongitude,
  }) async {
    if (!AppConfig.hasWeatherApi) {
      throw const ConfigurationFailure(
        message: 'La información meteorológica todavía no está configurada.',
      );
    }

    late final Response<Map<String, dynamic>> response;
    try {
      response = await ApiClient.run(
        () => _dio.get<Map<String, dynamic>>(
          ApiEndpoints.weatherApiForecastPath,
          queryParameters: <String, dynamic>{
            'key': AppConfig.weatherApiKey,
            'q': '$latitude,$longitude',
            'days': 3,
            'aqi': 'no',
            'alerts': 'yes',
            'lang': 'es',
          },
        ),
      );
    } on UnauthorizedFailure catch (error) {
      throw ConfigurationFailure(
        message:
            'No pudimos autenticar WeatherAPI. Revisa la configuración de la clave.',
        cause: error,
      );
    }

    final data = response.data;
    if (data == null) {
      throw const ParsingFailure(
        message: 'La respuesta del servicio meteorológico está vacía.',
      );
    }

    try {
      final model = WeatherApiResponse.fromJson(data);
      return weatherSnapshotFromApi(
        model,
        fallbackLatitude: latitude,
        fallbackLongitude: longitude,
      );
    } on AppFailure {
      rethrow;
    } catch (error) {
      throw ParsingFailure(cause: error);
    }
  }
}
