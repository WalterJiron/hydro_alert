import '../entities/app_user.dart';

abstract interface class AuthRepository {
  Future<AppUser> signInAsGuest();

  Future<AppUser?> currentUser();

  Future<void> signOut();
}
