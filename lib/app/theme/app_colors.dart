import 'package:flutter/material.dart';

/// Centralized color system for HydroAlert.
///
/// No widget should declare brand colors directly. Use these tokens so the
/// palette stays consistent and accessible.
class AppColors {
  const AppColors._();

  // Brand
  static const Color primary = Color(0xFF1E40AF);
  static const Color primaryDark = Color(0xFF1E3A8A);
  static const Color primarySoft = Color(0xFFDBEAFE);
  static const Color brandOrange = Color(0xFFF97316);

  // Semantic states
  static const Color warning = Color(0xFFD97706);
  static const Color warningDark = Color(0xFF92400E);
  static const Color warningSoft = Color(0xFFFEF3C7);
  static const Color danger = Color(0xFFDC2626);
  static const Color dangerDark = Color(0xFF991B1B);
  static const Color dangerSoft = Color(0xFFFEE2E2);
  static const Color success = Color(0xFF16A34A);
  static const Color successDark = Color(0xFF166534);
  static const Color successSoft = Color(0xFFDCFCE7);
  static const Color info = Color(0xFF0EA5E9);
  static const Color infoSoft = Color(0xFFE0F2FE);

  // Seismic magnitude scale
  static const Color seismicLow = Color(0xFF0EA5E9);
  static const Color seismicModerate = Color(0xFFD97706);
  static const Color seismicStrong = Color(0xFFDC2626);
  static const Color seismicMajor = Color(0xFF7F1D1D);

  // Surfaces and text
  static const Color background = Color(0xFFF8FAFC);
  static const Color surface = Color(0xFFFFFFFF);
  static const Color surfaceMuted = Color(0xFFF1F5F9);
  static const Color border = Color(0xFFE2E8F0);
  static const Color textPrimary = Color(0xFF0F172A);
  static const Color textSecondary = Color(0xFF475569);
  static const Color textMuted = Color(0xFF64748B);
  static const Color overlay = Color(0xCC0F172A);

  // Map
  static const Color mapUserLocation = Color(0xFF2563EB);
  static const Color mapMarkerBorder = Color(0xFFFFFFFF);
}
