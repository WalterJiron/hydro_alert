import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hydro_alert/app/theme/app_colors.dart';
import 'package:hydro_alert/app/theme/app_theme.dart';
import 'package:hydro_alert/app/theme/app_typography.dart';

void main() {
  test('light and dark themes expose the matching palette', () {
    expect(AppTheme.light.brightness, Brightness.light);
    expect(AppTheme.dark.brightness, Brightness.dark);
    expect(AppTheme.light.extension<AppPalette>(), AppPalette.light);
    expect(AppTheme.dark.extension<AppPalette>(), AppPalette.dark);
  });

  testWidgets('widgets resolve the dark palette from the active theme', (
    tester,
  ) async {
    late AppPalette palette;

    await tester.pumpWidget(
      MaterialApp(
        theme: AppTheme.dark,
        home: Builder(
          builder: (context) {
            palette = context.palette;
            return const SizedBox.shrink();
          },
        ),
      ),
    );

    expect(palette, AppPalette.dark);
    expect(palette.surface, AppPalette.dark.surface);
    expect(palette.textPrimary, AppPalette.dark.textPrimary);
  });

  testWidgets('themeMode.system follows the platform brightness', (
    tester,
  ) async {
    tester.platformDispatcher.platformBrightnessTestValue = Brightness.dark;
    addTearDown(tester.platformDispatcher.clearPlatformBrightnessTestValue);

    late ThemeData theme;

    await tester.pumpWidget(
      MaterialApp(
        theme: AppTheme.light,
        darkTheme: AppTheme.dark,
        themeMode: ThemeMode.system,
        home: Builder(
          builder: (context) {
            theme = Theme.of(context);
            return const SizedBox.shrink();
          },
        ),
      ),
    );

    expect(theme.brightness, Brightness.dark);
    expect(theme.extension<AppPalette>(), AppPalette.dark);
  });

  testWidgets('static typography inherits the active text color', (
    tester,
  ) async {
    await tester.pumpWidget(
      MaterialApp(
        theme: AppTheme.dark,
        home: Scaffold(body: Text('Hola', style: AppTypography.titleLarge)),
      ),
    );

    final context = tester.element(find.text('Hola'));
    final style = DefaultTextStyle.of(
      context,
    ).style.merge(AppTypography.titleLarge);

    expect(style.color, AppPalette.dark.textPrimary);
  });
}
