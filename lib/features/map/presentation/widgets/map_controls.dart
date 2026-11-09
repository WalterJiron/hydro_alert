import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

import '../../../../app/theme/app_colors.dart';

/// Floating zoom, locate, and refresh controls for the map.
class MapControls extends StatelessWidget {
  const MapControls({
    super.key,
    required this.isLocating,
    required this.onZoomIn,
    required this.onZoomOut,
    required this.onLocate,
    required this.onRefresh,
  });

  final bool isLocating;
  final VoidCallback onZoomIn;
  final VoidCallback onZoomOut;
  final VoidCallback onLocate;
  final VoidCallback onRefresh;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(20),
      child: BackdropFilter(
        filter: ui.ImageFilter.blur(sigmaX: 12, sigmaY: 12),
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 2),
          decoration: BoxDecoration(
            color: Colors.white.withValues(alpha: 0.94),
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: AppColors.border.withValues(alpha: 0.8)),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.08),
                blurRadius: 14,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              _MapControlButton(
                icon: LucideIcons.plus,
                tooltip: 'Acercar',
                onPressed: () {
                  HapticFeedback.selectionClick();
                  onZoomIn();
                },
              ),
              _MapControlButton(
                icon: LucideIcons.minus,
                tooltip: 'Alejar',
                onPressed: () {
                  HapticFeedback.selectionClick();
                  onZoomOut();
                },
              ),
              Container(
                width: 20,
                height: 1,
                color: AppColors.border.withValues(alpha: 0.8),
                margin: const EdgeInsets.symmetric(vertical: 3),
              ),
              _MapControlButton(
                icon: LucideIcons.locateFixed,
                tooltip: 'Centrar en mi ubicación',
                onPressed: () {
                  HapticFeedback.lightImpact();
                  onLocate();
                },
                isLoading: isLocating,
              ),
              _MapControlButton(
                icon: LucideIcons.refreshCw,
                tooltip: 'Actualizar datos',
                onPressed: () {
                  HapticFeedback.lightImpact();
                  onRefresh();
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _MapControlButton extends StatelessWidget {
  const _MapControlButton({
    required this.icon,
    required this.tooltip,
    required this.onPressed,
    this.isLoading = false,
  });

  final IconData icon;
  final String tooltip;
  final VoidCallback onPressed;
  final bool isLoading;

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: isLoading ? null : onPressed,
      tooltip: tooltip,
      icon: isLoading
          ? const SizedBox(
              width: 16,
              height: 16,
              child: CircularProgressIndicator(
                strokeWidth: 2,
                color: AppColors.primary,
              ),
            )
          : Icon(icon, size: 18),
      color: AppColors.textSecondary,
      style: IconButton.styleFrom(
        minimumSize: const Size(40, 40),
        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
      ),
    );
  }
}
