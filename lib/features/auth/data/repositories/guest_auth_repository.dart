import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../domain/entities/app_user.dart';
import '../../domain/repositories/auth_repository.dart';

/// Guest-first implementation. Real authentication can replace this
/// repository without changing the presentation layer.
class GuestAuthRepository implements AuthRepository {
  AppUser? _currentUser;

  @override
  Future<AppUser?> currentUser() async => _currentUser;

  @override
  Future<AppUser> signInAsGuest() async {
    final user = AppUser(
      id: 'guest-${DateTime.now().millisecondsSinceEpoch}',
      displayName: 'Invitado',
    );
    _currentUser = user;
    return user;
  }

  @override
  Future<void> signOut() async {
    _currentUser = null;
  }
}

final authRepositoryProvider = Provider<AuthRepository>((ref) {
  return GuestAuthRepository();
});
