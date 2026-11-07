import 'package:flutter_test/flutter_test.dart';
import 'package:hydro_alert/core/utils/date_formatter.dart';
import 'package:intl/date_symbol_data_local.dart';

void main() {
  setUpAll(() async {
    await initializeDateFormatting('es');
  });

  test('day formats a Spanish date with capitalised weekday', () {
    expect(
      DateFormatter.day(DateTime(2026, 11, 4)),
      'Miércoles 4 de noviembre',
    );
  });

  test('relative keeps short labels for recent events', () {
    final now = DateTime(2026, 11, 4, 12);

    expect(
      DateFormatter.relative(
        now.subtract(const Duration(minutes: 5)),
        now: now,
      ),
      'hace 5 min',
    );
    expect(
      DateFormatter.relative(now.subtract(const Duration(hours: 3)), now: now),
      'hace 3 h',
    );
    expect(DateFormatter.relative(now, now: now), 'Ahora');
  });

  test('coordinates use three decimals', () {
    expect(DateFormatter.coordinates(12.136389, -86.251389), '12.136, -86.251');
  });
}
