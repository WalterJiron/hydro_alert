import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

import '../../../../app/theme/app_typography.dart';
import '../../../../shared/atoms/app_logo.dart';
import '../../../../shared/atoms/custom_button.dart';
import '../../../../shared/molecules/info_banner.dart';
import '../../../auth/presentation/viewmodels/auth_viewmodel.dart';

/// Shows the guest profile sheet from the home app bar.
Future<void> showHomeProfileSheet(BuildContext context, WidgetRef ref) {
  final user = ref.read(authViewModelProvider).value;

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
                user?.displayName ?? 'Invitado',
                style: AppTypography.titleMedium,
              ),
              const SizedBox(height: 2),
              Text(
                'Acceso como invitado. No se requiere cuenta.',
                style: AppTypography.bodySmall,
              ),
              const SizedBox(height: 18),
              const InfoBanner(
                icon: LucideIcons.info,
                title: 'Sobre los datos',
                message:
                    'Sismos: USGS. Clima: WeatherAPI. '
                    'Los reportes comunitarios no están verificados. '
                    'HydroAlert no sustituye a las autoridades.',
              ),
              const SizedBox(height: 14),
              CustomButton(
                label: 'Cerrar sesión',
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
