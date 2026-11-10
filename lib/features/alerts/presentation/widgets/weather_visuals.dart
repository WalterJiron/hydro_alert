import 'package:flutter/material.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

import '../../../../app/theme/app_colors.dart';

IconData weatherIconFor(String main, String iconCode) {
  final normalized = main.toLowerCase();
  final isNight = iconCode.endsWith('n');

  return switch (normalized) {
    'clear' => isNight ? LucideIcons.moon : LucideIcons.sun,
    'clouds' => LucideIcons.cloudSun,
    'rain' => LucideIcons.cloudRain,
    'drizzle' => LucideIcons.cloudDrizzle,
    'thunderstorm' => LucideIcons.cloudLightning,
    'snow' => LucideIcons.snowflake,
    'mist' || 'fog' || 'haze' || 'smoke' => LucideIcons.cloudFog,
    'dust' || 'sand' => LucideIcons.wind,
    'tornado' || 'squall' => LucideIcons.cloudRainWind,
    _ => LucideIcons.cloud,
  };
}

Color weatherColorFor(String main, AppPalette palette) {
  return switch (main.toLowerCase()) {
    'clear' => AppColors.warning,
    'rain' || 'drizzle' || 'thunderstorm' => AppColors.info,
    'snow' => palette.primary,
    'mist' || 'fog' || 'haze' || 'smoke' => palette.textMuted,
    _ => palette.primary,
  };
}
