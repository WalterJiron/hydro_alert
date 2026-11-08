import 'package:dio/dio.dart';

import '../../../../app/config/app_config.dart';
import '../../../../app/constants/api_endpoints.dart';
import '../../../../core/errors/app_failure.dart';
import '../../../../core/network/api_client.dart';
import '../../domain/entities/weather_alert.dart';
import '../../domain/entities/weather_snapshot.dart';
import '../models/weather_model.dart';
import 'weather_data_source.dart';

class OpenWeatherDataSource implements WeatherDataSource {
  const OpenWeatherDataSource(this._dio);

  final Dio _dio;

  @override
  Future<WeatherSnapshot> fetchCurrentWeather({
    double latitude = AppConfig.defaultLatitude,
    double longitude = AppConfig.defaultLongitude,
  }) async {
    if (!AppConfig.hasOpenWeather) {
      throw const ConfigurationFailure(
        message: 'La información meteorológica todavía no está configurada.',
      );
    }

    late final Response<Map<String, dynamic>> response;
    try {
      response = await ApiClient.run(
        () => _dio.get<Map<String, dynamic>>(
          ApiEndpoints.openWeatherOneCallPath,
          queryParameters: <String, dynamic>{
            'lat': latitude,
            'lon': longitude,
            'appid': AppConfig.openWeatherApiKey,
            'units': 'metric',
            'lang': 'es',
          },
        ),
      );
    } on UnauthorizedFailure catch (error) {
      throw ConfigurationFailure(
        message:
            'No pudimos autenticar el servicio meteorológico. Revisa la configuración.',
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
      final model = OpenWeatherResponse.fromJson(data);
      final current = model.current;
      final temperature = current.temp;
      if (temperature == null) {
        throw const ParsingFailure(
          message: 'La respuesta del clima no incluye la temperatura actual.',
        );
      }

      final condition = current.weather.isNotEmpty
          ? current.weather.first
          : null;
      final observedAt = current.dt == null
          ? DateTime.now()
          : DateTime.fromMillisecondsSinceEpoch(
              current.dt! * 1000,
              isUtc: true,
            ).toLocal();

      return WeatherSnapshot(
        temperatureC: temperature,
        feelsLikeC: current.feelsLike ?? temperature,
        humidity: current.humidity ?? 0,
        condition: condition?.description?.trim().isNotEmpty == true
            ? condition!.description!.trim()
            : (condition?.main ?? 'Condición no disponible'),
        weatherMain: condition?.main ?? 'Unknown',
        iconCode: condition?.icon ?? '01d',
        observedAt: observedAt,
        latitude: model.lat ?? latitude,
        longitude: model.lon ?? longitude,
        rainLastHourMm: current.rain?.oneHour ?? current.rain?.threeHours,
        alerts: model.alerts.map(_toAlert).whereType<WeatherAlert>().toList(),
      );
    } on AppFailure {
      rethrow;
    } catch (error) {
      throw ParsingFailure(cause: error);
    }
  }

  WeatherAlert? _toAlert(OpenWeatherAlert alert) {
    final start = alert.start;
    final end = alert.end;
    if (start == null || end == null) {
      return null;
    }

    return WeatherAlert(
      senderName: alert.senderName?.trim().isNotEmpty == true
          ? alert.senderName!.trim()
          : 'Servicio meteorológico',
      event: alert.event?.trim().isNotEmpty == true
          ? alert.event!.trim()
          : 'Aviso meteorológico',
      start: DateTime.fromMillisecondsSinceEpoch(
        start * 1000,
        isUtc: true,
      ).toLocal(),
      end: DateTime.fromMillisecondsSinceEpoch(
        end * 1000,
        isUtc: true,
      ).toLocal(),
      description: alert.description?.trim() ?? '',
      tags: alert.tags,
    );
  }
}
