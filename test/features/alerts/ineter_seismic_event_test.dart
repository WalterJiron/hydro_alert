import 'package:flutter_test/flutter_test.dart';
import 'package:hydro_alert/features/alerts/data/models/ineter_seismic_event_model.dart';

void main() {
  group('IneterSeismicEventModel', () {
    test('maps a complete INETER payload to a seismic event', () {
      final model = IneterSeismicEventModel.fromJson(<String, dynamic>{
        'id': 'evt-1',
        'event_at': '2026-11-08T21:30:00Z',
        'latitude': 12.136389,
        'longitude': -86.251389,
        'depth_km': 10.2,
        'magnitude': 4.6,
        'location': 'Managua, Nicaragua',
        'pais': 'Nicaragua',
        'status': 'C',
        'source': 'INETER',
      });

      expect(model.eventAt.toUtc(), DateTime.utc(2026, 11, 8, 21, 30));

      final event = model.toEntity();
      expect(event, isNotNull);
      expect(event!.id, 'evt-1');
      expect(event.magnitude, 4.6);
      expect(event.place, 'Managua, Nicaragua');
      expect(event.depthKm, 10.2);
      expect(event.reviewStatus, 'C');
      expect(event.source, 'INETER');
      expect(event.url, contains('ineter'));
      expect(event.occurredAt.isUtc, isFalse);
    });

    test('parses event_date/event_time as Nicaragua time (UTC-6)', () {
      final model = IneterSeismicEventModel.fromJson(<String, dynamic>{
        'id': 'evt-2',
        'event_date': '2026-11-08',
        'event_time': '15:30:00',
        'latitude': '12.1',
        'longitude': '-86.2',
        'magnitude': '3.9',
      });

      expect(model.eventAt.toUtc(), DateTime.utc(2026, 11, 8, 21, 30));
      expect(model.location, 'Ubicación no disponible');
      expect(model.toEntity()!.source, 'INETER');
    });

    test('uses the backend source when it is provided', () {
      final model = IneterSeismicEventModel.fromJson(<String, dynamic>{
        'id': 'evt-3',
        'event_at': '2026-11-08T21:30:00Z',
        'latitude': 12,
        'longitude': -86,
        'magnitude': 3.1,
        'source': 'usgs',
      });

      expect(model.toEntity()!.source, 'USGS');
    });

    test('returns no event when the magnitude is missing', () {
      final model = IneterSeismicEventModel.fromJson(<String, dynamic>{
        'id': 'evt-4',
        'event_at': '2026-11-08T21:30:00Z',
        'latitude': 12,
        'longitude': -86,
      });

      expect(model.toEntity(), isNull);
    });

    test('rejects events without id or coordinates', () {
      expect(
        () => IneterSeismicEventModel.fromJson(<String, dynamic>{
          'event_at': '2026-11-08T21:30:00Z',
          'latitude': 12,
          'longitude': -86,
          'magnitude': 4.0,
        }),
        throwsFormatException,
      );

      expect(
        () => IneterSeismicEventModel.fromJson(<String, dynamic>{
          'id': 'evt-5',
          'event_at': '2026-11-08T21:30:00Z',
          'magnitude': 4.0,
        }),
        throwsFormatException,
      );
    });
  });
}
