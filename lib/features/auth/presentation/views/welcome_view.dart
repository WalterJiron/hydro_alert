import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

import '../../../../app/config/app_config.dart';
import '../../../../app/theme/app_colors.dart';
import '../../../../app/theme/app_typography.dart';
import '../../../../shared/atoms/app_logo.dart';
import '../../../../shared/atoms/custom_button.dart';
import '../../../../shared/molecules/info_banner.dart';
import '../../../../shared/motion/app_animated_entrance.dart';
import '../viewmodels/auth_viewmodel.dart';
import '../widgets/welcome_feature.dart';

class WelcomeView extends ConsumerWidget {
  const WelcomeView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final auth = ref.watch(authViewModelProvider);
    final isLoading = auth.isLoading;

    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            return SingleChildScrollView(
              padding: const EdgeInsets.fromLTRB(24, 28, 24, 32),
              child: ConstrainedBox(
                constraints: BoxConstraints(
                  minHeight: constraints.maxHeight - 60,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const AppAnimatedEntrance(
                      order: 0,
                      child: AppLogo(
                        size: 56,
                        showWordmark: true,
                        showTagline: true,
                      ),
                    ),
                    const SizedBox(height: 40),
                    const AppAnimatedEntrance(
                      order: 1,
                      child: Text(
                        'Información clara cuando más la necesitas.',
                        style: AppTypography.displayMedium,
                      ),
                    ),
                    const SizedBox(height: 12),
                    const AppAnimatedEntrance(
                      order: 2,
                      child: Text(
                        'Sismos, clima y reportes comunitarios de Nicaragua en un solo lugar, '
                        'con un diseño pensado para decidir rápido.',
                        style: AppTypography.bodyLarge,
                      ),
                    ),
                    const SizedBox(height: 28),
                    const AppAnimatedEntrance(
                      order: 3,
                      child: WelcomeFeature(
                        icon: LucideIcons.activity,
                        title: 'Actividad sísmica',
                        description:
                            'Eventos recientes del Servicio Geológico de EE. UU. (USGS).',
                      ),
                    ),
                    const SizedBox(height: 16),
                    const AppAnimatedEntrance(
                      order: 4,
                      child: WelcomeFeature(
                        icon: LucideIcons.map,
                        title: 'Mapa y radar',
                        description:
                            'Ubicaciones, reportes de la comunidad y capa de lluvia opcional.',
                      ),
                    ),
                    const SizedBox(height: 16),
                    const AppAnimatedEntrance(
                      order: 5,
                      child: WelcomeFeature(
                        icon: LucideIcons.users,
                        title: 'Reportes comunitarios',
                        description:
                            'Comparte lo que observas. Todo reporte se muestra como no verificado.',
                      ),
                    ),
                    const SizedBox(height: 28),
                    const AppAnimatedEntrance(
                      order: 6,
                      child: InfoBanner(
                        icon: LucideIcons.shieldAlert,
                        tone: InfoBannerTone.warning,
                        title: 'Importante',
                        message:
                            'HydroAlert no sustituye a las autoridades. '
                            'Los eventos de USGS no son alertas oficiales de evacuación.',
                      ),
                    ),
                    const SizedBox(height: 24),
                    AppAnimatedEntrance(
                      order: 7,
                      child: CustomButton(
                        label: 'Continuar como invitado',
                        icon: LucideIcons.arrowRight,
                        expand: true,
                        isLoading: isLoading,
                        onPressed: () async {
                          await ref
                              .read(authViewModelProvider.notifier)
                              .continueAsGuest();
                          if (!context.mounted) {
                            return;
                          }
                          final user = ref.read(authViewModelProvider).value;
                          if (user != null) {
                            context.go('/inicio');
                          }
                        },
                      ),
                    ),
                    const SizedBox(height: 10),
                    const AppAnimatedEntrance(
                      order: 8,
                      child: Center(
                        child: Text(
                          'No necesitas crear una cuenta para comenzar.',
                          style: AppTypography.bodySmall,
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                    const SizedBox(height: 40),
                    const AppAnimatedEntrance(
                      order: 8,
                      child: Center(
                        child: Text(
                          '${AppConfig.appName} · ${AppConfig.countryName}',
                          style: AppTypography.labelSmall,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
