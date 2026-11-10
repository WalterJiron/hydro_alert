import 'app_user.dart';

/// A signed-in reporter account plus the opaque bearer token used by the
/// backend. Guest sessions have no token and never authorize writes.
class AuthSession {
  const AuthSession({required this.user, this.token});

  const AuthSession.guest()
    : user = const AppUser(id: 'guest', displayName: 'Invitado'),
      token = null;

  final AppUser user;
  final String? token;

  bool get isAuthenticated =>
      !user.isGuest && (token?.trim().isNotEmpty ?? false);

  bool get isGuest => !isAuthenticated;
}
