import 'package:flutter/material.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

import '../../../../app/theme/app_colors.dart';
import '../../../../app/theme/app_typography.dart';
import '../../../../shared/molecules/app_card.dart';
import '../../../../shared/motion/app_motion.dart';

/// Segmented layer switcher shown over the map.
class MapLayerBar extends StatelessWidget {
  const MapLayerBar({
    super.key,
    required this.earthquakesSelected,
    required this.reportsSelected,
    required this.radarSelected,
    required this.radarLoading,
    required this.reportsEnabled,
    this.earthquakeCount,
    this.reportCount,
    required this.onToggleEarthquakes,
    required this.onToggleReports,
    required this.onToggleRadar,
  });

  final bool earthquakesSelected;
  final bool reportsSelected;
  final bool radarSelected;
  final bool radarLoading;
  final bool reportsEnabled;
  final int? earthquakeCount;
  final int? reportCount;
  final VoidCallback onToggleEarthquakes;
  final VoidCallback? onToggleReports;
  final VoidCallback onToggleRadar;

  @override
  Widget build(BuildContext context) {
    return AppCard(
      padding: const EdgeInsets.all(6),
      child: Row(
        children: [
          Expanded(
            child: _LayerSegment(
              icon: LucideIcons.activity,
              label: 'Sismos',
              count: earthquakeCount,
              selected: earthquakesSelected,
              color: AppColors.info,
              foreground: AppColors.primaryDark,
              onTap: onToggleEarthquakes,
            ),
          ),
          const SizedBox(width: 6),
          Expanded(
            child: Tooltip(
              message: reportsEnabled
                  ? 'Reportes comunitarios'
                  : 'Servicio de reportes sin configurar',
              child: _LayerSegment(
                icon: LucideIcons.clipboardList,
                label: 'Reportes',
                count: reportsEnabled ? reportCount : null,
                selected: reportsSelected,
                color: AppColors.warning,
                foreground: AppColors.warningDark,
                onTap: onToggleReports,
              ),
            ),
          ),
          const SizedBox(width: 6),
          Expanded(
            child: _LayerSegment(
              icon: LucideIcons.radar,
              label: 'Radar',
              selected: radarSelected,
              color: AppColors.primary,
              foreground: AppColors.primaryDark,
              isLoading: radarLoading,
              onTap: onToggleRadar,
            ),
          ),
        ],
      ),
    );
  }
}

class _LayerSegment extends StatelessWidget {
  const _LayerSegment({
    required this.icon,
    required this.label,
    required this.selected,
    required this.color,
    required this.foreground,
    required this.onTap,
    this.count,
    this.isLoading = false,
  });

  final IconData icon;
  final String label;
  final bool selected;
  final Color color;
  final Color foreground;
  final VoidCallback? onTap;
  final int? count;
  final bool isLoading;

  @override
  Widget build(BuildContext context) {
    final isEnabled = onTap != null;
    final isSelected = selected && isEnabled;
    final effectiveForeground = isEnabled
        ? (isSelected ? foreground : AppColors.textSecondary)
        : AppColors.textMuted;

    return Semantics(
      button: true,
      selected: isSelected,
      enabled: isEnabled,
      label: label,
      child: AnimatedOpacity(
        opacity: isEnabled ? 1 : 0.55,
        duration: AppMotion.resolve(context, AppMotion.quick),
        child: AnimatedContainer(
          duration: AppMotion.resolve(context, AppMotion.quick),
          curve: AppMotion.curve,
          decoration: BoxDecoration(
            color: isSelected
                ? color.withValues(alpha: 0.12)
                : Colors.transparent,
            borderRadius: BorderRadius.circular(14),
            border: Border.all(
              color: isSelected
                  ? color.withValues(alpha: 0.5)
                  : AppColors.border,
            ),
          ),
          child: Material(
            color: Colors.transparent,
            borderRadius: BorderRadius.circular(14),
            clipBehavior: Clip.antiAlias,
            child: InkWell(
              onTap: isLoading ? null : onTap,
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 8,
                  vertical: 10,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    AnimatedSwitcher(
                      duration: AppMotion.resolve(context, AppMotion.quick),
                      switchInCurve: AppMotion.curve,
                      child: isLoading
                          ? SizedBox(
                              key: const ValueKey('loading'),
                              width: 14,
                              height: 14,
                              child: CircularProgressIndicator(
                                strokeWidth: 2,
                                color: effectiveForeground,
                              ),
                            )
                          : Icon(
                              icon,
                              key: ValueKey(icon),
                              size: 16,
                              color: effectiveForeground,
                            ),
                    ),
                    const SizedBox(width: 6),
                    Flexible(
                      child: Text(
                        label,
                        overflow: TextOverflow.ellipsis,
                        style: AppTypography.labelSmall.copyWith(
                          color: effectiveForeground,
                          fontWeight: isSelected
                              ? FontWeight.w800
                              : FontWeight.w600,
                        ),
                      ),
                    ),
                    if (count != null && count! > 0) ...[
                      const SizedBox(width: 5),
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 5,
                          vertical: 1,
                        ),
                        decoration: BoxDecoration(
                          color: isSelected
                              ? color.withValues(alpha: 0.2)
                              : AppColors.surfaceMuted,
                          borderRadius: BorderRadius.circular(6),
                        ),
                        child: AnimatedSwitcher(
                          duration: AppMotion.resolve(context, AppMotion.quick),
                          switchInCurve: AppMotion.curve,
                          child: Text(
                            '$count',
                            key: ValueKey(count),
                            style: TextStyle(
                              fontSize: 9.5,
                              height: 1.2,
                              fontWeight: FontWeight.w800,
                              color: isSelected
                                  ? foreground
                                  : AppColors.textMuted,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
