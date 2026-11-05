import 'package:flutter/material.dart';

import '../../app/theme/app_colors.dart';

/// Low-emphasis status pill used for magnitudes, sources and trust labels.
enum AppBadgeTone { neutral, info, success, warning, danger, seismic }

class AlertBadge extends StatelessWidget {
  const AlertBadge({
    super.key,
    required this.label,
    this.tone = AppBadgeTone.neutral,
    this.icon,
  });

  final String label;
  final AppBadgeTone tone;
  final IconData? icon;

  @override
  Widget build(BuildContext context) {
    final (background, foreground) = switch (tone) {
      AppBadgeTone.neutral => (AppColors.surfaceMuted, AppColors.textSecondary),
      AppBadgeTone.info => (AppColors.infoSoft, AppColors.primaryDark),
      AppBadgeTone.success => (AppColors.successSoft, AppColors.successDark),
      AppBadgeTone.warning => (AppColors.warningSoft, AppColors.warningDark),
      AppBadgeTone.danger => (AppColors.dangerSoft, AppColors.dangerDark),
      AppBadgeTone.seismic => (AppColors.dangerSoft, AppColors.seismicStrong),
    };

    return Semantics(
      label: label,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
        decoration: BoxDecoration(
          color: background,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (icon != null) ...[
              Icon(icon, size: 12, color: foreground),
              const SizedBox(width: 4),
            ],
            Text(
              label,
              style: TextStyle(
                fontSize: 11,
                height: 1.2,
                fontWeight: FontWeight.w700,
                letterSpacing: 0.1,
                color: foreground,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
