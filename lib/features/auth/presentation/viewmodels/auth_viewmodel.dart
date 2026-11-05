import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../data/repositories/guest_auth_repository.dart';
import '../../domain/entities/app_user.dart';

part 'auth_viewmodel.g.dart';

@Riverpod(keepAlive: true)
class AuthViewModel extends _$AuthViewModel {
  @override
  Future<AppUser?> build() {
    return ref.watch(authRepositoryProvider).currentUser();
  }

  Future<void> continueAsGuest() async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(
      () => ref.read(authRepositoryProvider).signInAsGuest(),
    );
  }

  Future<void> signOut() async {
    state = const AsyncLoading();
    await ref.read(authRepositoryProvider).signOut();
    state = const AsyncData<AppUser?>(null);
  }
}
