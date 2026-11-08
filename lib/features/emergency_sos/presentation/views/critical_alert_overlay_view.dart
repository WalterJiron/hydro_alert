import 'package:flutter/material.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

import '../../../../app/theme/app_colors.dart';
import '../../../../app/theme/app_typography.dart';
import '../../../../core/utils/date_formatter.dart';
import '../../../../shared/atoms/alert_badge.dart';
import '../../../../shared/atoms/custom_button.dart';
import '../../../../shared/motion/app_animated_entrance.dart';
import '../../domain/entities/emergency_event.dart';

class CriticalAlertOverlayView extends StatelessWidget {
  const CriticalAlertOverlayView({
    super.key,
    required this.event,
    required this.onDismiss,
  });

  final EmergencyEvent event;
  final VoidCallback onDismiss;

  @override
  Widget build(BuildContext context) {
    final isSeismic = event.isSeismic;

    return Material(
      color: AppColors.overlay,
      child: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(20),
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 440),
              child: AppAnimatedEntrance(
                fromScale: 0.94,
                offset: const Offset(0, 0.06),
                child: Container(
                  padding: const EdgeInsets.all(22),
                  decoration: BoxDecoration(
                    color: AppColors.surface,
                    borderRadius: BorderRadius.circular(28),
                    border: Border.all(
                      color: AppColors.danger.withValues(alpha: 0.25),
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withValues(alpha: 0.22),
                        blurRadius: 40,
                        offset: const Offset(0, 18),
                      ),
                    ],
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Container(
                        width: 76,
                        height: 76,
                        decoration: const BoxDecoration(
                          color: AppColors.dangerSoft,
                          shape: BoxShape.circle,
                        ),
                        child: const Icon(
                          LucideIcons.siren,
                          size: 38,
                          color: AppColors.danger,
                        ),
                      ),
                      const SizedBox(height: 16),
                      const AlertBadge(
                        label: 'ALERTA CRÍTICA',
                        tone: AppBadgeTone.danger,
                      ),
                      const SizedBox(height: 12),
                      Text(
                        event.title,
                        style: AppTypography.headlineMedium,
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 8),
                      Text(
                        event.message,
                        style: AppTypography.bodyMedium,
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 14),
                      Wrap(
                        alignment: WrapAlignment.center,
                        spacing: 8,
                        runSpacing: 8,
                        children: [
                          AlertBadge(
                            label: isSeismic ? 'USGS' : 'Notificación',
                            tone: isSeismic
                                ? AppBadgeTone.info
                                : AppBadgeTone.warning,
                          ),
                          if (event.occurredAt != null)
                            AlertBadge(
                              label: DateFormatter.relative(event.occurredAt!),
                              tone: AppBadgeTone.neutral,
                              icon: LucideIcons.clock,
                            ),
                          if (event.magnitude != null)
                            AlertBadge(
                              label: 'M ${event.magnitude!.toStringAsFixed(1)}',
                              tone: AppBadgeTone.seismic,
                            ),
                        ],
                      ),
                      if (event.place != null) ...[
                        const SizedBox(height: 10),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Icon(
                              LucideIcons.mapPin,
                              size: 14,
                              color: AppColors.textMuted,
                            ),
                            const SizedBox(width: 4),
                            Flexible(
                              child: Text(
                                event.place!,
                                style: AppTypography.bodySmall,
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ],
                        ),
                      ],
                      const SizedBox(height: 16),
                      Container(
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: AppColors.warningSoft,
                          borderRadius: BorderRadius.circular(14),
                        ),
                        child: Text(
                          isSeismic
                              ? 'Este evento proviene de USGS. No es una alerta oficial '
                                    'de evacuación. Sigue las indicaciones de las autoridades.'
                              : 'Revisa la información y sigue las indicaciones de las autoridades.',
                          style: AppTypography.bodySmall.copyWith(
                            color: AppColors.warningDark,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                      const SizedBox(height: 18),
                      CustomButton(
                        label: 'Entendido',
                        icon: LucideIcons.check,
                        expand: true,
                        onPressed: onDismiss,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
