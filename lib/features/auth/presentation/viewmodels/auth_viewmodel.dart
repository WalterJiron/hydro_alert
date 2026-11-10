import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../../core/errors/app_failure.dart';
import '../../../../core/network/error_handler.dart';
import '../../data/repositories/auth_repository_impl.dart';
import '../../domain/entities/auth_session.dart';

part 'auth_viewmodel.g.dart';

@Riverpod(keepAlive: true)
class AuthViewModel extends _$AuthViewModel {
  @override
  Future<AuthSession?> build() {
    return ref.watch(authRepositoryProvider).currentSession();
  }

  AuthSession? get session => state.value;

  bool get isAuthenticated => state.value?.isAuthenticated ?? false;

  Future<void> continueAsGuest() async {
    if (isAuthenticated) {
      return;
    }

    state = const AsyncLoading();
    state = await AsyncValue.guard(
      () => ref.read(authRepositoryProvider).signInAsGuest(),
    );
  }

  Future<AppFailure?> register({
    required String name,
    required String email,
    required String password,
    required String cedula,
  }) async {
    return _authenticate(
      () => ref
          .read(authRepositoryProvider)
          .register(
            name: name,
            email: email,
            password: password,
            cedula: cedula,
          ),
    );
  }

  Future<AppFailure?> login({
    required String email,
    required String password,
  }) async {
    return _authenticate(
      () => ref
          .read(authRepositoryProvider)
          .login(email: email, password: password),
    );
  }

  Future<void> signOut() async {
    state = const AsyncLoading();
    await ref.read(authRepositoryProvider).signOut();
    state = const AsyncData<AuthSession?>(null);
  }

  Future<AppFailure?> _authenticate(
    Future<AuthSession> Function() authenticate,
  ) async {
    final previous = state.value;
    state = const AsyncLoading();

    try {
      final session = await authenticate();
      if (ref.mounted) {
        state = AsyncData<AuthSession?>(session);
      }
      return null;
    } catch (error) {
      final failure = ErrorHandler.handle(error);
      if (ref.mounted) {
        state = AsyncData<AuthSession?>(previous);
      }
      return failure;
    }
  }
}
