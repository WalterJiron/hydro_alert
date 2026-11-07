/// Returns the greeting that matches [hour] in 24-hour format.
String greetingForHour(int hour) {
  if (hour < 12) {
    return 'Buenos días';
  }
  if (hour < 18) {
    return 'Buenas tardes';
  }
  return 'Buenas noches';
}
