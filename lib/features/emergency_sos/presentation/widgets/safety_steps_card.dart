import 'package:flutter/material.dart';

import '../../../../app/theme/app_colors.dart';
import '../../../../app/theme/app_typography.dart';
import '../../../../shared/molecules/app_card.dart';

/// Numbered list of actions for before, during or after an earthquake.
class SafetyStepsCard extends StatelessWidget {
  const SafetyStepsCard({super.key, required this.steps});

  final List<String> steps;

  @override
  Widget build(BuildContext context) {
    final palette = context.palette;

    return AppCard(
      child: Column(
        children: [
          for (var index = 0; index < steps.length; index++) ...[
            if (index > 0) const SizedBox(height: 12),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: 24,
                  height: 24,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: palette.primarySoft,
                    shape: BoxShape.circle,
                  ),
                  child: Text(
                    '${index + 1}',
                    style: AppTypography.labelSmall.copyWith(
                      color: palette.primary,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: Text(steps[index], style: AppTypography.bodyMedium),
                ),
              ],
            ),
          ],
        ],
      ),
    );
  }
}
