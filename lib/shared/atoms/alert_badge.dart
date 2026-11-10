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
    final palette = context.palette;
    final (background, foreground) = switch (tone) {
      AppBadgeTone.neutral => (palette.surfaceMuted, palette.textSecondary),
      AppBadgeTone.info => (palette.infoSoft, palette.infoStrong),
      AppBadgeTone.success => (palette.successSoft, palette.successStrong),
      AppBadgeTone.warning => (palette.warningSoft, palette.warningStrong),
      AppBadgeTone.danger => (palette.dangerSoft, palette.dangerStrong),
      AppBadgeTone.seismic => (palette.dangerSoft, palette.dangerStrong),
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
