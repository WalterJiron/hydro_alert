import 'package:flutter/material.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

import '../../../../app/theme/app_colors.dart';
import '../../domain/entities/report_category.dart';

IconData reportCategoryIcon(ReportCategory category) {
  return switch (category) {
    ReportCategory.flood => LucideIcons.waves,
    ReportCategory.damagedDrain => LucideIcons.construction,
    ReportCategory.fallenTree => LucideIcons.trees,
    ReportCategory.landslide => LucideIcons.mountain,
    ReportCategory.fire => LucideIcons.flame,
    ReportCategory.earthquakeDamage => LucideIcons.house,
    ReportCategory.other => LucideIcons.circleAlert,
  };
}

Color reportCategoryColor(ReportCategory category) {
  return switch (category) {
    ReportCategory.flood => AppColors.info,
    ReportCategory.damagedDrain => AppColors.warning,
    ReportCategory.fallenTree => AppColors.success,
    ReportCategory.landslide => AppColors.brandOrange,
    ReportCategory.fire => AppColors.danger,
    ReportCategory.earthquakeDamage => AppColors.seismicStrong,
    ReportCategory.other => AppColors.neutral,
  };
}
