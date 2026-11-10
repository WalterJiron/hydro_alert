import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../app/config/app_config.dart';
import '../../../../core/network/network_providers.dart';
import '../../../auth/data/repositories/auth_repository_impl.dart';
import '../../domain/entities/community_report.dart';
import '../../domain/entities/report_category.dart';
import '../../domain/entities/report_draft.dart';
import '../../domain/repositories/community_reports_repository.dart';
import '../datasources/community_reports_remote_datasource.dart';
import '../models/community_report_model.dart';

class CommunityReportsRepositoryImpl implements CommunityReportsRepository {
  const CommunityReportsRepositoryImpl(this._dataSource);

  final CommunityReportsRemoteDataSource _dataSource;

  @override
  Future<List<CommunityReport>> fetchActiveReports() async {
    final models = await _dataSource.fetchActiveReports();
    return models.map(_toEntity).toList()
      ..sort((a, b) => b.createdAt.compareTo(a.createdAt));
  }

  @override
  Future<void> createReport(ReportDraft draft) {
    return _dataSource.createReport(draft);
  }

  CommunityReport _toEntity(CommunityReportModel model) {
    return CommunityReport(
      id: model.id,
      category: ReportCategory.fromWireValue(model.category),
      description: model.description,
      latitude: model.latitude,
      longitude: model.longitude,
      createdAt: model.createdAt,
      photoUrl: AppConfig.resolveMediaUrl(model.photoUrl),
      isVerified: false,
    );
  }
}

final communityReportsRepositoryProvider = Provider<CommunityReportsRepository>(
  (ref) {
    return CommunityReportsRepositoryImpl(
      CommunityReportsRemoteDataSource(
        ref.watch(backendDioProvider),
        ref.watch(authRepositoryProvider),
      ),
    );
  },
);
