import '../../../community_reports/domain/entities/community_report.dart';
import '../../../community_reports/domain/entities/report_draft.dart';

abstract interface class CommunityReportsRepository {
  Future<List<CommunityReport>> fetchActiveReports();

  Future<void> createReport(ReportDraft draft);
}
