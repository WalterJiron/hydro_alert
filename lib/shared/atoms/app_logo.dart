import 'package:flutter/material.dart';

import '../../app/config/app_config.dart';
import '../../app/theme/app_colors.dart';
import '../../app/theme/app_typography.dart';

/// Brand lockup. Uses the generated mark so no text is baked into the asset.
class AppLogo extends StatelessWidget {
  const AppLogo({
    super.key,
    this.size = 36,
    this.showWordmark = false,
    this.showTagline = false,
  });

  final double size;
  final bool showWordmark;
  final bool showTagline;

  @override
  Widget build(BuildContext context) {
    final mark = Image.asset(
      'assets/images/logo_mark.png',
      width: size,
      height: size,
      fit: BoxFit.contain,
      semanticLabel: 'Logotipo de ${AppConfig.appName}',
    );

    if (!showWordmark) {
      return mark;
    }

    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        mark,
        const SizedBox(width: 10),
        Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              AppConfig.appName,
              style: AppTypography.titleLarge.copyWith(letterSpacing: -0.4),
            ),
            if (showTagline)
              Text(
                AppConfig.appTagline,
                style: AppTypography.bodySmall.copyWith(
                  color: AppColors.textMuted,
                ),
              ),
          ],
        ),
      ],
    );
  }
}
