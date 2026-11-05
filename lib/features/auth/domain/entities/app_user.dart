class AppUser {
  const AppUser({
    required this.id,
    required this.displayName,
    this.isGuest = true,
  });

  final String id;
  final String displayName;
  final bool isGuest;
}
