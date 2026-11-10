import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

import '../../../../app/theme/app_colors.dart';
import '../../../../app/theme/app_typography.dart';
import '../../../../shared/motion/app_motion.dart';

/// Floating segmented layer selector for earthquakes, community reports, and radar.
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
    final palette = context.palette;

    return ClipRRect(
      borderRadius: BorderRadius.circular(22),
      child: BackdropFilter(
        filter: ui.ImageFilter.blur(sigmaX: 12, sigmaY: 12),
        child: Container(
          padding: const EdgeInsets.all(5),
          decoration: BoxDecoration(
            color: palette.mapPanel,
            borderRadius: BorderRadius.circular(22),
            border: Border.all(color: palette.border.withValues(alpha: 0.8)),
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
              Expanded(
                child: _LayerSegment(
                  icon: LucideIcons.activity,
                  label: 'Sismos',
                  count: earthquakeCount,
                  selected: earthquakesSelected,
                  color: AppColors.info,
                  foreground: palette.primaryStrong,
                  onTap: onToggleEarthquakes,
                ),
              ),
              const SizedBox(width: 4),
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
                    foreground: palette.warningStrong,
                    onTap: onToggleReports,
                  ),
                ),
              ),
              const SizedBox(width: 4),
              Expanded(
                child: _LayerSegment(
                  icon: LucideIcons.radar,
                  label: 'Radar',
                  selected: radarSelected,
                  color: palette.primary,
                  foreground: palette.primaryStrong,
                  isLoading: radarLoading,
                  onTap: onToggleRadar,
                ),
              ),
            ],
          ),
        ),
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
    final palette = context.palette;
    final effectiveForeground = isEnabled
        ? (isSelected ? foreground : palette.textSecondary)
        : palette.textMuted;

    return Semantics(
      button: true,
      selected: isSelected,
      enabled: isEnabled,
      label: label,
      child: AnimatedOpacity(
        opacity: isEnabled ? 1 : 0.45,
        duration: AppMotion.resolve(context, AppMotion.quick),
        child: AnimatedContainer(
          duration: AppMotion.resolve(context, AppMotion.quick),
          curve: AppMotion.curve,
          decoration: BoxDecoration(
            color: isSelected
                ? color.withValues(alpha: 0.14)
                : Colors.transparent,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(
              color: isSelected
                  ? color.withValues(alpha: 0.45)
                  : Colors.transparent,
              width: 1,
            ),
          ),
          child: Material(
            color: Colors.transparent,
            borderRadius: BorderRadius.circular(16),
            clipBehavior: Clip.antiAlias,
            child: InkWell(
              onTap: isEnabled && !isLoading
                  ? () {
                      HapticFeedback.selectionClick();
                      onTap?.call();
                    }
                  : null,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 9),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    AnimatedSwitcher(
                      duration: AppMotion.resolve(context, AppMotion.quick),
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
                              size: 15,
                              color: effectiveForeground,
                            ),
                    ),
                    const SizedBox(width: 5),
                    Flexible(
                      child: Text(
                        label,
                        overflow: TextOverflow.ellipsis,
                        style: AppTypography.labelSmall.copyWith(
                          fontSize: 11.5,
                          color: effectiveForeground,
                          fontWeight: isSelected
                              ? FontWeight.w700
                              : FontWeight.w500,
                        ),
                      ),
                    ),
                    if (count != null && count! > 0) ...[
                      const SizedBox(width: 4),
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 5,
                          vertical: 1.5,
                        ),
                        decoration: BoxDecoration(
                          color: isSelected
                              ? color.withValues(alpha: 0.22)
                              : palette.surfaceMuted,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Text(
                          '$count',
                          style: TextStyle(
                            fontSize: 9,
                            height: 1.1,
                            fontWeight: FontWeight.w800,
                            color: isSelected ? foreground : palette.textMuted,
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
