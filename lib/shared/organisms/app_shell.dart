import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

import '../../app/theme/app_colors.dart';
import '../motion/app_motion.dart';

/// Persistent shell with the five primary destinations.
class AppShell extends StatelessWidget {
  const AppShell({super.key, required this.navigationShell});

  final StatefulNavigationShell navigationShell;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: navigationShell,
      bottomNavigationBar: DecoratedBox(
        decoration: const BoxDecoration(
          border: Border(top: BorderSide(color: AppColors.border)),
        ),
        child: SafeArea(
          top: false,
          child: NavigationBar(
            selectedIndex: navigationShell.currentIndex,
            onDestinationSelected: (index) {
              navigationShell.goBranch(
                index,
                initialLocation: index == navigationShell.currentIndex,
              );
            },
            destinations: const [
              NavigationDestination(
                icon: _NavIcon(icon: LucideIcons.house),
                selectedIcon: _NavIcon(icon: LucideIcons.house, selected: true),
                label: 'Inicio',
              ),
              NavigationDestination(
                icon: _NavIcon(icon: LucideIcons.map),
                selectedIcon: _NavIcon(icon: LucideIcons.map, selected: true),
                label: 'Mapa',
              ),
              NavigationDestination(
                icon: _NavIcon(icon: LucideIcons.clipboardList),
                selectedIcon: _NavIcon(
                  icon: LucideIcons.clipboardList,
                  selected: true,
                ),
                label: 'Reportes',
              ),
              NavigationDestination(
                icon: _NavIcon(icon: LucideIcons.bell),
                selectedIcon: _NavIcon(icon: LucideIcons.bell, selected: true),
                label: 'Alertas',
              ),
              NavigationDestination(
                icon: _NavIcon(icon: LucideIcons.siren),
                selectedIcon: _NavIcon(icon: LucideIcons.siren, selected: true),
                label: 'Emergencia',
              ),
            ],
          ),
        ),
      ),
    );
  }
}

/// Slightly grows the selected destination while the bar cross-fades it.
class _NavIcon extends StatelessWidget {
  const _NavIcon({required this.icon, this.selected = false});

  final IconData icon;
  final bool selected;

  @override
  Widget build(BuildContext context) {
    return AnimatedScale(
      scale: selected && !AppMotion.isReduced(context) ? 1.12 : 1,
      duration: AppMotion.quick,
      curve: AppMotion.curve,
      child: Icon(icon),
    );
  }
}
