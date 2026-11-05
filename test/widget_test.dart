import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hydro_alert/app/theme/app_theme.dart';
import 'package:hydro_alert/features/auth/presentation/views/welcome_view.dart';

void main() {
  testWidgets('Welcome screen offers guest access without credentials', (
    tester,
  ) async {
    await tester.pumpWidget(
      ProviderScope(
        child: MaterialApp(theme: AppTheme.light, home: const WelcomeView()),
      ),
    );
    await tester.pump();

    expect(find.text('Continuar como invitado'), findsOneWidget);
    expect(find.text('HydroAlert'), findsOneWidget);
    expect(
      find.textContaining('no sustituye a las autoridades'),
      findsOneWidget,
    );
  });
}
