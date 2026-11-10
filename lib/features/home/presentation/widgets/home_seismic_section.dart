import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

import '../../../../core/utils/error_text.dart';
import '../../../../shared/feedback/state_views.dart';
import '../../../../shared/molecules/app_card.dart';
import '../../../alerts/domain/entities/seismic_event.dart';
import '../../../alerts/presentation/viewmodels/alerts_viewmodel.dart';
import '../../../alerts/presentation/widgets/seismic_event_card.dart';
import 'home_unavailable_card.dart';

/// Latest INETER/USGS earthquakes preview for the home dashboard.
class HomeSeismicSection extends ConsumerWidget {
  const HomeSeismicSection({super.key, required this.alerts});

  final AsyncValue<List<SeismicEvent>> alerts;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return alerts.when(
      loading: () => const AppCard(
        child: LoadingState(message: 'Consultando sismos…', compact: true),
      ),
      error: (error, stackTrace) => HomeUnavailableCard(
        icon: LucideIcons.activity,
        title: 'No pudimos cargar los sismos',
        message: errorMessageOf(error),
        onRetry: () => ref.read(alertsViewModelProvider.notifier).refresh(),
      ),
      data: (events) {
        if (events.isEmpty) {
          return const AppCard(
            child: EmptyState(
              icon: LucideIcons.activity,
              title: 'Sin sismos recientes',
              message:
                  'No hay eventos sísmicos reportados en el área de Nicaragua durante los últimos 30 días.',
            ),
          );
        }

        final preview = events.take(3).toList();
        return Column(
          children: [
            for (var index = 0; index < preview.length; index++) ...[
              if (index > 0) const SizedBox(height: 10),
              SeismicEventCard(event: preview[index]),
            ],
          ],
        );
      },
    );
  }
}
