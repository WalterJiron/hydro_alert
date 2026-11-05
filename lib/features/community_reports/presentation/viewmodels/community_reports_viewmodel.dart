import 'dart:async';

import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../../app/config/app_config.dart';
import '../../data/repositories/community_reports_repository_impl.dart';
import '../../domain/entities/community_report.dart';

part 'community_reports_viewmodel.g.dart';

@Riverpod(keepAlive: true)
class CommunityReportsViewModel extends _$CommunityReportsViewModel {
  Timer? _timer;
  bool _disposed = false;

  @override
  Future<List<CommunityReport>> build() async {
    if (AppConfig.hasBackend) {
      _timer = Timer.periodic(const Duration(minutes: 5), (_) {
        unawaited(_refreshSilently());
      });
    }

    ref.onDispose(() {
      _disposed = true;
      _timer?.cancel();
    });

    return ref.watch(communityReportsRepositoryProvider).fetchActiveReports();
  }

  Future<void> refresh() async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(
      () => ref.read(communityReportsRepositoryProvider).fetchActiveReports(),
    );
  }

  Future<void> _refreshSilently() async {
    if (_disposed) {
      return;
    }

    try {
      final reports = await ref
          .read(communityReportsRepositoryProvider)
          .fetchActiveReports();
      if (!_disposed) {
        state = AsyncData(reports);
      }
    } catch (_) {
      // Keep the last successful list while the backend is unavailable.
    }
  }
}
