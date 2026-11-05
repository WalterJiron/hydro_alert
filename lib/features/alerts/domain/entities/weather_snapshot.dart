import 'package:freezed_annotation/freezed_annotation.dart';

import 'weather_alert.dart';

part 'weather_snapshot.freezed.dart';

@freezed
abstract class WeatherSnapshot with _$WeatherSnapshot {
  const factory WeatherSnapshot({
    required double temperatureC,
    required double feelsLikeC,
    required int humidity,
    required String condition,
    required String weatherMain,
    required String iconCode,
    required DateTime observedAt,
    required double latitude,
    required double longitude,
    double? rainLastHourMm,
    @Default(<WeatherAlert>[]) List<WeatherAlert> alerts,
  }) = _WeatherSnapshot;

  const WeatherSnapshot._();

  bool get hasRain => (rainLastHourMm ?? 0) > 0;

  String get rainLabel {
    final rain = rainLastHourMm;
    if (rain == null || rain <= 0) {
      return 'Sin lluvia registrada';
    }
    return '${rain.toStringAsFixed(1)} mm en la última hora';
  }
}
