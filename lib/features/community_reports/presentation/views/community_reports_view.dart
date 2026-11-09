import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

import '../../../../app/config/app_config.dart';
import '../../../../core/utils/error_text.dart';
import '../../../../shared/feedback/state_views.dart';
import '../../../../shared/molecules/info_banner.dart';
import '../../../../shared/molecules/section_header.dart';
import '../../../../shared/motion/app_animated_entrance.dart';
import '../viewmodels/community_reports_viewmodel.dart';
import '../widgets/community_report_card.dart';
import '../widgets/community_report_cta.dart';
import '../widgets/community_report_sheet.dart';

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
          padding: const EdgeInsets.fromLTRB(16, 8, 16, 100),
          children: [
            const AppAnimatedEntrance(
              order: 0,
              child: InfoBanner(
                icon: LucideIcons.users,
                tone: InfoBannerTone.warning,
                title: 'Información no verificada',
                message:
                    'Los reportes son enviados por la comunidad. HydroAlert no ha '
                    'confirmado su exactitud. Úsalos como referencia, no como una alerta oficial.',
              ),
            ),
            if (!AppConfig.hasBackend) ...[
              const SizedBox(height: 12),
              const AppAnimatedEntrance(
                order: 1,
                child: InfoBanner(
                  icon: LucideIcons.serverCrash,
                  title: 'Servicio no configurado',
                  message:
                      'El envío y la consulta de reportes se activarán cuando se '
                      'configure la URL del backend de HydroAlert.',
                ),
              ),
            ],
            const SizedBox(height: 16),
            AppAnimatedEntrance(
              order: 2,
              child: CommunityReportCta(
                enabled: AppConfig.hasBackend,
                onTap: () => context.push('/reportes/nuevo'),
              ),
            ),
            const SizedBox(height: 24),
            AppAnimatedEntrance(
              order: 3,
              child: SectionHeader(
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
                      AppAnimatedEntrance(
                        order: index + 4,
                        child: CommunityReportCard(
                          report: items[index],
                          onTap: () =>
                              showCommunityReportSheet(context, items[index]),
                        ),
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
}
