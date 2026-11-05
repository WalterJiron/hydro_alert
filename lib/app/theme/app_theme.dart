import 'package:flutter/material.dart';

import 'app_colors.dart';
import 'app_typography.dart';

/// Material 3 theme for HydroAlert.
class AppTheme {
  const AppTheme._();

  static ThemeData get light {
    final baseScheme = ColorScheme.fromSeed(
      seedColor: AppColors.primary,
      brightness: Brightness.light,
    );

    final colorScheme = baseScheme.copyWith(
      primary: AppColors.primary,
      onPrimary: Colors.white,
      primaryContainer: AppColors.primarySoft,
      onPrimaryContainer: AppColors.primaryDark,
      secondary: AppColors.warning,
      onSecondary: Colors.white,
      secondaryContainer: AppColors.warningSoft,
      onSecondaryContainer: AppColors.warningDark,
      error: AppColors.danger,
      onError: Colors.white,
      errorContainer: AppColors.dangerSoft,
      onErrorContainer: AppColors.dangerDark,
      surface: AppColors.surface,
      onSurface: AppColors.textPrimary,
      onSurfaceVariant: AppColors.textSecondary,
      outline: AppColors.border,
      outlineVariant: AppColors.border,
    );

    return ThemeData(
      useMaterial3: true,
      colorScheme: colorScheme,
      scaffoldBackgroundColor: AppColors.background,
      textTheme: AppTypography.textTheme,
      appBarTheme: AppBarTheme(
        backgroundColor: AppColors.background,
        foregroundColor: AppColors.textPrimary,
        elevation: 0,
        scrolledUnderElevation: 0.5,
        centerTitle: false,
        surfaceTintColor: Colors.transparent,
        titleTextStyle: AppTypography.titleLarge,
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: AppColors.surface,
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 14,
        ),
        hintStyle: AppTypography.bodyMedium.copyWith(
          color: AppColors.textMuted,
        ),
        labelStyle: AppTypography.labelMedium,
        border: _inputBorder(AppColors.border),
        enabledBorder: _inputBorder(AppColors.border),
        focusedBorder: _inputBorder(AppColors.primary, width: 1.6),
        errorBorder: _inputBorder(AppColors.danger),
        focusedErrorBorder: _inputBorder(AppColors.danger, width: 1.6),
      ),
      filledButtonTheme: FilledButtonThemeData(
        style: FilledButton.styleFrom(
          backgroundColor: AppColors.primary,
          foregroundColor: Colors.white,
          minimumSize: const Size(48, 48),
          padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 14),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(14),
          ),
          textStyle: AppTypography.labelLarge.copyWith(color: Colors.white),
        ),
      ),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          foregroundColor: AppColors.primary,
          minimumSize: const Size(48, 48),
          padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 14),
          side: const BorderSide(color: AppColors.border),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(14),
          ),
          textStyle: AppTypography.labelLarge.copyWith(
            color: AppColors.primary,
          ),
        ),
      ),
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          foregroundColor: AppColors.primary,
          minimumSize: const Size(48, 48),
          textStyle: AppTypography.labelLarge.copyWith(
            color: AppColors.primary,
          ),
        ),
      ),
      navigationBarTheme: NavigationBarThemeData(
        backgroundColor: AppColors.surface,
        indicatorColor: AppColors.primarySoft,
        height: 72,
        labelBehavior: NavigationDestinationLabelBehavior.alwaysShow,
        iconTheme: WidgetStateProperty.resolveWith<IconThemeData>((states) {
          final selected = states.contains(WidgetState.selected);
          return IconThemeData(
            size: 22,
            color: selected ? AppColors.primary : AppColors.textMuted,
          );
        }),
        labelTextStyle: WidgetStateProperty.resolveWith<TextStyle>((states) {
          final selected = states.contains(WidgetState.selected);
          return AppTypography.labelSmall.copyWith(
            color: selected ? AppColors.primary : AppColors.textMuted,
            fontWeight: selected ? FontWeight.w700 : FontWeight.w600,
          );
        }),
      ),
      bottomSheetTheme: const BottomSheetThemeData(
        backgroundColor: AppColors.surface,
        surfaceTintColor: Colors.transparent,
        showDragHandle: true,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
        ),
      ),
      snackBarTheme: SnackBarThemeData(
        backgroundColor: AppColors.textPrimary,
        contentTextStyle: AppTypography.bodyMedium.copyWith(
          color: Colors.white,
        ),
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      ),
      dividerTheme: const DividerThemeData(
        color: AppColors.border,
        thickness: 1,
        space: 1,
      ),
      iconTheme: const IconThemeData(color: AppColors.textSecondary, size: 22),
      progressIndicatorTheme: const ProgressIndicatorThemeData(
        color: AppColors.primary,
      ),
      splashFactory: InkSparkle.splashFactory,
    );
  }

  static OutlineInputBorder _inputBorder(Color color, {double width = 1}) {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(14),
      borderSide: BorderSide(color: color, width: width),
    );
  }
}
