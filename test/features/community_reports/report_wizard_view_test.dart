import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hydro_alert/app/theme/app_theme.dart';
import 'package:hydro_alert/features/community_reports/presentation/views/report_wizard_view.dart';

void main() {
  testWidgets('wizard moves from the category step to the evidence step', (
    tester,
  ) async {
    tester.view.physicalSize = const Size(1080, 2400);
    tester.view.devicePixelRatio = 1;
    addTearDown(tester.view.reset);

    await tester.pumpWidget(
      ProviderScope(
        child: MaterialApp(
          theme: AppTheme.light,
          home: const ReportWizardView(),
        ),
      ),
    );
    await tester.pumpAndSettle();

    expect(find.text('¿Qué observas?'), findsOneWidget);

    await tester.tap(find.text('Inundación'));
    await tester.pump();
    await tester.tap(find.text('Continuar'));
    await tester.pumpAndSettle();

    expect(find.text('Ubicación'), findsOneWidget);
    expect(find.text('Foto'), findsOneWidget);
    expect(find.text('Antes de enviar'), findsOneWidget);
  });
}
