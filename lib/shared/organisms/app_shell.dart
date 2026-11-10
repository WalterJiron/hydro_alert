import 'dart:math' as math;
import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:go_router/go_router.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

import '../../app/theme/app_colors.dart';
import '../motion/app_motion.dart';

// ---------------------------------------------------------------------------
// Geometry – sunken wave with deeply pronounced downward curve
// ---------------------------------------------------------------------------

/// Height of the white bar body (excluding safe-area).
const double _kBarHeight = 54.0;

/// Radius of the active circle badge (diameter = 42px).
const double _kCircleRadius = 21.0;

/// How many pixels the top of the circle peeks above the flat bar edge.
/// Set to only 7px so the active item stays grounded and doesn't fly into content.
const double _kCircleProtrusion = 7.0;

/// Deeply pronounced downward curve that cradles the lower 83% of the circle.
/// Depth from flat top down to the trough = circle diameter (42) - protrusion (7) = 35px.
const double _kNotchDepth = (_kCircleRadius * 2) - _kCircleProtrusion; // 35.0

/// Half-width of the notch curve (spread across 108px total).
const double _kNotchSpread = 54.0;

/// Upward translation to center the active icon inside the sunken circle:
/// inactive icon center = (protrusion + barHeight / 2) = 7 + 27 = 34.
/// circle center = circleRadius = 21.
/// lift = 34 - 21 = 13.
const double _kIconLift =
    _kCircleProtrusion + (_kBarHeight / 2) - _kCircleRadius; // 13.0

// ---------------------------------------------------------------------------
// Destinations – must match branch order in app_router.dart
// ---------------------------------------------------------------------------

class _Destination {
  const _Destination({required this.icon, required this.label});
  final IconData icon;
  final String label;
}

const List<_Destination> _destinations = [
  _Destination(icon: LucideIcons.house, label: 'Inicio'),
  _Destination(icon: LucideIcons.map, label: 'Mapa'),
  _Destination(icon: LucideIcons.clipboardList, label: 'Reportes'),
  _Destination(icon: LucideIcons.bell, label: 'Alertas'),
  _Destination(icon: LucideIcons.siren, label: 'SOS'),
];

// ---------------------------------------------------------------------------
// AppShell
// ---------------------------------------------------------------------------

class AppShell extends StatelessWidget {
  const AppShell({super.key, required this.navigationShell});

  final StatefulNavigationShell navigationShell;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      body: navigationShell,
      bottomNavigationBar: _WaveNavBar(
        currentIndex: navigationShell.currentIndex,
        onDestinationSelected: (index) {
          HapticFeedback.selectionClick();
          navigationShell.goBranch(
            index,
            initialLocation: index == navigationShell.currentIndex,
          );
        },
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// _WaveNavBar
// ---------------------------------------------------------------------------

class _WaveNavBar extends StatefulWidget {
  const _WaveNavBar({
    required this.currentIndex,
    required this.onDestinationSelected,
  });

  final int currentIndex;
  final ValueChanged<int> onDestinationSelected;

  @override
  State<_WaveNavBar> createState() => _WaveNavBarState();
}

class _WaveNavBarState extends State<_WaveNavBar>
    with SingleTickerProviderStateMixin {
  late final AnimationController _ctrl;
  late final Animation<double> _progress;

  int _previousIndex = 0;

  @override
  void initState() {
    super.initState();
    _previousIndex = widget.currentIndex;
    _ctrl = AnimationController(vsync: this, duration: AppMotion.standard)
      ..value = 1;
    _progress = CurvedAnimation(parent: _ctrl, curve: Curves.easeInOut);
  }

  @override
  void didUpdateWidget(covariant _WaveNavBar oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.currentIndex != widget.currentIndex) {
      _previousIndex = oldWidget.currentIndex;
      _ctrl.forward(from: 0);
    }
  }

  @override
  void dispose() {
    _ctrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final bottomPadding = MediaQuery.paddingOf(context).bottom;

    return SizedBox(
      height: _kBarHeight + _kCircleProtrusion + bottomPadding,
      child: AnimatedBuilder(
        animation: _progress,
        builder: (context, _) => _NavBarContent(
          itemCount: _destinations.length,
          selectedIndex: widget.currentIndex,
          previousIndex: _previousIndex,
          progress: _progress.value,
          bottomPadding: bottomPadding,
          onTap: widget.onDestinationSelected,
        ),
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// _NavBarContent
// ---------------------------------------------------------------------------

class _NavBarContent extends StatelessWidget {
  const _NavBarContent({
    required this.itemCount,
    required this.selectedIndex,
    required this.previousIndex,
    required this.progress,
    required this.bottomPadding,
    required this.onTap,
  });

  final int itemCount;
  final int selectedIndex;
  final int previousIndex;
  final double progress;
  final double bottomPadding;
  final ValueChanged<int> onTap;

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.sizeOf(context).width;
    final slotW = width / itemCount;
    final fromX = (previousIndex + 0.5) * slotW;
    final toX = (selectedIndex + 0.5) * slotW;
    final palette = context.palette;

    final cx = ui.lerpDouble(fromX, toX, Curves.easeInOut.transform(progress))!;

    return Stack(
      clipBehavior: Clip.none,
      children: [
        // ── Layer 1: bar surface with deeply pronounced wave notch ───────
        Positioned(
          left: 0,
          right: 0,
          bottom: 0,
          top: _kCircleProtrusion,
          child: CustomPaint(
            painter: _WaveBarPainter(
              itemCount: itemCount,
              cx: cx,
              surfaceColor: palette.surface,
              borderColor: palette.border,
            ),
          ),
        ),

        // ── Layer 2: sunken floating badge riding the wave ───────────────
        Positioned(
          left: cx - _kCircleRadius,
          top: 0,
          width: _kCircleRadius * 2,
          height: _kCircleRadius * 2,
          child: GestureDetector(
            onTap: () => onTap(selectedIndex),
            behavior: HitTestBehavior.opaque,
            child: const _FloatingBadge(),
          ),
        ),

        // ── Layer 3: icon row with subtle lift ───────────────────────────
        Positioned(
          left: 0,
          right: 0,
          bottom: bottomPadding,
          height: _kBarHeight,
          child: Row(
            children: List.generate(
              itemCount,
              (i) => _NavItem(
                destination: _destinations[i],
                isSelected: i == selectedIndex,
                wasPrevious:
                    i == previousIndex && selectedIndex != previousIndex,
                progress: progress,
                onTap: () => onTap(i),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

// ---------------------------------------------------------------------------
// _FloatingBadge
// ---------------------------------------------------------------------------

class _FloatingBadge extends StatelessWidget {
  const _FloatingBadge();

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        color: context.palette.primaryFill,
        shape: BoxShape.circle,
        boxShadow: [
          BoxShadow(
            color: context.palette.primaryFill.withAlpha(90),
            blurRadius: 10,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: SizedBox.square(dimension: _kCircleRadius * 2),
    );
  }
}

// ---------------------------------------------------------------------------
// _WaveBarPainter
// ---------------------------------------------------------------------------

class _WaveBarPainter extends CustomPainter {
  const _WaveBarPainter({
    required this.itemCount,
    required this.cx,
    required this.surfaceColor,
    required this.borderColor,
  });

  final int itemCount;
  final double cx;
  final Color surfaceColor;
  final Color borderColor;

  @override
  void paint(Canvas canvas, Size size) {
    final path = _buildPath(size, cx);

    // Soft blur shadow on the top wave edge.
    canvas.drawPath(
      path,
      Paint()
        ..color = Colors.black.withValues(alpha: 0.08)
        ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 5),
    );

    // Solid bar surface.
    canvas.drawPath(path, Paint()..color = surfaceColor);

    // Subtle hairline border along the top wave silhouette.
    canvas.drawPath(
      path,
      Paint()
        ..color = borderColor
        ..style = PaintingStyle.stroke
        ..strokeWidth = 1,
    );
  }

  Path _buildPath(Size size, double cx) {
    final path = Path()..moveTo(0, 0);

    const step = 1.5;
    for (double x = 0; x <= size.width; x += step) {
      final dist = (x - cx).abs();
      final y = dist < _kNotchSpread
          ? _kNotchDepth *
                math
                    .pow(math.cos(dist / _kNotchSpread * math.pi / 2), 2)
                    .toDouble()
          : 0.0;
      path.lineTo(x, y);
    }

    return path
      ..lineTo(size.width, size.height)
      ..lineTo(0, size.height)
      ..close();
  }

  @override
  bool shouldRepaint(covariant _WaveBarPainter old) {
    return old.cx != cx ||
        old.surfaceColor != surfaceColor ||
        old.borderColor != borderColor;
  }
}

// ---------------------------------------------------------------------------
// _NavItem
// ---------------------------------------------------------------------------

class _NavItem extends StatelessWidget {
  const _NavItem({
    required this.destination,
    required this.isSelected,
    required this.wasPrevious,
    required this.progress,
    required this.onTap,
  });

  final _Destination destination;
  final bool isSelected;
  final bool wasPrevious;
  final double progress;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final isTransitioning = wasPrevious && progress < 1.0;
    final palette = context.palette;

    final iconColor = isSelected
        ? Colors.white
        : (isTransitioning
              ? Color.lerp(Colors.white, palette.textSecondary, progress)!
              : palette.textSecondary);

    final double verticalShift;
    if (isSelected) {
      verticalShift = ui.lerpDouble(
        0,
        -_kIconLift,
        Curves.easeOutBack.transform(progress),
      )!;
    } else if (isTransitioning) {
      verticalShift = ui.lerpDouble(
        -_kIconLift,
        0,
        Curves.easeIn.transform(progress),
      )!;
    } else {
      verticalShift = 0.0;
    }

    return Expanded(
      child: GestureDetector(
        onTap: onTap,
        behavior: HitTestBehavior.opaque,
        child: Transform.translate(
          offset: Offset(0, verticalShift),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(destination.icon, color: iconColor, size: 21)
                  .animate(
                    key: ValueKey('${destination.label}_$isSelected'),
                    autoPlay: isSelected,
                  )
                  .scaleXY(
                    begin: 0.80,
                    end: 1.0,
                    duration: AppMotion.standard,
                    curve: Curves.easeOutBack,
                  ),
              if (!isSelected && !isTransitioning) ...[
                const SizedBox(height: 3),
                Text(
                  destination.label,
                  style: TextStyle(
                    fontSize: 10,
                    color: palette.textMuted,
                    fontWeight: FontWeight.w500,
                    height: 1.1,
                  ),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}
