import 'package:flutter/material.dart';

import 'app_colors.dart';

/// Typography scale used across the application.
///
/// The base styles intentionally have no color: they inherit the ambient
/// [DefaultTextStyle] so they work in both light and dark mode. Use
/// [textThemeFor] when the colors must be resolved explicitly.
///
/// The app uses the platform font to avoid an extra font download and to keep
/// the first render fast and predictable.
class AppTypography {
  const AppTypography._();

  static const TextStyle displayLarge = TextStyle(
    fontSize: 34,
    height: 1.08,
    fontWeight: FontWeight.w800,
    letterSpacing: -0.8,
  );

  static const TextStyle displayMedium = TextStyle(
    fontSize: 28,
    height: 1.12,
    fontWeight: FontWeight.w800,
    letterSpacing: -0.5,
  );

  static const TextStyle headlineMedium = TextStyle(
    fontSize: 24,
    height: 1.2,
    fontWeight: FontWeight.w700,
    letterSpacing: -0.2,
  );

  static const TextStyle headlineSmall = TextStyle(
    fontSize: 20,
    height: 1.25,
    fontWeight: FontWeight.w700,
  );

  static const TextStyle titleLarge = TextStyle(
    fontSize: 18,
    height: 1.3,
    fontWeight: FontWeight.w700,
  );

  static const TextStyle titleMedium = TextStyle(
    fontSize: 16,
    height: 1.35,
    fontWeight: FontWeight.w600,
  );

  static const TextStyle titleSmall = TextStyle(
    fontSize: 14,
    height: 1.35,
    fontWeight: FontWeight.w600,
  );

  static const TextStyle bodyLarge = TextStyle(
    fontSize: 16,
    height: 1.45,
    fontWeight: FontWeight.w400,
  );

  static const TextStyle bodyMedium = TextStyle(
    fontSize: 14,
    height: 1.45,
    fontWeight: FontWeight.w400,
  );

  static const TextStyle bodySmall = TextStyle(
    fontSize: 12,
    height: 1.4,
    fontWeight: FontWeight.w400,
  );

  static const TextStyle labelLarge = TextStyle(
    fontSize: 15,
    height: 1.2,
    fontWeight: FontWeight.w700,
  );

  static const TextStyle labelMedium = TextStyle(
    fontSize: 13,
    height: 1.2,
    fontWeight: FontWeight.w600,
  );

  static const TextStyle labelSmall = TextStyle(
    fontSize: 11,
    height: 1.2,
    fontWeight: FontWeight.w600,
  );

  /// Text theme with explicit palette colors.
  ///
  /// [bodyMedium] uses [AppPalette.textPrimary] because Material uses it as
  /// the ambient text style for widgets that do not define a color.
  static TextTheme textThemeFor(AppPalette palette) {
    return TextTheme(
      displayLarge: displayLarge.copyWith(color: palette.textPrimary),
      displayMedium: displayMedium.copyWith(color: palette.textPrimary),
      headlineMedium: headlineMedium.copyWith(color: palette.textPrimary),
      headlineSmall: headlineSmall.copyWith(color: palette.textPrimary),
      titleLarge: titleLarge.copyWith(color: palette.textPrimary),
      titleMedium: titleMedium.copyWith(color: palette.textPrimary),
      titleSmall: titleSmall.copyWith(color: palette.textPrimary),
      bodyLarge: bodyLarge.copyWith(color: palette.textSecondary),
      bodyMedium: bodyMedium.copyWith(color: palette.textPrimary),
      bodySmall: bodySmall.copyWith(color: palette.textMuted),
      labelLarge: labelLarge.copyWith(color: palette.textPrimary),
      labelMedium: labelMedium.copyWith(color: palette.textSecondary),
      labelSmall: labelSmall.copyWith(color: palette.textMuted),
    );
  }
}
