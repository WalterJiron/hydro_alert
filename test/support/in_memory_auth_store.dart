import 'package:hydro_alert/features/auth/data/datasources/auth_local_store.dart';
import 'package:hydro_alert/features/auth/domain/entities/auth_session.dart';

/// Hand-written local store so widget tests never touch platform channels.
class InMemoryAuthStore implements AuthLocalStore {
  InMemoryAuthStore([this._session]);

  AuthSession? _session;

  @override
  Future<AuthSession?> read() async => _session;

  @override
  Future<void> write(AuthSession session) async {
    _session = session;
  }

  @override
  Future<void> clear() async {
    _session = null;
  }
}
