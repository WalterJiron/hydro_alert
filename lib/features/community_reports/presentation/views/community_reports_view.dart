import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

import '../../../../app/config/app_config.dart';
import '../../../../app/theme/app_colors.dart';
import '../../../../app/theme/app_typography.dart';
import '../../../../core/utils/date_formatter.dart';
import '../../../../core/utils/error_text.dart';
import '../../../../shared/atoms/alert_badge.dart';
import '../../../../shared/feedback/state_views.dart';
import '../../../../shared/molecules/app_card.dart';
import '../../../../shared/molecules/info_banner.dart';
import '../../../../shared/molecules/section_header.dart';
import '../../domain/entities/community_report.dart';
import '../viewmodels/community_reports_viewmodel.dart';
import '../widgets/community_report_card.dart';
import '../widgets/report_category_visuals.dart';

class CommunityReportsView extends ConsumerWidget {
  const CommunityReportsView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final reports = ref.watch(communityReportsViewModelProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Reportes comunitarios'),
        actions: [
          IconButton(
            tooltip: 'Actualizar reportes',
            onPressed: AppConfig.hasBackend
                ? () => ref
                      .read(communityReportsViewModelProvider.notifier)
                      .refresh()
                : null,
            icon: const Icon(LucideIcons.refreshCw, size: 20),
          ),
          const SizedBox(width: 8),
        ],
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          if (AppConfig.hasBackend) {
            await ref
                .read(communityReportsViewModelProvider.notifier)
                .refresh();
          }
        },
        child: ListView(
          physics: const AlwaysScrollableScrollPhysics(),
          padding: const EdgeInsets.fromLTRB(16, 8, 16, 24),
          children: [
            const InfoBanner(
              icon: LucideIcons.users,
              tone: InfoBannerTone.warning,
              title: 'Información no verificada',
              message:
                  'Los reportes son enviados por la comunidad. HydroAlert no ha '
                  'confirmado su exactitud. Úsalos como referencia, no como una alerta oficial.',
            ),
            if (!AppConfig.hasBackend) ...[
              const SizedBox(height: 12),
              const InfoBanner(
                icon: LucideIcons.serverCrash,
                title: 'Servicio no configurado',
                message:
                    'El envío y la consulta de reportes se activarán cuando se '
                    'configure la URL del backend de HydroAlert.',
              ),
            ],
            const SizedBox(height: 16),
            _ReportCta(
              enabled: AppConfig.hasBackend,
              onTap: () => context.push('/reportes/nuevo'),
            ),
            const SizedBox(height: 24),
            SectionHeader(
              title: 'Reportes activos',
              subtitle: AppConfig.hasBackend
                  ? 'Ordenados del más reciente al más antiguo'
                  : 'Sin conexión con el servicio de reportes',
              actionLabel: AppConfig.hasBackend ? 'Actualizar' : null,
              onAction: AppConfig.hasBackend
                  ? () => ref
                        .read(communityReportsViewModelProvider.notifier)
                        .refresh()
                  : null,
            ),
            const SizedBox(height: 10),
            if (!AppConfig.hasBackend)
              const EmptyState(
                icon: LucideIcons.clipboardList,
                title: 'Reportes no disponibles',
                message:
                    'Cuando el servicio esté configurado, los reportes activos aparecerán aquí.',
              )
            else
              ...reports.when(
                loading: () => const [
                  Padding(
                    padding: EdgeInsets.only(top: 28),
                    child: LoadingState(message: 'Cargando reportes…'),
                  ),
                ],
                error: (error, stackTrace) => [
                  Padding(
                    padding: const EdgeInsets.only(top: 16),
                    child: ErrorState(
                      message: errorMessageOf(error),
                      onRetry: () => ref
                          .read(communityReportsViewModelProvider.notifier)
                          .refresh(),
                    ),
                  ),
                ],
                data: (items) {
                  if (items.isEmpty) {
                    return const [
                      EmptyState(
                        icon: LucideIcons.clipboardList,
                        title: 'Aún no hay reportes activos',
                        message:
                            'Sé la primera persona en compartir una situación de riesgo.',
                      ),
                    ];
                  }

                  return [
                    for (var index = 0; index < items.length; index++) ...[
                      if (index > 0) const SizedBox(height: 10),
                      CommunityReportCard(
                        report: items[index],
                        onTap: () => _showReportSheet(context, items[index]),
                      ),
                    ],
                  ];
                },
              ),
          ],
        ),
      ),
    );
  }

  void _showReportSheet(BuildContext context, CommunityReport report) {
    final color = reportCategoryColor(report.category);

    showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      showDragHandle: true,
      builder: (sheetContext) {
        return SafeArea(
          top: false,
          child: Padding(
            padding: const EdgeInsets.fromLTRB(20, 0, 20, 24),
            child: Column(
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
                _SheetRow(
                  icon: LucideIcons.users,
                  label: 'Origen',
                  value: 'Comunidad',
                ),
                const SizedBox(height: 16),
                const InfoBanner(
                  icon: LucideIcons.shieldAlert,
                  tone: InfoBannerTone.warning,
                  message:
                      'Este reporte no ha sido verificado por HydroAlert ni por una autoridad.',
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

class _ReportCta extends StatelessWidget {
  const _ReportCta({required this.enabled, required this.onTap});

  final bool enabled;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return AppCard(
      backgroundColor: AppColors.primarySoft,
      borderColor: AppColors.primary.withValues(alpha: 0.18),
      child: Row(
        children: [
          Container(
            width: 48,
            height: 48,
            decoration: BoxDecoration(
              color: AppColors.primary,
              borderRadius: BorderRadius.circular(14),
            ),
            child: const Icon(LucideIcons.plus, color: Colors.white, size: 24),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '¿Viste una situación de riesgo?',
                  style: AppTypography.titleSmall,
                ),
                const SizedBox(height: 2),
                Text(
                  enabled
                      ? 'Comparte una foto, una descripción y la ubicación.'
                      : 'El servicio de reportes no está configurado todavía.',
                  style: AppTypography.bodySmall,
                ),
              ],
            ),
          ),
          const SizedBox(width: 8),
          IconButton(
            onPressed: enabled ? onTap : null,
            tooltip: 'Crear reporte',
            style: IconButton.styleFrom(
              backgroundColor: enabled ? AppColors.primary : AppColors.surface,
              foregroundColor: enabled ? Colors.white : AppColors.textMuted,
            ),
            icon: const Icon(LucideIcons.arrowRight, size: 20),
          ),
        ],
      ),
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
