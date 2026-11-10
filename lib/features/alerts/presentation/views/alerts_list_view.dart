import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

import '../../../../app/config/app_config.dart';
import '../../../../app/theme/app_colors.dart';
import '../../../../app/theme/app_typography.dart';
import '../viewmodels/alerts_viewmodel.dart';
import '../widgets/seismic_alerts_tab.dart';
import '../widgets/weather_alerts_tab.dart';

class AlertsListView extends ConsumerWidget {
  const AlertsListView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final alerts = ref.watch(alertsViewModelProvider);
    final strongCount =
        alerts.value
            ?.where((e) => e.magnitude >= AppConfig.sosMagnitudeThreshold)
            .length ??
        0;

    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: Row(
            children: [
              const Text('Alertas'),
              if (strongCount > 0) ...[
                const SizedBox(width: 10),
                _StrongEventsBadge(count: strongCount),
              ],
            ],
          ),
          bottom: const TabBar(
            tabs: [
              Tab(icon: Icon(LucideIcons.activity, size: 16), text: 'Sismos'),
              Tab(icon: Icon(LucideIcons.cloudRain, size: 16), text: 'Clima'),
            ],
          ),
        ),
        body: const TabBarView(
          children: [SeismicAlertsTab(), WeatherAlertsTab()],
        ),
      ),
    );
  }
}

class _StrongEventsBadge extends StatelessWidget {
  const _StrongEventsBadge({required this.count});

  final int count;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
      decoration: BoxDecoration(
        color: AppColors.danger.withValues(alpha: 0.15),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: AppColors.danger.withValues(alpha: 0.4)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(LucideIcons.triangleAlert, size: 12, color: AppColors.danger),
          const SizedBox(width: 4),
          Text(
            '$count fuerte${count != 1 ? 's' : ''}',
            style: AppTypography.labelSmall.copyWith(
              color: AppColors.danger,
              fontWeight: FontWeight.w700,
            ),
          ),
        ],
      ),
    );
  }
}
