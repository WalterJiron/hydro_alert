import 'package:freezed_annotation/freezed_annotation.dart';

part 'weather_alert.freezed.dart';

@freezed
abstract class WeatherAlert with _$WeatherAlert {
  const factory WeatherAlert({
    required String senderName,
    required String event,
    required DateTime start,
    required DateTime end,
    required String description,
    @Default(<String>[]) List<String> tags,
  }) = _WeatherAlert;

  const WeatherAlert._();

  bool get isActive {
    final now = DateTime.now();
    return now.isAfter(start) && now.isBefore(end);
  }
}
