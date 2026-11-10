class AppUser {
  const AppUser({
    required this.id,
    required this.displayName,
    this.email,
    this.isGuest = true,
  });

  final String id;
  final String displayName;
  final String? email;
  final bool isGuest;
}
