import 'package:freezed_annotation/freezed_annotation.dart';

import 'report_category.dart';

part 'community_report.freezed.dart';

@freezed
abstract class CommunityReport with _$CommunityReport {
  const factory CommunityReport({
    required String id,
    required ReportCategory category,
    required String description,
    required double latitude,
    required double longitude,
    required DateTime createdAt,
    String? photoUrl,
    @Default(false) bool isVerified,
  }) = _CommunityReport;

  const CommunityReport._();

  String get coordinatesLabel {
    return '${latitude.toStringAsFixed(3)}, ${longitude.toStringAsFixed(3)}';
  }
}
