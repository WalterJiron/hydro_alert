import 'package:flutter/material.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

import '../../../../app/theme/app_colors.dart';
import '../../../../app/theme/app_typography.dart';
import '../../../../shared/motion/app_animated_entrance.dart';

/// Full-screen, animated SOS guidance. Purely visual: it never calls, shares
/// the location or dispatches help.
class SosOverlay extends StatefulWidget {
  const SosOverlay({super.key});

  @override
  State<SosOverlay> createState() => _SosOverlayState();
}

class _SosOverlayState extends State<SosOverlay>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _pulse;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 900),
    )..repeat(reverse: true);
    _pulse = Tween<double>(
      begin: 0.94,
      end: 1.06,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOut));
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      color: const Color(0xFF0B0F19),
      child: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(24),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                ScaleTransition(
                  scale: _pulse,
                  child: Container(
                    width: 120,
                    height: 120,
                    decoration: BoxDecoration(
                      color: AppColors.danger.withValues(alpha: 0.18),
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                          color: AppColors.danger.withValues(alpha: 0.35),
                          blurRadius: 40,
                          spreadRadius: 10,
                        ),
                      ],
                    ),
                    child: const Icon(
                      LucideIcons.siren,
                      size: 58,
                      color: AppColors.danger,
                    ),
                  ),
                ),
                const SizedBox(height: 28),
                AppAnimatedEntrance(
                  order: 0,
                  child: Text(
                    'MODO\nEMERGENCIA',
                    textAlign: TextAlign.center,
                    style: AppTypography.displayLarge.copyWith(
                      color: Colors.white,
                      fontSize: 40,
                      height: 1.05,
                      letterSpacing: 1.5,
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                AppAnimatedEntrance(
                  order: 1,
                  child: Text(
                    'Mantén la calma. Sigue estos pasos.',
                    textAlign: TextAlign.center,
                    style: AppTypography.bodyLarge.copyWith(
                      color: Colors.white.withValues(alpha: 0.72),
                    ),
                  ),
                ),
                const SizedBox(height: 24),
                AppAnimatedEntrance(
                  order: 2,
                  child: Container(
                    padding: const EdgeInsets.all(18),
                    decoration: BoxDecoration(
                      color: Colors.white.withValues(alpha: 0.06),
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(
                        color: Colors.white.withValues(alpha: 0.12),
                      ),
                    ),
                    child: const Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _SosStep(
                          number: '1',
                          text: 'Agáchate, cúbrete y sujétate de algo firme.',
                        ),
                        SizedBox(height: 14),
                        _SosStep(
                          number: '2',
                          text:
                              'Aléjate de ventanas y objetos que puedan caer.',
                        ),
                        SizedBox(height: 14),
                        _SosStep(
                          number: '3',
                          text:
                              'No uses ascensores. Cuando termine el movimiento, sal con calma.',
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                AppAnimatedEntrance(
                  order: 3,
                  child: Text(
                    'Esta pantalla no envía alertas, no comparte tu ubicación y no '
                    'llama a nadie.',
                    textAlign: TextAlign.center,
                    style: AppTypography.bodySmall.copyWith(
                      color: Colors.white.withValues(alpha: 0.6),
                    ),
                  ),
                ),
                const SizedBox(height: 24),
                AppAnimatedEntrance(
                  order: 4,
                  child: SizedBox(
                    width: double.infinity,
                    child: FilledButton(
                      onPressed: () => Navigator.of(context).pop(),
                      style: FilledButton.styleFrom(
                        backgroundColor: Colors.white,
                        foregroundColor: const Color(0xFF0B0F19),
                        minimumSize: const Size(48, 56),
                      ),
                      child: const Text('Estoy a salvo'),
                    ),
                  ),
                ),
                const SizedBox(height: 8),
                AppAnimatedEntrance(
                  order: 5,
                  child: TextButton(
                    onPressed: () => Navigator.of(context).pop(),
                    style: TextButton.styleFrom(
                      foregroundColor: Colors.white.withValues(alpha: 0.7),
                    ),
                    child: const Text('Cerrar'),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _SosStep extends StatelessWidget {
  const _SosStep({required this.number, required this.text});

  final String number;
  final String text;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: 26,
          height: 26,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: AppColors.danger.withValues(alpha: 0.2),
            shape: BoxShape.circle,
          ),
          child: Text(
            number,
            style: AppTypography.labelSmall.copyWith(
              color: AppColors.danger,
              fontWeight: FontWeight.w800,
            ),
          ),
        ),
        const SizedBox(width: 10),
        Expanded(
          child: Text(
            text,
            style: AppTypography.bodyMedium.copyWith(
              color: Colors.white.withValues(alpha: 0.85),
            ),
          ),
        ),
      ],
    );
  }
}
