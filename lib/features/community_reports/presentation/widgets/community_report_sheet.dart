import 'package:flutter/material.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

import '../../../../app/theme/app_colors.dart';
import '../../../../app/theme/app_typography.dart';
import '../../../../core/utils/date_formatter.dart';
import '../../../../shared/atoms/alert_badge.dart';
import '../../../../shared/molecules/info_banner.dart';
import '../../domain/entities/community_report.dart';
import 'community_report_card.dart';
import 'report_category_visuals.dart';

/// Detail sheet shared by the map and the community reports list.
///
/// [compact] keeps the map presentation (preview card plus disclaimer) while
/// the default layout lists every report field with its verification notice.
Future<void> showCommunityReportSheet(
  BuildContext context,
  CommunityReport report, {
  bool compact = false,
}) {
  return showModalBottomSheet<void>(
    context: context,
    isScrollControlled: true,
    showDragHandle: true,
    builder: (sheetContext) {
      return SafeArea(
        top: false,
        child: Padding(
          padding: EdgeInsets.fromLTRB(
            compact ? 16 : 20,
            0,
            compact ? 16 : 20,
            compact ? 20 : 24,
          ),
          child: compact
              ? _CompactReportBody(report: report)
              : _DetailedReportBody(report: report),
        ),
      );
    },
  );
}

class _CompactReportBody extends StatelessWidget {
  const _CompactReportBody({required this.report});

  final CommunityReport report;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        CommunityReportCard(report: report, compact: true),
        const SizedBox(height: 12),
        const InfoBanner(
          icon: LucideIcons.shieldAlert,
          tone: InfoBannerTone.warning,
          message:
              'Reporte comunitario sin verificar. No es una alerta oficial.',
        ),
      ],
    );
  }
}

class _DetailedReportBody extends StatelessWidget {
  const _DetailedReportBody({required this.report});

  final CommunityReport report;

  @override
  Widget build(BuildContext context) {
    final color = reportCategoryColor(report.category);

    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
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
              child: Text(
                report.category.label,
                style: AppTypography.titleMedium,
              ),
            ),
            const AlertBadge(
              label: 'Sin verificar',
              tone: AppBadgeTone.warning,
            ),
          ],
        ),
        const SizedBox(height: 14),
        Text(report.description, style: AppTypography.bodyLarge),
        const SizedBox(height: 16),
        _SheetRow(
          icon: LucideIcons.clock,
          label: 'Reportado',
          value: DateFormatter.dateTime(report.createdAt),
        ),
        _SheetRow(
          icon: LucideIcons.mapPin,
          label: 'Ubicación',
          value: report.coordinatesLabel,
        ),
        _SheetRow(icon: LucideIcons.users, label: 'Origen', value: 'Comunidad'),
        const SizedBox(height: 16),
        const InfoBanner(
          icon: LucideIcons.shieldAlert,
          tone: InfoBannerTone.warning,
          message:
              'Este reporte no ha sido verificado por HydroAlert ni por una autoridad.',
        ),
      ],
    );
  }
}

class _SheetRow extends StatelessWidget {
  const _SheetRow({
    required this.icon,
    required this.label,
    required this.value,
  });

  final IconData icon;
  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Row(
        children: [
          Icon(icon, size: 16, color: AppColors.textMuted),
          const SizedBox(width: 8),
          SizedBox(
            width: 84,
            child: Text(label, style: AppTypography.bodySmall),
          ),
          Expanded(
            child: Text(
              value,
              style: AppTypography.titleSmall,
              textAlign: TextAlign.right,
            ),
          ),
        ],
      ),
    );
  }
}
