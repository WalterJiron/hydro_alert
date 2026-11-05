import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

import '../../../../app/config/app_config.dart';
import '../../../../app/theme/app_colors.dart';
import '../../../../app/theme/app_typography.dart';
import '../../../../shared/atoms/custom_button.dart';
import '../../../../shared/molecules/app_card.dart';
import '../../../../shared/molecules/info_banner.dart';
import '../../../../shared/molecules/section_header.dart';

class EmergencyCenterView extends StatelessWidget {
  const EmergencyCenterView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Emergencia')),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(16, 8, 16, 28),
        children: [
          const InfoBanner(
            icon: LucideIcons.shieldAlert,
            tone: InfoBannerTone.danger,
            title: 'SOS visual',
            message:
                'Esta pantalla no envía alertas, no comparte tu ubicación y no '
                'llama a nadie. Muestra instrucciones para actuar con calma.',
          ),
          const SizedBox(height: 16),
          _SosCard(
            onTap: () => showGeneralDialog<void>(
              context: context,
              barrierDismissible: false,
              barrierLabel: 'Modo emergencia',
              barrierColor: Colors.black,
              pageBuilder: (dialogContext, animation, secondaryAnimation) {
                return const _SosOverlay();
              },
            ),
          ),
          const SizedBox(height: 24),
          const SectionHeader(
            title: 'Durante un sismo',
            subtitle: 'Pasos simples para protegerte',
          ),
          const SizedBox(height: 10),
          const _SafetyCard(
            icon: LucideIcons.handHeart,
            steps: [
              'Agáchate, cúbrete y sujétate de algo firme.',
              'Aléjate de ventanas, espejos y objetos que puedan caer.',
              'No uses ascensores ni corras hacia la salida.',
              'Si estás afuera, busca un espacio abierto lejos de edificios y cables.',
            ],
          ),
          const SizedBox(height: 24),
          const SectionHeader(
            title: 'Después del sismo',
            subtitle: 'Revisa y comunica sin ponerte en riesgo',
          ),
          const SizedBox(height: 10),
          const _SafetyCard(
            icon: LucideIcons.shieldCheck,
            steps: [
              'Revisa si tú o alguien cerca necesita ayuda inmediata.',
              'Evita edificios dañados y reporta peligros a las autoridades.',
              'Si puedes, comparte tu estado con familiares por los canales que uses normalmente.',
              'Sigue la información oficial de SINAPRED y los cuerpos de emergencia.',
            ],
          ),
          const SizedBox(height: 24),
          const SectionHeader(
            title: 'Kit de emergencia',
            subtitle: 'Ten estos elementos a la mano',
          ),
          const SizedBox(height: 10),
          const _KitCard(),
          const SizedBox(height: 24),
          SectionHeader(
            title: 'Reportar daños',
            subtitle: 'Comparte lo que observas con la comunidad',
          ),
          const SizedBox(height: 10),
          AppCard(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Si es seguro hacerlo, documenta la situación. Tu reporte se '
                  'mostrará como información comunitaria no verificada.',
                  style: AppTypography.bodyMedium,
                ),
                const SizedBox(height: 12),
                CustomButton(
                  label: AppConfig.hasBackend
                      ? 'Crear reporte de daños'
                      : 'Reportes no configurados',
                  icon: LucideIcons.clipboardList,
                  expand: true,
                  variant: AppButtonVariant.secondary,
                  onPressed: AppConfig.hasBackend
                      ? () => context.push('/reportes/nuevo')
                      : null,
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),
          const InfoBanner(
            icon: LucideIcons.info,
            message:
                'HydroAlert es una herramienta informativa. No reemplaza a las '
                'autoridades ni a los servicios de emergencia.',
          ),
        ],
      ),
    );
  }
}

class _SosCard extends StatelessWidget {
  const _SosCard({required this.onTap});

  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: AppColors.dangerDark,
      borderRadius: BorderRadius.circular(24),
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Row(
            children: [
              Container(
                width: 64,
                height: 64,
                decoration: BoxDecoration(
                  color: Colors.white.withValues(alpha: 0.14),
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  LucideIcons.siren,
                  size: 32,
                  color: Colors.white,
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Activar modo emergencia',
                      style: AppTypography.titleLarge.copyWith(
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(height: 3),
                    Text(
                      'Muestra instrucciones grandes, claras y a pantalla completa.',
                      style: AppTypography.bodySmall.copyWith(
                        color: Colors.white.withValues(alpha: 0.8),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 8),
              const Icon(
                LucideIcons.chevronRight,
                color: Colors.white,
                size: 22,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _SafetyCard extends StatelessWidget {
  const _SafetyCard({required this.icon, required this.steps});

  final IconData icon;
  final List<String> steps;

  @override
  Widget build(BuildContext context) {
    return AppCard(
      child: Column(
        children: [
          for (var index = 0; index < steps.length; index++) ...[
            if (index > 0) const SizedBox(height: 12),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: 24,
                  height: 24,
                  alignment: Alignment.center,
                  decoration: const BoxDecoration(
                    color: AppColors.primarySoft,
                    shape: BoxShape.circle,
                  ),
                  child: Text(
                    '${index + 1}',
                    style: AppTypography.labelSmall.copyWith(
                      color: AppColors.primary,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: Text(steps[index], style: AppTypography.bodyMedium),
                ),
              ],
            ),
          ],
        ],
      ),
    );
  }
}

class _KitCard extends StatelessWidget {
  const _KitCard();

  @override
  Widget build(BuildContext context) {
    const items = [
      (LucideIcons.droplets, 'Agua'),
      (LucideIcons.briefcaseMedical, 'Botiquín'),
      (LucideIcons.flashlight, 'Linterna'),
      (LucideIcons.radio, 'Radio'),
      (LucideIcons.fileText, 'Documentos'),
      (LucideIcons.batteryCharging, 'Batería'),
    ];

    return AppCard(
      child: Wrap(
        spacing: 8,
        runSpacing: 8,
        children: [
          for (final item in items)
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 7),
              decoration: BoxDecoration(
                color: AppColors.surfaceMuted,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(item.$1, size: 15, color: AppColors.textSecondary),
                  const SizedBox(width: 5),
                  Text(item.$2, style: AppTypography.labelSmall),
                ],
              ),
            ),
        ],
      ),
    );
  }
}

class _SosOverlay extends StatefulWidget {
  const _SosOverlay();

  @override
  State<_SosOverlay> createState() => _SosOverlayState();
}

class _SosOverlayState extends State<_SosOverlay>
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
                Text(
                  'MODO\nEMERGENCIA',
                  textAlign: TextAlign.center,
                  style: AppTypography.displayLarge.copyWith(
                    color: Colors.white,
                    fontSize: 40,
                    height: 1.05,
                    letterSpacing: 1.5,
                  ),
                ),
                const SizedBox(height: 10),
                Text(
                  'Mantén la calma. Sigue estos pasos.',
                  textAlign: TextAlign.center,
                  style: AppTypography.bodyLarge.copyWith(
                    color: Colors.white.withValues(alpha: 0.72),
                  ),
                ),
                const SizedBox(height: 24),
                Container(
                  padding: const EdgeInsets.all(18),
                  decoration: BoxDecoration(
                    color: Colors.white.withValues(alpha: 0.06),
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(
                      color: Colors.white.withValues(alpha: 0.12),
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: const [
                      _SosStep(
                        number: '1',
                        text: 'Agáchate, cúbrete y sujétate de algo firme.',
                      ),
                      SizedBox(height: 14),
                      _SosStep(
                        number: '2',
                        text: 'Aléjate de ventanas y objetos que puedan caer.',
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
                const SizedBox(height: 20),
                Text(
                  'Esta pantalla no envía alertas, no comparte tu ubicación y no '
                  'llama a nadie.',
                  textAlign: TextAlign.center,
                  style: AppTypography.bodySmall.copyWith(
                    color: Colors.white.withValues(alpha: 0.6),
                  ),
                ),
                const SizedBox(height: 24),
                SizedBox(
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
                const SizedBox(height: 8),
                TextButton(
                  onPressed: () => Navigator.of(context).pop(),
                  style: TextButton.styleFrom(
                    foregroundColor: Colors.white.withValues(alpha: 0.7),
                  ),
                  child: const Text('Cerrar'),
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
