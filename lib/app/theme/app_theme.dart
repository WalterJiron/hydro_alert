import 'package:flutter/material.dart';

import 'app_colors.dart';
import 'app_typography.dart';

/// Material 3 themes for HydroAlert.
///
/// Both themes share the same structure and brand accents; only the palette
/// changes. The app follows the device setting through `ThemeMode.system`.
class AppTheme {
  const AppTheme._();

  static ThemeData get light => _build(AppPalette.light, Brightness.light);

  static ThemeData get dark => _build(AppPalette.dark, Brightness.dark);

  static ThemeData _build(AppPalette palette, Brightness brightness) {
    final baseScheme = ColorScheme.fromSeed(
      seedColor: AppColors.primary,
      brightness: brightness,
    );

    final isDark = brightness == Brightness.dark;
    final colorScheme = baseScheme.copyWith(
      primary: palette.primary,
      onPrimary: isDark ? palette.background : Colors.white,
      primaryContainer: palette.primarySoft,
      onPrimaryContainer: palette.primaryStrong,
      secondary: AppColors.warning,
      onSecondary: Colors.white,
      secondaryContainer: palette.warningSoft,
      onSecondaryContainer: palette.warningStrong,
      error: AppColors.danger,
      onError: Colors.white,
      errorContainer: palette.dangerSoft,
      onErrorContainer: palette.dangerStrong,
      surface: palette.surface,
      onSurface: palette.textPrimary,
      onSurfaceVariant: palette.textSecondary,
      surfaceContainerHighest: palette.surfaceMuted,
      outline: palette.border,
      outlineVariant: palette.border,
      inverseSurface: palette.textPrimary,
      onInverseSurface: palette.background,
      inversePrimary: palette.primarySoft,
    );

    final textTheme = AppTypography.textThemeFor(palette);

    return ThemeData(
      useMaterial3: true,
      brightness: brightness,
      colorScheme: colorScheme,
      extensions: <ThemeExtension<dynamic>>[palette],
      scaffoldBackgroundColor: palette.background,
      canvasColor: palette.background,
      cardColor: palette.surface,
      textTheme: textTheme,
      appBarTheme: AppBarTheme(
        backgroundColor: palette.background,
        foregroundColor: palette.textPrimary,
        elevation: 0,
        scrolledUnderElevation: 0.5,
        centerTitle: false,
        surfaceTintColor: Colors.transparent,
        titleTextStyle: AppTypography.titleLarge.copyWith(
          color: palette.textPrimary,
        ),
        iconTheme: IconThemeData(color: palette.textSecondary, size: 22),
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: palette.surface,
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 14,
        ),
        hintStyle: AppTypography.bodyMedium.copyWith(color: palette.textMuted),
        labelStyle: AppTypography.labelMedium.copyWith(
          color: palette.textSecondary,
        ),
        border: _inputBorder(palette.border),
        enabledBorder: _inputBorder(palette.border),
        focusedBorder: _inputBorder(palette.primary, width: 1.6),
        errorBorder: _inputBorder(AppColors.danger),
        focusedErrorBorder: _inputBorder(AppColors.danger, width: 1.6),
      ),
      filledButtonTheme: FilledButtonThemeData(
        style: FilledButton.styleFrom(
          backgroundColor: palette.primaryFill,
          foregroundColor: palette.onPrimaryFill,
          minimumSize: const Size(48, 48),
          padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 14),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(14),
          ),
          textStyle: AppTypography.labelLarge.copyWith(
            color: palette.onPrimaryFill,
          ),
        ),
      ),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          foregroundColor: palette.primary,
          minimumSize: const Size(48, 48),
          padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 14),
          side: BorderSide(color: palette.border),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(14),
          ),
          textStyle: AppTypography.labelLarge.copyWith(color: palette.primary),
        ),
      ),
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          foregroundColor: palette.primary,
          minimumSize: const Size(48, 48),
          textStyle: AppTypography.labelLarge.copyWith(color: palette.primary),
        ),
      ),
      navigationBarTheme: NavigationBarThemeData(
        backgroundColor: palette.surface,
        indicatorColor: palette.primarySoft,
        height: 72,
        labelBehavior: NavigationDestinationLabelBehavior.alwaysShow,
        iconTheme: WidgetStateProperty.resolveWith<IconThemeData>((states) {
          final selected = states.contains(WidgetState.selected);
          return IconThemeData(
            size: 22,
            color: selected ? palette.primary : palette.textMuted,
          );
        }),
        labelTextStyle: WidgetStateProperty.resolveWith<TextStyle>((states) {
          final selected = states.contains(WidgetState.selected);
          return AppTypography.labelSmall.copyWith(
            color: selected ? palette.primary : palette.textMuted,
            fontWeight: selected ? FontWeight.w700 : FontWeight.w600,
          );
        }),
      ),
      bottomSheetTheme: BottomSheetThemeData(
        backgroundColor: palette.surface,
        surfaceTintColor: Colors.transparent,
        showDragHandle: true,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
        ),
      ),
      dialogTheme: DialogThemeData(
        backgroundColor: palette.surface,
        surfaceTintColor: Colors.transparent,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      ),
      snackBarTheme: SnackBarThemeData(
        backgroundColor: colorScheme.inverseSurface,
        contentTextStyle: AppTypography.bodyMedium.copyWith(
          color: colorScheme.onInverseSurface,
        ),
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      ),
      dividerTheme: DividerThemeData(
        color: palette.border,
        thickness: 1,
        space: 1,
      ),
      iconTheme: IconThemeData(color: palette.textSecondary, size: 22),
      progressIndicatorTheme: ProgressIndicatorThemeData(
        color: palette.primary,
      ),
      textSelectionTheme: TextSelectionThemeData(
        cursorColor: palette.primary,
        selectionColor: palette.primarySoft,
        selectionHandleColor: palette.primary,
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
