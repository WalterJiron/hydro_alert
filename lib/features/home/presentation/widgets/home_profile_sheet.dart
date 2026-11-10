import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

import '../../../../app/theme/app_colors.dart';
import '../../../../app/theme/app_typography.dart';
import '../../../../shared/atoms/alert_badge.dart';
import '../../../../shared/atoms/app_logo.dart';
import '../../../../shared/atoms/custom_button.dart';
import '../../../../shared/molecules/app_card.dart';
import '../../../../shared/molecules/info_banner.dart';
import '../../../auth/presentation/viewmodels/auth_viewmodel.dart';
import '../../../auth/presentation/widgets/auth_sheet.dart';

/// Muestra la hoja de perfil y estado de cuenta desde la barra superior.
Future<void> showHomeProfileSheet(BuildContext context, WidgetRef ref) {
  final session = ref.read(authViewModelProvider).value;
  final isAuthenticated = session?.isAuthenticated ?? false;

  return showModalBottomSheet<void>(
    context: context,
    isScrollControlled: true,
    useSafeArea: true,
    showDragHandle: true,
    builder: (sheetContext) {
      return SafeArea(
        top: false,
        child: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(20, 0, 20, 24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const Center(child: AppLogo(size: 38, showWordmark: true)),
              const SizedBox(height: 18),
              _ProfileHeaderCard(
                isAuthenticated: isAuthenticated,
                displayName: session?.user.displayName ?? 'Modo Invitado',
                email: session?.user.email,
              ),
              const SizedBox(height: 14),
              if (!isAuthenticated)
                _GuestReporterPromotionCard(
                  onAction: () async {
                    Navigator.of(sheetContext).pop();
                    if (context.mounted) {
                      await showAuthSheet(context);
                    }
                  },
                )
              else
                _AuthenticatedInfoCard(email: session?.user.email),
              const SizedBox(height: 14),
              const InfoBanner(
                icon: LucideIcons.info,
                title: 'Fuentes oficiales',
                message:
                    'Sismos: INETER (con respaldo USGS). Clima: avisos meteorológicos '
                    'oficiales. Los reportes comunitarios no sustituyen a las autoridades.',
              ),
              const SizedBox(height: 16),
              CustomButton(
                label: isAuthenticated
                    ? 'Cerrar sesión'
                    : 'Salir del modo invitado',
                icon: LucideIcons.logOut,
                variant: AppButtonVariant.ghost,
                expand: true,
                onPressed: () async {
                  Navigator.of(sheetContext).pop();
                  await ref.read(authViewModelProvider.notifier).signOut();
                  if (context.mounted) {
                    context.go('/bienvenida');
                  }
                },
              ),
            ],
          ),
        ),
      );
    },
  );
}

class _ProfileHeaderCard extends StatelessWidget {
  const _ProfileHeaderCard({
    required this.isAuthenticated,
    required this.displayName,
    this.email,
  });

  final bool isAuthenticated;
  final String displayName;
  final String? email;

  @override
  Widget build(BuildContext context) {
    final palette = context.palette;

    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: palette.surfaceMuted,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: palette.border),
      ),
      child: Row(
        children: [
          Container(
            width: 46,
            height: 46,
            decoration: BoxDecoration(
              color: isAuthenticated ? palette.primarySoft : palette.surface,
              shape: BoxShape.circle,
              border: Border.all(
                color: isAuthenticated
                    ? palette.primary.withValues(alpha: 0.5)
                    : palette.border,
                width: 1.5,
              ),
            ),
            child: Icon(
              isAuthenticated ? LucideIcons.userCheck : LucideIcons.userRound,
              color: isAuthenticated
                  ? palette.primaryStrong
                  : palette.textMuted,
              size: 22,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Flexible(
                      child: Text(
                        displayName,
                        style: AppTypography.titleMedium,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    const SizedBox(width: 8),
                    AlertBadge(
                      label: isAuthenticated ? 'Reportante' : 'Invitado',
                      tone: isAuthenticated
                          ? AppBadgeTone.success
                          : AppBadgeTone.neutral,
                    ),
                  ],
                ),
                const SizedBox(height: 2),
                Text(
                  isAuthenticated
                      ? (email ?? 'Cuenta de reportante activa')
                      : 'Exploración pública libre',
                  style: AppTypography.bodySmall.copyWith(
                    color: palette.textMuted,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _GuestReporterPromotionCard extends StatelessWidget {
  const _GuestReporterPromotionCard({required this.onAction});

  final VoidCallback onAction;

  @override
  Widget build(BuildContext context) {
    final palette = context.palette;

    return AppCard(
      padding: const EdgeInsets.all(14),
      backgroundColor: palette.primarySoft.withValues(alpha: 0.25),
      borderColor: palette.primary.withValues(alpha: 0.35),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: palette.primary.withValues(alpha: 0.12),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Icon(
                  LucideIcons.filePlus2,
                  size: 20,
                  color: palette.primary,
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '¿Deseas publicar reportes?',
                      style: AppTypography.titleSmall.copyWith(
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    const SizedBox(height: 3),
                    Text(
                      'Identifícate con tu cuenta de reportante para alertar a la comunidad.',
                      style: AppTypography.bodySmall.copyWith(
                        color: palette.textSecondary,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          CustomButton(
            label: 'Iniciar sesión o crear cuenta',
            icon: LucideIcons.logIn,
            expand: true,
            onPressed: onAction,
          ),
        ],
      ),
    );
  }
}

class _AuthenticatedInfoCard extends StatelessWidget {
  const _AuthenticatedInfoCard({this.email});

  final String? email;

  @override
  Widget build(BuildContext context) {
    final palette = context.palette;

    return AppCard(
      padding: const EdgeInsets.all(14),
      backgroundColor: palette.successSoft.withValues(alpha: 0.2),
      borderColor: palette.successStrong.withValues(alpha: 0.3),
      child: Row(
        children: [
          Icon(LucideIcons.shieldCheck, size: 22, color: palette.successStrong),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Cuenta de reportante activa',
                  style: AppTypography.titleSmall.copyWith(
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  'Tus reportes se enviarán firmados con tu cuenta.',
                  style: AppTypography.bodySmall.copyWith(
                    color: palette.textSecondary,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
