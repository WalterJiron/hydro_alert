import 'package:flutter/material.dart';

import '../../app/theme/app_colors.dart';
import '../../app/theme/app_typography.dart';
import '../atoms/custom_button.dart';

class LoadingState extends StatelessWidget {
  const LoadingState({
    super.key,
    this.message = 'Cargando información…',
    this.compact = false,
  });

  final String message;
  final bool compact;

  @override
  Widget build(BuildContext context) {
    final content = Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        const SizedBox(
          width: 28,
          height: 28,
          child: CircularProgressIndicator(strokeWidth: 2.6),
        ),
        const SizedBox(height: 14),
        Text(
          message,
          textAlign: TextAlign.center,
          style: AppTypography.bodySmall,
        ),
      ],
    );

    if (compact) {
      return Padding(
        padding: const EdgeInsets.symmetric(vertical: 16),
        child: content,
      );
    }

    return Center(
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(32),
        child: content,
      ),
    );
  }
}

class ErrorState extends StatelessWidget {
  const ErrorState({
    super.key,
    required this.message,
    this.title = 'No pudimos cargar la información',
    this.onRetry,
  });

  final String message;
  final String title;
  final VoidCallback? onRetry;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(32),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            _IconCircle(
              icon: Icons.cloud_off_rounded,
              color: AppColors.danger,
              background: AppColors.dangerSoft,
            ),
            const SizedBox(height: 18),
            Text(
              title,
              textAlign: TextAlign.center,
              style: AppTypography.titleMedium,
            ),
            const SizedBox(height: 6),
            Text(
              message,
              textAlign: TextAlign.center,
              style: AppTypography.bodyMedium.copyWith(
                color: AppColors.textMuted,
              ),
            ),
            if (onRetry != null) ...[
              const SizedBox(height: 20),
              CustomButton(
                label: 'Reintentar',
                icon: Icons.refresh_rounded,
                onPressed: onRetry,
                variant: AppButtonVariant.secondary,
              ),
            ],
          ],
        ),
      ),
    );
  }
}

class EmptyState extends StatelessWidget {
  const EmptyState({
    super.key,
    required this.icon,
    required this.title,
    required this.message,
    this.actionLabel,
    this.onAction,
  });

  final IconData icon;
  final String title;
  final String message;
  final String? actionLabel;
  final VoidCallback? onAction;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(32),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            _IconCircle(
              icon: icon,
              color: AppColors.primary,
              background: AppColors.primarySoft,
            ),
            const SizedBox(height: 18),
            Text(
              title,
              textAlign: TextAlign.center,
              style: AppTypography.titleMedium,
            ),
            const SizedBox(height: 6),
            Text(
              message,
              textAlign: TextAlign.center,
              style: AppTypography.bodyMedium.copyWith(
                color: AppColors.textMuted,
              ),
            ),
            if (actionLabel != null && onAction != null) ...[
              const SizedBox(height: 20),
              CustomButton(
                label: actionLabel!,
                onPressed: onAction,
                variant: AppButtonVariant.secondary,
              ),
            ],
          ],
        ),
      ),
    );
  }
}

class _IconCircle extends StatelessWidget {
  const _IconCircle({
    required this.icon,
    required this.color,
    required this.background,
  });

  final IconData icon;
  final Color color;
  final Color background;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 64,
      height: 64,
      decoration: BoxDecoration(color: background, shape: BoxShape.circle),
      child: Icon(icon, size: 30, color: color),
    );
  }
}
