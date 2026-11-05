import 'package:intl/intl.dart';

/// Spanish date and time formatting used across the app.
class DateFormatter {
  const DateFormatter._();

  static String relative(DateTime value, {DateTime? now}) {
    final reference = now ?? DateTime.now();
    final difference = reference.difference(value);

    if (difference.isNegative || difference.inMinutes < 1) {
      return 'Ahora';
    }
    if (difference.inMinutes < 60) {
      return 'hace ${difference.inMinutes} min';
    }
    if (difference.inHours < 24) {
      return 'hace ${difference.inHours} h';
    }
    if (difference.inDays < 7) {
      return 'hace ${difference.inDays} d';
    }

    return DateFormat('d MMM yyyy', 'es').format(value.toLocal());
  }

  static String dateTime(DateTime value) {
    return DateFormat("d 'de' MMMM, HH:mm", 'es').format(value.toLocal());
  }

  static String shortDateTime(DateTime value) {
    return DateFormat('d MMM, HH:mm', 'es').format(value.toLocal());
  }

  static String time(DateTime value) {
    return DateFormat('HH:mm', 'es').format(value.toLocal());
  }

  static String day(DateTime value) {
    final formatted = DateFormat(
      "EEEE d 'de' MMMM",
      'es',
    ).format(value.toLocal());
    return formatted.isEmpty
        ? formatted
        : '${formatted[0].toUpperCase()}${formatted.substring(1)}';
  }

  static String coordinates(double latitude, double longitude) {
    return '${latitude.toStringAsFixed(3)}, ${longitude.toStringAsFixed(3)}';
  }
}
