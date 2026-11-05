import 'package:flutter/material.dart';

import 'app_colors.dart';

/// Typography scale used across the application.
///
/// The app intentionally uses the platform font to avoid an extra font
/// download and to keep the first render fast and predictable.
class AppTypography {
  const AppTypography._();

  static const TextStyle displayLarge = TextStyle(
    fontSize: 34,
    height: 1.08,
    fontWeight: FontWeight.w800,
    letterSpacing: -0.8,
    color: AppColors.textPrimary,
  );

  static const TextStyle displayMedium = TextStyle(
    fontSize: 28,
    height: 1.12,
    fontWeight: FontWeight.w800,
    letterSpacing: -0.5,
    color: AppColors.textPrimary,
  );

  static const TextStyle headlineMedium = TextStyle(
    fontSize: 24,
    height: 1.2,
    fontWeight: FontWeight.w700,
    letterSpacing: -0.2,
    color: AppColors.textPrimary,
  );

  static const TextStyle headlineSmall = TextStyle(
    fontSize: 20,
    height: 1.25,
    fontWeight: FontWeight.w700,
    color: AppColors.textPrimary,
  );

  static const TextStyle titleLarge = TextStyle(
    fontSize: 18,
    height: 1.3,
    fontWeight: FontWeight.w700,
    color: AppColors.textPrimary,
  );

  static const TextStyle titleMedium = TextStyle(
    fontSize: 16,
    height: 1.35,
    fontWeight: FontWeight.w600,
    color: AppColors.textPrimary,
  );

  static const TextStyle titleSmall = TextStyle(
    fontSize: 14,
    height: 1.35,
    fontWeight: FontWeight.w600,
    color: AppColors.textPrimary,
  );

  static const TextStyle bodyLarge = TextStyle(
    fontSize: 16,
    height: 1.45,
    fontWeight: FontWeight.w400,
    color: AppColors.textSecondary,
  );

  static const TextStyle bodyMedium = TextStyle(
    fontSize: 14,
    height: 1.45,
    fontWeight: FontWeight.w400,
    color: AppColors.textSecondary,
  );

  static const TextStyle bodySmall = TextStyle(
    fontSize: 12,
    height: 1.4,
    fontWeight: FontWeight.w400,
    color: AppColors.textMuted,
  );

  static const TextStyle labelLarge = TextStyle(
    fontSize: 15,
    height: 1.2,
    fontWeight: FontWeight.w700,
    color: AppColors.textPrimary,
  );

  static const TextStyle labelMedium = TextStyle(
    fontSize: 13,
    height: 1.2,
    fontWeight: FontWeight.w600,
    color: AppColors.textSecondary,
  );

  static const TextStyle labelSmall = TextStyle(
    fontSize: 11,
    height: 1.2,
    fontWeight: FontWeight.w600,
    color: AppColors.textMuted,
  );

  static const TextTheme textTheme = TextTheme(
    displayLarge: displayLarge,
    displayMedium: displayMedium,
    headlineMedium: headlineMedium,
    headlineSmall: headlineSmall,
    titleLarge: titleLarge,
    titleMedium: titleMedium,
    titleSmall: titleSmall,
    bodyLarge: bodyLarge,
    bodyMedium: bodyMedium,
    bodySmall: bodySmall,
    labelLarge: labelLarge,
    labelMedium: labelMedium,
    labelSmall: labelSmall,
  );
}
