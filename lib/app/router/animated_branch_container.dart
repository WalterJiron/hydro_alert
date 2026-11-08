import 'package:flutter/material.dart';

import '../../shared/motion/app_motion.dart';

/// Cross-fades and slides between the branch Navigators of a stateful shell.
///
/// Every branch stays mounted so its scroll position, controllers and state are
/// preserved. Only the incoming and outgoing branches are painted while the
/// transition runs; the rest stay offstage.
class AnimatedBranchContainer extends StatefulWidget {
  const AnimatedBranchContainer({
    super.key,
    required this.currentIndex,
    required this.children,
  });

  final int currentIndex;
  final List<Widget> children;

  @override
  State<AnimatedBranchContainer> createState() =>
      _AnimatedBranchContainerState();
}

class _AnimatedBranchContainerState extends State<AnimatedBranchContainer>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _animation;

  int? _previousIndex;
  int _direction = 1;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: AppMotion.standard,
      value: 1,
    );
    _animation = CurvedAnimation(
      parent: _controller,
      curve: AppMotion.emphasizedCurve,
    );
  }

  @override
  void didUpdateWidget(covariant AnimatedBranchContainer oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.currentIndex == widget.currentIndex) {
      return;
    }

    _previousIndex = oldWidget.currentIndex;
    _direction = widget.currentIndex > oldWidget.currentIndex ? 1 : -1;
    _controller.forward(from: 0);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (AppMotion.isReduced(context) || widget.children.length < 2) {
      return IndexedStack(
        index: widget.currentIndex,
        children: widget.children,
      );
    }

    return AnimatedBuilder(
      animation: _animation,
      builder: (context, _) {
        final progress = _animation.value;
        final isTransitioning =
            _controller.isAnimating && _previousIndex != null;

        return Stack(
          fit: StackFit.expand,
          children: [
            for (var index = 0; index < widget.children.length; index++)
              _buildBranch(
                index: index,
                progress: progress,
                isTransitioning: isTransitioning,
              ),
          ],
        );
      },
    );
  }

  Widget _buildBranch({
    required int index,
    required double progress,
    required bool isTransitioning,
  }) {
    final isCurrent = index == widget.currentIndex;
    final isPrevious = isTransitioning && index == _previousIndex;

    if (!isCurrent && !isPrevious) {
      return Offstage(
        offstage: true,
        child: TickerMode(enabled: false, child: widget.children[index]),
      );
    }

    final opacity = isCurrent ? progress : 1 - progress;
    final horizontalShift = isCurrent
        ? _direction * (1 - progress) * 0.05
        : -_direction * progress * 0.03;

    return IgnorePointer(
      ignoring: !isCurrent,
      child: Opacity(
        opacity: opacity.clamp(0.0, 1.0),
        child: FractionalTranslation(
          translation: Offset(horizontalShift, 0),
          child: widget.children[index],
        ),
      ),
    );
  }
}
