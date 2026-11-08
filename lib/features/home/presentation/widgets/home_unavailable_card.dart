import 'package:flutter/material.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

import '../../../../app/theme/app_colors.dart';
import '../../../../app/theme/app_typography.dart';
import '../../../../shared/atoms/custom_button.dart';
import '../../../../shared/molecules/app_card.dart';

/// Card used by the home sections when a data source is unavailable.
class HomeUnavailableCard extends StatelessWidget {
  const HomeUnavailableCard({
    super.key,
    required this.icon,
    required this.title,
    required this.message,
    this.onRetry,
  });

  final IconData icon;
  final String title;
  final String message;
  final VoidCallback? onRetry;

  @override
  Widget build(BuildContext context) {
    return AppCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  color: AppColors.surfaceMuted,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(icon, size: 20, color: AppColors.textMuted),
              ),
              const SizedBox(width: 10),
              Expanded(child: Text(title, style: AppTypography.titleSmall)),
            ],
          ),
          const SizedBox(height: 8),
          Text(message, style: AppTypography.bodySmall.copyWith(height: 1.45)),
          if (onRetry != null) ...[
            const SizedBox(height: 8),
            Align(
              alignment: Alignment.centerLeft,
              child: CustomButton(
                label: 'Reintentar',
                icon: LucideIcons.refreshCw,
                variant: AppButtonVariant.ghost,
                onPressed: onRetry,
              ),
            ),
          ],
        ],
      ),
    );
  }
}
