import 'package:flutter/material.dart';

/// Centralized color system for HydroAlert.
///
/// No widget should declare brand colors directly. Use the brand tokens below
/// and [AppPalette] for every color that changes with the theme.
class AppColors {
  const AppColors._();

  // Brand
  static const Color primary = Color(0xFF1E40AF);
  static const Color primaryDark = Color(0xFF1E3A8A);
  static const Color brandOrange = Color(0xFFF97316);

  // Semantic states
  static const Color warning = Color(0xFFD97706);
  static const Color danger = Color(0xFFDC2626);
  static const Color dangerDeep = Color(0xFF991B1B);
  static const Color success = Color(0xFF16A34A);
  static const Color info = Color(0xFF0EA5E9);

  // Seismic magnitude scale
  static const Color seismicLow = Color(0xFF0EA5E9);
  static const Color seismicModerate = Color(0xFFD97706);
  static const Color seismicStrong = Color(0xFFDC2626);
  static const Color seismicMajor = Color(0xFF7F1D1D);

  /// Distinctive violet for miscellaneous community reports.
  static const Color categoryOther = Color(0xFF8B5CF6);

  /// Neutral gray that stays readable on map tiles and generated bitmaps.
  static const Color neutral = Color(0xFF64748B);

  // Map
  static const Color mapUserLocation = Color(0xFF2563EB);
  static const Color mapPinShadow = Color(0x400F172A);
  static const Color mapPulseRing = Color(0x332563EB);
}

/// Theme-aware palette.
///
/// Add it to [ThemeData.extensions] and read it through `context.palette`.
/// Every surface, border, text and soft state color lives here so the same
/// widgets work in light and dark mode.
@immutable
class AppPalette extends ThemeExtension<AppPalette> {
  const AppPalette({
    required this.background,
    required this.surface,
    required this.surfaceMuted,
    required this.border,
    required this.textPrimary,
    required this.textSecondary,
    required this.textMuted,
    required this.overlay,
    required this.primary,
    required this.primaryFill,
    required this.onPrimaryFill,
    required this.primarySoft,
    required this.primaryStrong,
    required this.warningSoft,
    required this.warningStrong,
    required this.dangerSoft,
    required this.dangerStrong,
    required this.successSoft,
    required this.successStrong,
    required this.infoSoft,
    required this.infoStrong,
    required this.mapPanel,
    required this.mapMarkerBorder,
  });

  final Color background;
  final Color surface;
  final Color surfaceMuted;
  final Color border;
  final Color textPrimary;
  final Color textSecondary;
  final Color textMuted;
  final Color overlay;

  /// Accent used for text and icons.
  final Color primary;

  /// Solid primary background that pairs with [onPrimaryFill].
  final Color primaryFill;
  final Color onPrimaryFill;

  final Color primarySoft;
  final Color primaryStrong;
  final Color warningSoft;
  final Color warningStrong;
  final Color dangerSoft;
  final Color dangerStrong;
  final Color successSoft;
  final Color successStrong;
  final Color infoSoft;
  final Color infoStrong;

  final Color mapPanel;
  final Color mapMarkerBorder;

  static const AppPalette light = AppPalette(
    background: Color(0xFFF8FAFC),
    surface: Color(0xFFFFFFFF),
    surfaceMuted: Color(0xFFF1F5F9),
    border: Color(0xFFE2E8F0),
    textPrimary: Color(0xFF0F172A),
    textSecondary: Color(0xFF475569),
    textMuted: Color(0xFF64748B),
    overlay: Color(0xCC0F172A),
    primary: Color(0xFF1E40AF),
    primaryFill: Color(0xFF1E40AF),
    onPrimaryFill: Colors.white,
    primarySoft: Color(0xFFDBEAFE),
    primaryStrong: Color(0xFF1E3A8A),
    warningSoft: Color(0xFFFEF3C7),
    warningStrong: Color(0xFF92400E),
    dangerSoft: Color(0xFFFEE2E2),
    dangerStrong: Color(0xFF991B1B),
    successSoft: Color(0xFFDCFCE7),
    successStrong: Color(0xFF166534),
    infoSoft: Color(0xFFE0F2FE),
    infoStrong: Color(0xFF1E3A8A),
    mapPanel: Color(0xF5FFFFFF),
    mapMarkerBorder: Color(0xFFFFFFFF),
  );

  static const AppPalette dark = AppPalette(
    background: Color(0xFF0B1220),
    surface: Color(0xFF111C2E),
    surfaceMuted: Color(0xFF1E293B),
    border: Color(0xFF334155),
    textPrimary: Color(0xFFF1F5F9),
    textSecondary: Color(0xFFCBD5E1),
    textMuted: Color(0xFF94A3B8),
    overlay: Color(0xCC020617),
    primary: Color(0xFF93C5FD),
    primaryFill: Color(0xFF2563EB),
    onPrimaryFill: Colors.white,
    primarySoft: Color(0xFF1E3A8A),
    primaryStrong: Color(0xFFDBEAFE),
    warningSoft: Color(0xFF78350F),
    warningStrong: Color(0xFFFDE68A),
    dangerSoft: Color(0xFF7F1D1D),
    dangerStrong: Color(0xFFFECACA),
    successSoft: Color(0xFF14532D),
    successStrong: Color(0xFFBBF7D0),
    infoSoft: Color(0xFF0C4A6E),
    infoStrong: Color(0xFFBAE6FD),
    mapPanel: Color(0xF51E293B),
    mapMarkerBorder: Color(0xFFE2E8F0),
  );

  @override
  AppPalette copyWith({
    Color? background,
    Color? surface,
    Color? surfaceMuted,
    Color? border,
    Color? textPrimary,
    Color? textSecondary,
    Color? textMuted,
    Color? overlay,
    Color? primary,
    Color? primaryFill,
    Color? onPrimaryFill,
    Color? primarySoft,
    Color? primaryStrong,
    Color? warningSoft,
    Color? warningStrong,
    Color? dangerSoft,
    Color? dangerStrong,
    Color? successSoft,
    Color? successStrong,
    Color? infoSoft,
    Color? infoStrong,
    Color? mapPanel,
    Color? mapMarkerBorder,
  }) {
    return AppPalette(
      background: background ?? this.background,
      surface: surface ?? this.surface,
      surfaceMuted: surfaceMuted ?? this.surfaceMuted,
      border: border ?? this.border,
      textPrimary: textPrimary ?? this.textPrimary,
      textSecondary: textSecondary ?? this.textSecondary,
      textMuted: textMuted ?? this.textMuted,
      overlay: overlay ?? this.overlay,
      primary: primary ?? this.primary,
      primaryFill: primaryFill ?? this.primaryFill,
      onPrimaryFill: onPrimaryFill ?? this.onPrimaryFill,
      primarySoft: primarySoft ?? this.primarySoft,
      primaryStrong: primaryStrong ?? this.primaryStrong,
      warningSoft: warningSoft ?? this.warningSoft,
      warningStrong: warningStrong ?? this.warningStrong,
      dangerSoft: dangerSoft ?? this.dangerSoft,
      dangerStrong: dangerStrong ?? this.dangerStrong,
      successSoft: successSoft ?? this.successSoft,
      successStrong: successStrong ?? this.successStrong,
      infoSoft: infoSoft ?? this.infoSoft,
      infoStrong: infoStrong ?? this.infoStrong,
      mapPanel: mapPanel ?? this.mapPanel,
      mapMarkerBorder: mapMarkerBorder ?? this.mapMarkerBorder,
    );
  }

  @override
  AppPalette lerp(covariant AppPalette? other, double t) {
    if (other == null) {
      return this;
    }
    Color mix(Color a, Color b) => Color.lerp(a, b, t)!;
    return AppPalette(
      background: mix(background, other.background),
      surface: mix(surface, other.surface),
      surfaceMuted: mix(surfaceMuted, other.surfaceMuted),
      border: mix(border, other.border),
      textPrimary: mix(textPrimary, other.textPrimary),
      textSecondary: mix(textSecondary, other.textSecondary),
      textMuted: mix(textMuted, other.textMuted),
      overlay: mix(overlay, other.overlay),
      primary: mix(primary, other.primary),
      primaryFill: mix(primaryFill, other.primaryFill),
      onPrimaryFill: mix(onPrimaryFill, other.onPrimaryFill),
      primarySoft: mix(primarySoft, other.primarySoft),
      primaryStrong: mix(primaryStrong, other.primaryStrong),
      warningSoft: mix(warningSoft, other.warningSoft),
      warningStrong: mix(warningStrong, other.warningStrong),
      dangerSoft: mix(dangerSoft, other.dangerSoft),
      dangerStrong: mix(dangerStrong, other.dangerStrong),
      successSoft: mix(successSoft, other.successSoft),
      successStrong: mix(successStrong, other.successStrong),
      infoSoft: mix(infoSoft, other.infoSoft),
      infoStrong: mix(infoStrong, other.infoStrong),
      mapPanel: mix(mapPanel, other.mapPanel),
      mapMarkerBorder: mix(mapMarkerBorder, other.mapMarkerBorder),
    );
  }
}

extension AppPaletteContext on BuildContext {
  /// Palette of the active theme. Falls back to light if the extension is
  /// missing (for example in a widget test with a plain [MaterialApp]).
  AppPalette get palette {
    return Theme.of(this).extension<AppPalette>() ??
        (Theme.of(this).brightness == Brightness.dark
            ? AppPalette.dark
            : AppPalette.light);
  }
}
