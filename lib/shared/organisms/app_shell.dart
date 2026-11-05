import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

import '../../app/theme/app_colors.dart';

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
                icon: Icon(LucideIcons.house),
                label: 'Inicio',
              ),
              NavigationDestination(icon: Icon(LucideIcons.map), label: 'Mapa'),
              NavigationDestination(
                icon: Icon(LucideIcons.clipboardList),
                label: 'Reportes',
              ),
              NavigationDestination(
                icon: Icon(LucideIcons.bell),
                label: 'Alertas',
              ),
              NavigationDestination(
                icon: Icon(LucideIcons.siren),
                label: 'Emergencia',
              ),
            ],
          ),
        ),
      ),
    );
  }
}
