import 'package:flutter/material.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

import '../../../../app/theme/app_colors.dart';
import '../../../../shared/molecules/app_card.dart';

/// Floating zoom, locate and refresh controls of the map.
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
    return AppCard(
      padding: const EdgeInsets.all(4),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          _MapControlButton(
            icon: LucideIcons.plus,
            tooltip: 'Acercar',
            onPressed: onZoomIn,
          ),
          _MapControlButton(
            icon: LucideIcons.minus,
            tooltip: 'Alejar',
            onPressed: onZoomOut,
          ),
          Container(
            width: 22,
            height: 1,
            color: AppColors.border,
            margin: const EdgeInsets.symmetric(vertical: 2),
          ),
          _MapControlButton(
            icon: LucideIcons.locateFixed,
            tooltip: 'Centrar en mi ubicación',
            onPressed: onLocate,
            isLoading: isLocating,
          ),
          _MapControlButton(
            icon: LucideIcons.refreshCw,
            tooltip: 'Actualizar datos',
            onPressed: onRefresh,
          ),
        ],
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
              width: 17,
              height: 17,
              child: CircularProgressIndicator(strokeWidth: 2),
            )
          : Icon(icon, size: 19),
      color: AppColors.textSecondary,
      style: IconButton.styleFrom(
        minimumSize: const Size(42, 42),
        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
      ),
    );
  }
}
