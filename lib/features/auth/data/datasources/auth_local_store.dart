import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

import '../../domain/entities/app_user.dart';
import '../../domain/entities/auth_session.dart';

/// Persists the opaque bearer token locally so the user does not have to sign
/// in again every time the app starts.
abstract interface class AuthLocalStore {
  Future<AuthSession?> read();

  Future<void> write(AuthSession session);

  Future<void> clear();
}

class SharedPreferencesAuthStore implements AuthLocalStore {
  const SharedPreferencesAuthStore();

  static const String _sessionKey = 'hydroalert.auth.session.v1';

  /// Browsing must never wait on local storage. A slow or unavailable plugin
  /// falls back to a signed-out session instead of blocking the app.
  static const Duration _timeout = Duration(seconds: 2);

  @override
  Future<AuthSession?> read() async {
    try {
      final preferences = await SharedPreferences.getInstance().timeout(
        _timeout,
      );
      final raw = preferences.getString(_sessionKey);
      if (raw == null || raw.isEmpty) {
        return null;
      }
      return _decode(raw);
    } catch (_) {
      // Storage is a convenience, never a requirement for browsing.
      return null;
    }
  }

  @override
  Future<void> write(AuthSession session) async {
    if (!session.isAuthenticated) {
      return;
    }
    try {
      final preferences = await SharedPreferences.getInstance().timeout(
        _timeout,
      );
      await preferences
          .setString(_sessionKey, _encode(session))
          .timeout(_timeout);
    } catch (_) {
      // A failed write only means the session is not restored next launch.
    }
  }

  @override
  Future<void> clear() async {
    try {
      final preferences = await SharedPreferences.getInstance().timeout(
        _timeout,
      );
      await preferences.remove(_sessionKey).timeout(_timeout);
    } catch (_) {
      // Nothing else to do if local storage is unavailable.
    }
  }

  String _encode(AuthSession session) {
    return jsonEncode(<String, dynamic>{
      'token': session.token,
      'user': <String, dynamic>{
        'id': session.user.id,
        'name': session.user.displayName,
        'email': session.user.email,
      },
    });
  }

  AuthSession? _decode(String raw) {
    final decoded = jsonDecode(raw);
    if (decoded is! Map) {
      return null;
    }

    final token = decoded['token'];
    final user = decoded['user'];
    if (token is! String ||
        token.trim().isEmpty ||
        user is! Map ||
        user['id'] is! String ||
        user['name'] is! String) {
      return null;
    }

    return AuthSession(
      token: token.trim(),
      user: AppUser(
        id: user['id'] as String,
        displayName: user['name'] as String,
        email: user['email'] is String ? user['email'] as String : null,
        isGuest: false,
      ),
    );
  }
}
