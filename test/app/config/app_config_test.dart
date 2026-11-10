import 'package:flutter_test/flutter_test.dart';
import 'package:hydro_alert/app/config/app_config.dart';

void main() {
  group('AppConfig.resolveMediaUrl', () {
    test('keeps absolute URLs unchanged', () {
      expect(
        AppConfig.resolveMediaUrl('https://cdn.example.com/photo.jpg'),
        'https://cdn.example.com/photo.jpg',
      );
    });

    test('resolves root-relative paths against the API origin', () {
      expect(AppConfig.apiOrigin, isNotEmpty);
      expect(
        AppConfig.resolveMediaUrl('/api/v1/reports/photos/abc'),
        '${AppConfig.apiOrigin}/api/v1/reports/photos/abc',
      );
    });

    test('resolves protocol-relative URLs with the API scheme', () {
      final scheme = Uri.parse(AppConfig.apiOrigin).scheme;
      expect(
        AppConfig.resolveMediaUrl('//cdn.example.com/photo.jpg'),
        '$scheme://cdn.example.com/photo.jpg',
      );
    });

    test('resolves relative paths against the API origin', () {
      expect(
        AppConfig.resolveMediaUrl('reports/photos/abc'),
        '${AppConfig.apiOrigin}/reports/photos/abc',
      );
    });

    test('returns null for empty or whitespace values', () {
      expect(AppConfig.resolveMediaUrl(null), isNull);
      expect(AppConfig.resolveMediaUrl(''), isNull);
      expect(AppConfig.resolveMediaUrl('   '), isNull);
    });
  });

  group('AppConfig.realtimeWebSocketUri', () {
    test('builds the WebSocket endpoint from the API base', () {
      final uri = AppConfig.realtimeWebSocketUri;
      expect(uri, isNotNull);
      expect(
        uri!.scheme,
        AppConfig.normalizedApiBaseUrl.startsWith('https') ? 'wss' : 'ws',
      );
      expect(uri.path, endsWith('/api/v1/ws'));
    });
  });
}
