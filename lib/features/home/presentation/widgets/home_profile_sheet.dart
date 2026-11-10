import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

import '../../../../app/theme/app_typography.dart';
import '../../../../shared/atoms/app_logo.dart';
import '../../../../shared/atoms/custom_button.dart';
import '../../../../shared/molecules/info_banner.dart';
import '../../../auth/presentation/viewmodels/auth_viewmodel.dart';
import '../../../auth/presentation/widgets/auth_sheet.dart';

/// Shows the profile sheet from the home app bar.
Future<void> showHomeProfileSheet(BuildContext context, WidgetRef ref) {
  final session = ref.read(authViewModelProvider).value;
  final isAuthenticated = session?.isAuthenticated ?? false;

  return showModalBottomSheet<void>(
    context: context,
    showDragHandle: true,
    builder: (sheetContext) {
      return SafeArea(
        top: false,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(20, 0, 20, 20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const AppLogo(size: 44, showWordmark: true, showTagline: true),
              const SizedBox(height: 18),
              Text(
                session?.user.displayName ?? 'Invitado',
                style: AppTypography.titleMedium,
              ),
              const SizedBox(height: 2),
              Text(
                isAuthenticated
                    ? (session?.user.email ?? 'Cuenta de reportante')
                    : 'Acceso como invitado. No se requiere cuenta para explorar.',
                style: AppTypography.bodySmall,
              ),
              const SizedBox(height: 18),
              const InfoBanner(
                icon: LucideIcons.info,
                title: 'Sobre los datos',
                message:
                    'Sismos: INETER (respaldo USGS). Clima: condiciones y avisos '
                    'meteorológicos. Los reportes comunitarios no están verificados. '
                    'HydroAlert no sustituye a las autoridades.',
              ),
              const SizedBox(height: 14),
              if (!isAuthenticated) ...[
                CustomButton(
                  label: 'Iniciar sesión o crear cuenta',
                  icon: LucideIcons.logIn,
                  expand: true,
                  onPressed: () async {
                    Navigator.of(sheetContext).pop();
                    if (context.mounted) {
                      await showAuthSheet(context);
                    }
                  },
                ),
                const SizedBox(height: 8),
                Text(
                  'Solo se solicita una cuenta al publicar un reporte.',
                  style: AppTypography.labelSmall,
                ),
                const SizedBox(height: 8),
              ],
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
