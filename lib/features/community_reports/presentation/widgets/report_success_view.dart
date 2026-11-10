import 'package:flutter/material.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

import '../../../../app/theme/app_colors.dart';
import '../../../../app/theme/app_typography.dart';
import '../../../../shared/atoms/custom_button.dart';
import '../../../../shared/molecules/info_banner.dart';

/// Confirmation screen shown after the report is accepted.
class ReportSuccessView extends StatelessWidget {
  const ReportSuccessView({
    super.key,
    required this.onDone,
    required this.onCreateAnother,
  });

  final VoidCallback onDone;
  final VoidCallback onCreateAnother;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(28),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 84,
              height: 84,
              decoration: BoxDecoration(
                color: context.palette.successSoft,
                shape: BoxShape.circle,
              ),
              child: Icon(
                LucideIcons.checkCircle2,
                size: 42,
                color: context.palette.successStrong,
              ),
            ),
            const SizedBox(height: 20),
            Text(
              'Reporte enviado',
              style: AppTypography.headlineSmall,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 8),
            Text(
              'Gracias por ayudar a tu comunidad. Tu reporte se mostrará como '
              'información no verificada.',
              style: AppTypography.bodyMedium,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 20),
            const InfoBanner(
              icon: LucideIcons.users,
              tone: InfoBannerTone.warning,
              message:
                  'Si la situación es una emergencia, sigue las indicaciones de '
                  'las autoridades locales.',
            ),
            const SizedBox(height: 24),
            CustomButton(
              label: 'Volver a reportes',
              icon: LucideIcons.arrowRight,
              expand: true,
              onPressed: onDone,
            ),
            const SizedBox(height: 8),
            CustomButton(
              label: 'Crear otro reporte',
              variant: AppButtonVariant.ghost,
              expand: true,
              onPressed: onCreateAnother,
            ),
          ],
        ),
      ),
    );
  }
}
