import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hydro_alert/app/theme/app_theme.dart';
import 'package:hydro_alert/features/map/presentation/widgets/map_layer_bar.dart';

void main() {
  testWidgets('layer bar shows the earthquake count and toggles layers', (
    tester,
  ) async {
    var earthquakeToggles = 0;
    var radarToggles = 0;

    await tester.pumpWidget(
      MaterialApp(
        theme: AppTheme.light,
        home: Scaffold(
          body: Center(
            child: MapLayerBar(
              earthquakesSelected: true,
              reportsSelected: false,
              radarSelected: false,
              radarLoading: false,
              reportsEnabled: false,
              earthquakeCount: 5,
              onToggleEarthquakes: () => earthquakeToggles++,
              onToggleReports: null,
              onToggleRadar: () => radarToggles++,
            ),
          ),
        ),
      ),
    );

    expect(find.text('Sismos'), findsOneWidget);
    expect(find.text('5'), findsOneWidget);
    expect(find.text('Reportes'), findsOneWidget);
    expect(find.text('Radar'), findsOneWidget);

    await tester.tap(find.text('Sismos'));
    await tester.tap(find.text('Radar'));
    await tester.pump();

    expect(earthquakeToggles, 1);
    expect(radarToggles, 1);
  });
}
