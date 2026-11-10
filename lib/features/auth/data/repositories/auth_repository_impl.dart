import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/network/network_providers.dart';
import '../../domain/entities/auth_session.dart';
import '../../domain/repositories/auth_repository.dart';
import '../datasources/auth_local_store.dart';
import '../datasources/auth_remote_datasource.dart';

class AuthRepositoryImpl implements AuthRepository {
  AuthRepositoryImpl(this._remoteDataSource, this._localStore);

  final AuthRemoteDataSource _remoteDataSource;
  final AuthLocalStore _localStore;

  AuthSession? _cachedSession;
  AuthSession? _guestSession;
  bool _loaded = false;

  @override
  Future<AuthSession?> currentSession() async {
    if (_loaded) {
      return _cachedSession;
    }

    _loaded = true;
    _cachedSession = await _localStore.read();
    return _cachedSession;
  }

  @override
  Future<String?> currentToken() async {
    final session = await currentSession();
    return session?.isAuthenticated == true ? session!.token : null;
  }

  @override
  Future<AuthSession> signInAsGuest() async {
    final existing = await currentSession();
    if (existing != null && existing.isAuthenticated) {
      return existing;
    }

    final guest = _guestSession ?? const AuthSession.guest();
    _guestSession = guest;
    _cachedSession = guest;
    return guest;
  }

  @override
  Future<AuthSession> register({
    required String name,
    required String email,
    required String password,
    required String cedula,
  }) async {
    final session = await _remoteDataSource.register(
      name: name,
      email: email,
      password: password,
      cedula: cedula,
    );
    await _persist(session);
    return session;
  }

  @override
  Future<AuthSession> login({
    required String email,
    required String password,
  }) async {
    final session = await _remoteDataSource.login(
      email: email,
      password: password,
    );
    await _persist(session);
    return session;
  }

  @override
  Future<void> signOut() async {
    _cachedSession = null;
    _guestSession = null;
    _loaded = true;
    await _localStore.clear();
  }

  Future<void> _persist(AuthSession session) async {
    _cachedSession = session;
    _loaded = true;
    await _localStore.write(session);
  }
}

final authLocalStoreProvider = Provider<AuthLocalStore>((ref) {
  return const SharedPreferencesAuthStore();
});

final authRepositoryProvider = Provider<AuthRepository>((ref) {
  return AuthRepositoryImpl(
    AuthRemoteDataSource(ref.watch(backendDioProvider)),
    ref.watch(authLocalStoreProvider),
  );
});
