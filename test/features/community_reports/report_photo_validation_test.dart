import 'package:flutter_test/flutter_test.dart';
import 'package:hydro_alert/features/community_reports/presentation/services/report_photo_picker.dart';

void main() {
  group('validateReportPhoto', () {
    test('accepts supported images below the size limit', () {
      expect(
        validateReportPhoto(byteLength: 1024, fileName: 'foto.jpg'),
        isNull,
      );
      expect(
        validateReportPhoto(byteLength: 1024, fileName: 'foto.JPEG'),
        isNull,
      );
      expect(
        validateReportPhoto(byteLength: 1024, fileName: 'foto.png'),
        isNull,
      );
      expect(
        validateReportPhoto(byteLength: 1024, fileName: 'foto.webp'),
        isNull,
      );
    });

    test('rejects empty files', () {
      expect(
        validateReportPhoto(byteLength: 0, fileName: 'foto.jpg'),
        'La imagen seleccionada está vacía. Intenta con otra.',
      );
    });

    test('rejects files above 5 MB', () {
      expect(
        validateReportPhoto(
          byteLength: maxReportPhotoBytes + 1,
          fileName: 'foto.jpg',
        ),
        'La imagen supera los 5 MB. Elige una foto más liviana.',
      );
    });

    test('rejects unsupported extensions', () {
      expect(
        validateReportPhoto(byteLength: 1024, fileName: 'foto.gif'),
        'Formato no compatible. Usa JPG, PNG o WebP.',
      );
      expect(
        validateReportPhoto(byteLength: 1024, fileName: 'sin-extension'),
        'Formato no compatible. Usa JPG, PNG o WebP.',
      );
    });
  });
}
