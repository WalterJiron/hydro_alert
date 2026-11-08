import 'package:flutter_test/flutter_test.dart';
import 'package:hydro_alert/features/home/presentation/widgets/home_greeting.dart';

void main() {
  group('greetingForHour', () {
    test('greets in the morning before noon', () {
      expect(greetingForHour(0), 'Buenos días');
      expect(greetingForHour(11), 'Buenos días');
    });

    test('greets in the afternoon between noon and 18', () {
      expect(greetingForHour(12), 'Buenas tardes');
      expect(greetingForHour(17), 'Buenas tardes');
    });

    test('greets at night from 18 onwards', () {
      expect(greetingForHour(18), 'Buenas noches');
      expect(greetingForHour(23), 'Buenas noches');
    });
  });
}
