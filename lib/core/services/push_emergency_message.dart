class PushEmergencyMessage {
  const PushEmergencyMessage({
    required this.id,
    required this.title,
    required this.body,
    required this.receivedAt,
    this.magnitude,
    this.place,
    this.latitude,
    this.longitude,
    this.externalUrl,
  });

  final String id;
  final String title;
  final String body;
  final DateTime receivedAt;
  final double? magnitude;
  final String? place;
  final double? latitude;
  final double? longitude;
  final String? externalUrl;
}
