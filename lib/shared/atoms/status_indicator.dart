import 'package:flutter/material.dart';

import '../../app/theme/app_colors.dart';
import '../../app/theme/app_typography.dart';

/// Compact availability indicator (for example: USGS, clima, reportes).
class StatusIndicator extends StatelessWidget {
  const StatusIndicator({
    super.key,
    required this.label,
    this.color = AppColors.success,
    this.isActive = true,
  });

  final String label;
  final Color color;
  final bool isActive;

  @override
  Widget build(BuildContext context) {
    final effectiveColor = isActive ? color : AppColors.textMuted;

    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: 8,
          height: 8,
          decoration: BoxDecoration(
            color: effectiveColor,
            shape: BoxShape.circle,
          ),
        ),
        const SizedBox(width: 6),
        Text(
          label,
          style: AppTypography.labelSmall.copyWith(
            color: isActive ? AppColors.textSecondary : AppColors.textMuted,
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );
  }
}
