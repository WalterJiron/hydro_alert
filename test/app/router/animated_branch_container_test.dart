import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hydro_alert/app/router/animated_branch_container.dart';

Widget _buildHarness(ValueNotifier<int> index, {bool reduceMotion = false}) {
  return MaterialApp(
    home: MediaQuery(
      data: MediaQueryData(
        disableAnimations: reduceMotion,
        size: const Size(800, 600),
      ),
      child: ValueListenableBuilder<int>(
        valueListenable: index,
        builder: (context, value, _) {
          return AnimatedBranchContainer(
            currentIndex: value,
            children: const [Text('rama uno'), Text('rama dos')],
          );
        },
      ),
    ),
  );
}

void main() {
  testWidgets('keeps the previous branch painted during the transition', (
    tester,
  ) async {
    final index = ValueNotifier<int>(0);
    addTearDown(index.dispose);

    await tester.pumpWidget(_buildHarness(index));

    expect(find.text('rama uno'), findsOneWidget);
    expect(find.text('rama dos'), findsNothing);

    index.value = 1;
    await tester.pump();

    expect(find.text('rama uno'), findsOneWidget);
    expect(find.text('rama dos'), findsOneWidget);

    await tester.pumpAndSettle();

    expect(find.text('rama uno'), findsNothing);
    expect(find.text('rama dos'), findsOneWidget);
  });

  testWidgets('switches instantly when animations are disabled', (
    tester,
  ) async {
    final index = ValueNotifier<int>(0);
    addTearDown(index.dispose);

    await tester.pumpWidget(_buildHarness(index, reduceMotion: true));

    index.value = 1;
    await tester.pump();

    expect(find.text('rama uno'), findsNothing);
    expect(find.text('rama dos'), findsOneWidget);
  });
}
