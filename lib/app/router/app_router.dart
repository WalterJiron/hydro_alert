import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../features/alerts/presentation/views/alerts_list_view.dart';
import '../../features/auth/presentation/views/welcome_view.dart';
import '../../features/community_reports/presentation/views/community_reports_view.dart';
import '../../features/community_reports/presentation/views/report_wizard_view.dart';
import '../../features/emergency_sos/presentation/views/emergency_center_view.dart';
import '../../features/home/presentation/views/home_dashboard_view.dart';
import '../../features/map/presentation/views/live_map_view.dart';
import '../../shared/atoms/custom_button.dart';
import '../../shared/organisms/app_shell.dart';
import '../theme/app_colors.dart';
import '../theme/app_typography.dart';
import 'animated_branch_container.dart';

final _rootNavigatorKey = GlobalKey<NavigatorState>(debugLabel: 'root');

final routerProvider = Provider<GoRouter>((ref) {
  final router = GoRouter(
    navigatorKey: _rootNavigatorKey,
    initialLocation: '/bienvenida',
    routes: [
      GoRoute(
        path: '/bienvenida',
        builder: (context, state) => const WelcomeView(),
      ),
      StatefulShellRoute(
        builder: (context, state, navigationShell) {
          return AppShell(navigationShell: navigationShell);
        },
        navigatorContainerBuilder: (context, navigationShell, children) {
          return AnimatedBranchContainer(
            currentIndex: navigationShell.currentIndex,
            children: children,
          );
        },
        branches: [
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: '/inicio',
                builder: (context, state) => const HomeDashboardView(),
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: '/mapa',
                builder: (context, state) => const LiveMapView(),
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: '/reportes',
                builder: (context, state) => const CommunityReportsView(),
                routes: [
                  GoRoute(
                    path: 'nuevo',
                    parentNavigatorKey: _rootNavigatorKey,
                    builder: (context, state) => const ReportWizardView(),
                  ),
                ],
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: '/alertas',
                builder: (context, state) => const AlertsListView(),
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: '/emergencia',
                builder: (context, state) => const EmergencyCenterView(),
              ),
            ],
          ),
        ],
      ),
    ],
    errorBuilder: (context, state) =>
        _RouteErrorView(error: state.error?.toString()),
  );

  ref.onDispose(router.dispose);
  return router;
});

class _RouteErrorView extends StatelessWidget {
  const _RouteErrorView({this.error});

  final String? error;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(32),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text('Página no encontrada', style: AppTypography.headlineSmall),
              const SizedBox(height: 6),
              Text(
                'La ruta que intentaste abrir no existe.',
                style: AppTypography.bodyMedium.copyWith(
                  color: AppColors.textMuted,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 20),
              CustomButton(
                label: 'Ir al inicio',
                icon: Icons.home_rounded,
                onPressed: () => context.go('/inicio'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
