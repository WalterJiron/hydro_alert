import 'package:flutter/material.dart';

import '../../app/theme/app_colors.dart';
import '../motion/app_press_scale.dart';

enum AppButtonVariant { primary, secondary, ghost, danger }

/// Single button API so screens never re-implement loading or sizing rules.
class CustomButton extends StatelessWidget {
  const CustomButton({
    super.key,
    required this.label,
    required this.onPressed,
    this.icon,
    this.isLoading = false,
    this.expand = false,
    this.variant = AppButtonVariant.primary,
  });

  final String label;
  final VoidCallback? onPressed;
  final IconData? icon;
  final bool isLoading;
  final bool expand;
  final AppButtonVariant variant;

  @override
  Widget build(BuildContext context) {
    final effectiveOnPressed = isLoading ? null : onPressed;

    final content = Row(
      mainAxisSize: expand ? MainAxisSize.max : MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        if (isLoading)
          const SizedBox(
            width: 18,
            height: 18,
            child: CircularProgressIndicator(strokeWidth: 2.2),
          )
        else if (icon != null)
          Icon(icon, size: 18),
        if (isLoading || icon != null) const SizedBox(width: 8),
        Flexible(
          child: Text(
            label,
            textAlign: TextAlign.center,
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ],
    );

    final button = switch (variant) {
      AppButtonVariant.primary => FilledButton(
        onPressed: effectiveOnPressed,
        child: content,
      ),
      AppButtonVariant.secondary => OutlinedButton(
        onPressed: effectiveOnPressed,
        child: content,
      ),
      AppButtonVariant.ghost => TextButton(
        onPressed: effectiveOnPressed,
        child: content,
      ),
      AppButtonVariant.danger => FilledButton(
        onPressed: effectiveOnPressed,
        style: FilledButton.styleFrom(
          backgroundColor: AppColors.danger,
          foregroundColor: Colors.white,
        ),
        child: content,
      ),
    };

    final scaled = AppPressScale(
      enabled: effectiveOnPressed != null,
      pressedScale: 0.98,
      child: button,
    );

    if (!expand) {
      return scaled;
    }

    return SizedBox(width: double.infinity, child: scaled);
  }
}

/// Small, consistent icon-button used on app bars and map controls.
class AppIconButton extends StatelessWidget {
  const AppIconButton({
    super.key,
    required this.icon,
    required this.onPressed,
    required this.tooltip,
    this.isLoading = false,
    this.isActive = false,
  });

  final IconData icon;
  final VoidCallback? onPressed;
  final String tooltip;
  final bool isLoading;
  final bool isActive;

  @override
  Widget build(BuildContext context) {
    final palette = context.palette;

    return IconButton(
      onPressed: isLoading ? null : onPressed,
      tooltip: tooltip,
      style: IconButton.styleFrom(
        backgroundColor: isActive ? palette.primarySoft : palette.surface,
        foregroundColor: isActive ? palette.primary : palette.textSecondary,
        side: BorderSide(
          color: isActive
              ? palette.primary.withValues(alpha: 0.25)
              : palette.border,
        ),
        minimumSize: const Size(44, 44),
      ),
      icon: isLoading
          ? const SizedBox(
              width: 18,
              height: 18,
              child: CircularProgressIndicator(strokeWidth: 2),
            )
          : Icon(icon, size: 20),
    );
  }
}
