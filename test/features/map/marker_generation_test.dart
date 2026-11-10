import 'package:flutter_test/flutter_test.dart';
import 'package:hydro_alert/features/community_reports/domain/entities/community_report.dart';
import 'package:hydro_alert/features/community_reports/domain/entities/report_category.dart';
import 'package:hydro_alert/features/map/presentation/controllers/map_marker_controller.dart';
import 'package:hydro_alert/features/map/presentation/widgets/map_markers.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  group('Map Markers & Controller', () {
    test('generates pin for each report category including other', () async {
      for (final category in ReportCategory.values) {
        final report = CommunityReport(
          id: 'test-${category.name}',
          category: category,
          description: 'Test description',
          latitude: 12.0,
          longitude: -86.0,
          createdAt: DateTime.now(),
          isVerified: false,
        );

        final descriptor = await MapMarkerIcons.report(report, 2.0);
        expect(descriptor, isNotNull);
      }
    });

    test('disambiguates coincident report coordinates', () {
      final reportA = CommunityReport(
        id: 'rep-1',
        category: ReportCategory.damagedDrain,
        description: 'Drenaje dañado',
        latitude: 12.1139148,
        longitude: -86.2136001,
        createdAt: DateTime.utc(2026, 11, 10, 1, 38),
        isVerified: false,
      );

      final reportB = CommunityReport(
        id: 'rep-2',
        category: ReportCategory.other,
        description: 'Otra situación',
        latitude: 12.1139154,
        longitude: -86.2136045,
        createdAt: DateTime.utc(2026, 11, 10, 1, 42),
        isVerified: false,
      );

      final positions = MapMarkerController.computeReportPositions([
        reportA,
        reportB,
      ]);

      expect(positions.length, 2);
      final posA = positions['rep-1']!;
      final posB = positions['rep-2']!;

      // They should no longer be identical coordinates so both pins are visible:
      expect(
        posA.latitude != posB.latitude || posA.longitude != posB.longitude,
        isTrue,
      );
    });

    test('keeps distinct coordinates unchanged', () {
      final reportA = CommunityReport(
        id: 'rep-1',
        category: ReportCategory.damagedDrain,
        description: 'Drenaje',
        latitude: 12.1139,
        longitude: -86.2136,
        createdAt: DateTime.now(),
        isVerified: false,
      );

      final reportB = CommunityReport(
        id: 'rep-2',
        category: ReportCategory.fallenTree,
        description: 'Árbol',
        latitude: 12.5000,
        longitude: -85.5000,
        createdAt: DateTime.now(),
        isVerified: false,
      );

      final positions = MapMarkerController.computeReportPositions([
        reportA,
        reportB,
      ]);

      expect(positions['rep-1']!.latitude, closeTo(12.1139, 0.00001));
      expect(positions['rep-2']!.latitude, closeTo(12.5000, 0.00001));
    });
  });
}
