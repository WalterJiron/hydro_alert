import 'package:flutter/material.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

import '../../../../app/config/app_config.dart';
import '../../../../app/theme/app_colors.dart';
import '../../../../app/theme/app_typography.dart';
import '../../../../core/utils/date_formatter.dart';
import '../../../../shared/atoms/alert_badge.dart';
import '../../../../shared/molecules/app_card.dart';
import '../../domain/entities/community_report.dart';
import 'report_category_visuals.dart';

class CommunityReportCard extends StatelessWidget {
  const CommunityReportCard({
    super.key,
    required this.report,
    this.onTap,
    this.compact = false,
  });

  final CommunityReport report;
  final VoidCallback? onTap;
  final bool compact;

  @override
  Widget build(BuildContext context) {
    final color = reportCategoryColor(report.category);
    final photoUrl = _resolvePhotoUrl(report.photoUrl);

    return AppCard(
      onTap: onTap,
      padding: const EdgeInsets.all(14),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  color: color.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(
                  reportCategoryIcon(report.category),
                  size: 20,
                  color: color,
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      report.category.label,
                      style: AppTypography.titleSmall,
                    ),
                    const SizedBox(height: 2),
                    Text(
                      DateFormatter.relative(report.createdAt),
                      style: AppTypography.bodySmall,
                    ),
                  ],
                ),
              ),
              const AlertBadge(
                label: 'Sin verificar',
                tone: AppBadgeTone.warning,
              ),
            ],
          ),
          if (!compact) ...[
            const SizedBox(height: 10),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Text(
                    report.description,
                    style: AppTypography.bodyMedium,
                    maxLines: compact ? 2 : 4,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                if (photoUrl != null) ...[
                  const SizedBox(width: 10),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: Image.network(
                      photoUrl,
                      width: 64,
                      height: 64,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) {
                        return Container(
                          width: 64,
                          height: 64,
                          color: context.palette.surfaceMuted,
                          child: Icon(
                            LucideIcons.image,
                            size: 20,
                            color: context.palette.textMuted,
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ],
            ),
            const SizedBox(height: 10),
            Row(
              children: [
                Icon(
                  LucideIcons.mapPin,
                  size: 13,
                  color: context.palette.textMuted,
                ),
                const SizedBox(width: 4),
                Text(report.coordinatesLabel, style: AppTypography.labelSmall),
                const Spacer(),
                Icon(
                  LucideIcons.users,
                  size: 13,
                  color: context.palette.textMuted,
                ),
                const SizedBox(width: 4),
                Text('Reporte comunitario', style: AppTypography.labelSmall),
              ],
            ),
          ],
        ],
      ),
    );
  }

  String? _resolvePhotoUrl(String? raw) {
    return AppConfig.resolveMediaUrl(raw);
  }
}
