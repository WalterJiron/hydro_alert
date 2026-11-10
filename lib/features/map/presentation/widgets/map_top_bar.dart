import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

import '../../../../app/theme/app_colors.dart';
import '../../../../app/theme/app_typography.dart';
import '../../../../shared/atoms/app_logo.dart';
import '../../../../shared/atoms/status_indicator.dart';

/// Floating header of the map with app brand, seismic source and legend entry.
class MapTopBar extends StatelessWidget {
  const MapTopBar({
    super.key,
    required this.alertsLoading,
    required this.alertsAvailable,
    required this.onOpenLegend,
    this.alertsCount,
    this.sourceLabel,
  });

  final bool alertsLoading;
  final bool alertsAvailable;
  final VoidCallback onOpenLegend;
  final int? alertsCount;
  final String? sourceLabel;

  @override
  Widget build(BuildContext context) {
    final statusLabel = alertsLoading
        ? 'Sincronizando'
        : (alertsAvailable ? (sourceLabel ?? 'Sismos') : 'Sin conexión');

    return ClipRRect(
      borderRadius: BorderRadius.circular(20),
      child: BackdropFilter(
        filter: ui.ImageFilter.blur(sigmaX: 12, sigmaY: 12),
        child: Container(
          padding: const EdgeInsets.fromLTRB(10, 5, 5, 5),
          decoration: BoxDecoration(
            color: context.palette.mapPanel,
            borderRadius: BorderRadius.circular(20),
            border: Border.all(
              color: context.palette.border.withValues(alpha: 0.8),
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.08),
                blurRadius: 16,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Row(
            children: [
              const AppLogo(size: 24),
              const SizedBox(width: 8),
              Text('Nicaragua', style: AppTypography.titleSmall),
              const SizedBox(width: 10),
              StatusIndicator(
                label: statusLabel,
                color: alertsAvailable ? AppColors.info : AppColors.warning,
                isActive: alertsAvailable,
              ),
              const Spacer(),
              if (alertsCount != null && alertsCount! > 0) ...[
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 7,
                    vertical: 2,
                  ),
                  decoration: BoxDecoration(
                    color: context.palette.primarySoft,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Text(
                    '$alertsCount sismos',
                    style: TextStyle(
                      fontSize: 10,
                      fontWeight: FontWeight.w700,
                      color: context.palette.primaryStrong,
                    ),
                  ),
                ),
                const SizedBox(width: 4),
              ],
              IconButton(
                onPressed: () {
                  HapticFeedback.lightImpact();
                  onOpenLegend();
                },
                tooltip: 'Leyenda del mapa',
                icon: const Icon(LucideIcons.info, size: 18),
                color: context.palette.textSecondary,
                style: IconButton.styleFrom(
                  minimumSize: const Size(36, 36),
                  tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
