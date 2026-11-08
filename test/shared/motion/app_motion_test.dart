import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hydro_alert/shared/motion/app_animated_entrance.dart';
import 'package:hydro_alert/shared/motion/app_motion.dart';

void main() {
  group('AppMotion', () {
    test('stagger delay grows and is capped', () {
      expect(AppMotion.delayFor(0), Duration.zero);
      expect(AppMotion.delayFor(3), AppMotion.stagger * 3);
      expect(
        AppMotion.delayFor(AppMotion.maxStaggerOrder + 5),
        AppMotion.stagger * AppMotion.maxStaggerOrder,
      );
    });
  });

  group('AppAnimatedEntrance', () {
    testWidgets('animates when motion is enabled', (tester) async {
      await tester.pumpWidget(
        const Directionality(
          textDirection: TextDirection.ltr,
          child: AppAnimatedEntrance(child: Text('contenido')),
        ),
      );

      expect(find.byType(Animate), findsOneWidget);
      expect(find.text('contenido'), findsOneWidget);

      await tester.pumpAndSettle();
    });

    testWidgets('renders static content when animations are disabled', (
      tester,
    ) async {
      await tester.pumpWidget(
        const MediaQuery(
          data: MediaQueryData(disableAnimations: true),
          child: Directionality(
            textDirection: TextDirection.ltr,
            child: AppAnimatedEntrance(child: Text('contenido')),
          ),
        ),
      );

      expect(find.byType(Animate), findsNothing);
      expect(find.text('contenido'), findsOneWidget);
    });
  });
}
