import 'dart:typed_data';

import 'package:freezed_annotation/freezed_annotation.dart';

import 'report_category.dart';

part 'report_draft.freezed.dart';

@freezed
abstract class ReportDraft with _$ReportDraft {
  const factory ReportDraft({
    ReportCategory? category,
    @Default('') String description,
    double? latitude,
    double? longitude,
    Uint8List? photoBytes,
    String? photoName,
  }) = _ReportDraft;

  const ReportDraft._();

  bool get hasLocation => latitude != null && longitude != null;

  bool get isValid {
    return category != null &&
        description.trim().length >= 10 &&
        description.trim().length <= 500 &&
        hasLocation;
  }
}
