import 'package:flutter_test/flutter_test.dart';
import 'package:hydro_alert/features/alerts/data/models/weatherapi_model.dart';
import 'package:hydro_alert/features/alerts/data/weatherapi_mapper.dart';

Map<String, dynamic> _responseJson({
  int code = 1183,
  int isDay = 1,
  List<Map<String, dynamic>> alerts = const [],
}) {
  return <String, dynamic>{
    'location': <String, dynamic>{
      'name': 'Managua',
      'lat': 12.13,
      'lon': -86.25,
      'tz_id': 'America/Managua',
    },
    'current': <String, dynamic>{
      'last_updated_epoch': 1730000000,
      'temp_c': 29.5,
      'feelslike_c': 33.0,
      'humidity': 74,
      'is_day': isDay,
      'precip_mm': 1.8,
      'condition': <String, dynamic>{
        'text': 'Lluvia moderada',
        'icon': '//cdn.weatherapi.com/weather/64x64/day/302.png',
        'code': code,
      },
    },
    if (alerts.isNotEmpty) 'alerts': <String, dynamic>{'alert': alerts},
  };
}

void main() {
  group('weatherVisualFromCode', () {
    test('maps clear conditions and keeps day/night', () {
      expect(weatherVisualFromCode(1000, isDay: true), (
        main: 'Clear',
        iconCode: '01d',
      ));
      expect(weatherVisualFromCode(1000, isDay: false), (
        main: 'Clear',
        iconCode: '01n',
      ));
    });

    test('groups rain, thunder, snow, drizzle and mist codes', () {
      expect(weatherVisualFromCode(1183, isDay: true).main, 'Rain');
      expect(weatherVisualFromCode(1087, isDay: true).main, 'Thunderstorm');
      expect(weatherVisualFromCode(1213, isDay: true).main, 'Snow');
      expect(weatherVisualFromCode(1153, isDay: true).main, 'Drizzle');
      expect(weatherVisualFromCode(1135, isDay: true).main, 'Mist');
      expect(weatherVisualFromCode(1012, isDay: true).main, 'Mist');
      expect(weatherVisualFromCode(1048, isDay: true).main, 'Dust');
      expect(weatherVisualFromCode(1003, isDay: true).main, 'Clouds');
    });
  });

  group('weatherSnapshotFromApi', () {
    test('maps the current weather and the declared alerts', () {
      final model = WeatherApiResponse.fromJson(
        _responseJson(
          alerts: [
            {
              'headline': 'Lluvia fuerte',
              'event': 'Aviso de lluvia',
              'effective': '2026-11-07T10:00:00-06:00',
              'expires': '2026-11-07T18:00:00-06:00',
              'desc': 'Se esperan lluvias intensas.',
              'instruction': 'Evita cruzar ríos.',
            },
          ],
        ),
      );

      final snapshot = weatherSnapshotFromApi(
        model,
        fallbackLatitude: 12.136389,
        fallbackLongitude: -86.251389,
      );

      expect(snapshot.temperatureC, 29.5);
      expect(snapshot.feelsLikeC, 33.0);
      expect(snapshot.humidity, 74);
      expect(snapshot.condition, 'Lluvia moderada');
      expect(snapshot.weatherMain, 'Rain');
      expect(snapshot.iconCode, '10d');
      expect(snapshot.rainLastHourMm, 1.8);
      expect(snapshot.latitude, 12.13);
      expect(snapshot.longitude, -86.25);
      expect(snapshot.alerts, hasLength(1));

      final alert = snapshot.alerts.single;
      expect(alert.senderName, 'Servicio meteorológico');
      expect(alert.event, 'Aviso de lluvia');
      expect(alert.description, 'Se esperan lluvias intensas.');
      expect(alert.start.isUtc, isFalse);
      expect(alert.end.isUtc, isFalse);
      expect(alert.start.toUtc(), DateTime.utc(2026, 11, 7, 16));
    });

    test(
      'drops alerts without valid dates and uses the instruction fallback',
      () {
        final model = WeatherApiResponse.fromJson(
          _responseJson(
            alerts: [
              {'event': 'Aviso sin fechas', 'desc': ''},
              {
                'headline': 'Aviso válido',
                'effective': '2026-11-07T10:00:00-06:00',
                'expires': '2026-11-07T18:00:00-06:00',
                'desc': '',
                'instruction': 'Mantente en casa.',
              },
            ],
          ),
        );

        final snapshot = weatherSnapshotFromApi(
          model,
          fallbackLatitude: 12.136389,
          fallbackLongitude: -86.251389,
        );

        final alert = snapshot.alerts.single;
        expect(alert.event, 'Aviso válido');
        expect(alert.description, 'Mantente en casa.');
      },
    );

    test(
      'falls back to the requested coordinates when location is missing',
      () {
        final json = _responseJson()..remove('location');
        final model = WeatherApiResponse.fromJson(json);

        final snapshot = weatherSnapshotFromApi(
          model,
          fallbackLatitude: 12.136389,
          fallbackLongitude: -86.251389,
        );

        expect(snapshot.latitude, 12.136389);
        expect(snapshot.longitude, -86.251389);
      },
    );
  });
}
