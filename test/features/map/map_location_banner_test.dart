import 'package:flutter_test/flutter_test.dart';
import 'package:hydro_alert/core/services/location_service.dart';
import 'package:hydro_alert/features/map/presentation/widgets/map_location_banner.dart';

void main() {
  group('MapLocationBannerContent', () {
    test('explains a disabled location service and how to enable it', () {
      final content = MapLocationBannerContent.from(
        LocationAvailability.serviceDisabled,
      );

      expect(content.title, 'Ubicación desactivada');
      expect(content.actionLabel, 'Activar ubicación');
      expect(content.message, contains('Activa la ubicación'));
    });

    test('explains a denied permission and offers to request it', () {
      final content = MapLocationBannerContent.from(
        LocationAvailability.permissionDenied,
      );

      expect(content.title, 'Permiso de ubicación');
      expect(content.actionLabel, 'Permitir acceso');
    });

    test('explains a permanently denied permission and opens settings', () {
      final content = MapLocationBannerContent.from(
        LocationAvailability.permissionDeniedForever,
      );

      expect(content.title, 'Permiso bloqueado');
      expect(content.actionLabel, 'Abrir ajustes');
    });

    test('has no copy when location is ready', () {
      final content = MapLocationBannerContent.from(LocationAvailability.ready);

      expect(content.title, isEmpty);
      expect(content.message, isEmpty);
      expect(content.actionLabel, isEmpty);
    });
  });
}
