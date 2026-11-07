import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

import '../../../../app/config/app_config.dart';
import '../../../../core/utils/error_text.dart';
import '../../../../shared/atoms/custom_button.dart';
import '../../../../shared/feedback/state_views.dart';
import '../../../../shared/molecules/app_card.dart';
import '../../../community_reports/domain/entities/community_report.dart';
import '../../../community_reports/presentation/viewmodels/community_reports_viewmodel.dart';
import '../../../community_reports/presentation/widgets/community_report_card.dart';
import 'home_unavailable_card.dart';

/// Latest community reports preview for the home dashboard.
class HomeReportsSection extends ConsumerWidget {
  const HomeReportsSection({super.key, required this.reports});

  final AsyncValue<List<CommunityReport>> reports;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    if (!AppConfig.hasBackend) {
      return const HomeUnavailableCard(
        icon: LucideIcons.clipboardList,
        title: 'Reportes aún no configurados',
        message:
            'El servicio de reportes comunitarios no está configurado en esta compilación. '
            'Los sismos y el mapa siguen disponibles.',
      );
    }

    return reports.when(
      loading: () => const AppCard(
        child: LoadingState(message: 'Cargando reportes…', compact: true),
      ),
      error: (error, stackTrace) => HomeUnavailableCard(
        icon: LucideIcons.clipboardList,
        title: 'No pudimos cargar los reportes',
        message: errorMessageOf(error),
        onRetry: () =>
            ref.read(communityReportsViewModelProvider.notifier).refresh(),
      ),
      data: (items) {
        if (items.isEmpty) {
          return AppCard(
            child: Column(
              children: [
                const EmptyState(
                  icon: LucideIcons.clipboardList,
                  title: 'Aún no hay reportes activos',
                  message:
                      'Cuando la comunidad comparta una situación, aparecerá aquí.',
                ),
                const SizedBox(height: 4),
                CustomButton(
                  label: 'Crear reporte',
                  icon: LucideIcons.plus,
                  variant: AppButtonVariant.secondary,
                  onPressed: () => context.push('/reportes/nuevo'),
                ),
              ],
            ),
          );
        }

        final preview = items.take(2).toList();
        return Column(
          children: [
            for (var index = 0; index < preview.length; index++) ...[
              if (index > 0) const SizedBox(height: 10),
              CommunityReportCard(report: preview[index]),
            ],
          ],
        );
      },
    );
  }
}
