import '../entities/auth_session.dart';

abstract interface class AuthRepository {
  Future<AuthSession?> currentSession();

  Future<String?> currentToken();

  Future<AuthSession> signInAsGuest();

  Future<AuthSession> register({
    required String name,
    required String email,
    required String password,
    required String cedula,
  });

  Future<AuthSession> login({required String email, required String password});

  Future<void> signOut();
}
