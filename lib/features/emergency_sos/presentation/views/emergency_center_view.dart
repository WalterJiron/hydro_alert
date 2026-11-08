import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

import '../../../../shared/molecules/info_banner.dart';
import '../../../../shared/molecules/section_header.dart';
import '../../../../shared/motion/app_animated_entrance.dart';
import '../widgets/emergency_damage_report_card.dart';
import '../widgets/emergency_kit_card.dart';
import '../widgets/safety_steps_card.dart';
import '../widgets/sos_mode_card.dart';
import '../widgets/sos_overlay.dart';

class EmergencyCenterView extends StatelessWidget {
  const EmergencyCenterView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Emergencia')),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(16, 8, 16, 28),
        children: [
          const AppAnimatedEntrance(
            order: 0,
            child: InfoBanner(
              icon: LucideIcons.shieldAlert,
              tone: InfoBannerTone.danger,
              title: 'SOS visual',
              message:
                  'Esta pantalla no envía alertas, no comparte tu ubicación y no '
                  'llama a nadie. Muestra instrucciones para actuar con calma.',
            ),
          ),
          const SizedBox(height: 16),
          AppAnimatedEntrance(
            order: 1,
            child: SosModeCard(
              onTap: () => showGeneralDialog<void>(
                context: context,
                barrierDismissible: false,
                barrierLabel: 'Modo emergencia',
                barrierColor: Colors.black,
                pageBuilder: (dialogContext, animation, secondaryAnimation) {
                  return const SosOverlay();
                },
              ),
            ),
          ),
          const SizedBox(height: 24),
          const AppAnimatedEntrance(
            order: 2,
            child: SectionHeader(
              title: 'Durante un sismo',
              subtitle: 'Pasos simples para protegerte',
            ),
          ),
          const SizedBox(height: 10),
          const AppAnimatedEntrance(
            order: 3,
            child: SafetyStepsCard(
              steps: [
                'Agáchate, cúbrete y sujétate de algo firme.',
                'Aléjate de ventanas, espejos y objetos que puedan caer.',
                'No uses ascensores ni corras hacia la salida.',
                'Si estás afuera, busca un espacio abierto lejos de edificios y cables.',
              ],
            ),
          ),
          const SizedBox(height: 24),
          const AppAnimatedEntrance(
            order: 4,
            child: SectionHeader(
              title: 'Después del sismo',
              subtitle: 'Revisa y comunica sin ponerte en riesgo',
            ),
          ),
          const SizedBox(height: 10),
          const AppAnimatedEntrance(
            order: 5,
            child: SafetyStepsCard(
              steps: [
                'Revisa si tú o alguien cerca necesita ayuda inmediata.',
                'Evita edificios dañados y reporta peligros a las autoridades.',
                'Si puedes, comparte tu estado con familiares por los canales que uses normalmente.',
                'Sigue la información oficial de SINAPRED y los cuerpos de emergencia.',
              ],
            ),
          ),
          const SizedBox(height: 24),
          const AppAnimatedEntrance(
            order: 6,
            child: SectionHeader(
              title: 'Kit de emergencia',
              subtitle: 'Ten estos elementos a la mano',
            ),
          ),
          const SizedBox(height: 10),
          const AppAnimatedEntrance(order: 7, child: EmergencyKitCard()),
          const SizedBox(height: 24),
          const AppAnimatedEntrance(
            order: 8,
            child: SectionHeader(
              title: 'Reportar daños',
              subtitle: 'Comparte lo que observas con la comunidad',
            ),
          ),
          const SizedBox(height: 10),
          AppAnimatedEntrance(
            order: 8,
            child: EmergencyDamageReportCard(
              onCreateReport: () => context.push('/reportes/nuevo'),
            ),
          ),
          const SizedBox(height: 20),
          const AppAnimatedEntrance(
            order: 8,
            child: InfoBanner(
              icon: LucideIcons.info,
              message:
                  'HydroAlert es una herramienta informativa. No reemplaza a las '
                  'autoridades ni a los servicios de emergencia.',
            ),
          ),
        ],
      ),
    );
  }
}
