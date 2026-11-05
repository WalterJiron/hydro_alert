import 'package:freezed_annotation/freezed_annotation.dart';

part 'rainviewer_response.freezed.dart';
part 'rainviewer_response.g.dart';

@freezed
abstract class RainViewerResponse with _$RainViewerResponse {
  const factory RainViewerResponse({
    String? version,
    int? generated,
    String? host,
    RainViewerRadar? radar,
  }) = _RainViewerResponse;

  factory RainViewerResponse.fromJson(Map<String, dynamic> json) =>
      _$RainViewerResponseFromJson(json);
}

@freezed
abstract class RainViewerRadar with _$RainViewerRadar {
  const factory RainViewerRadar({
    @Default(<RainViewerFrame>[]) List<RainViewerFrame> past,
    @Default(<RainViewerFrame>[]) List<RainViewerFrame> nowcast,
  }) = _RainViewerRadar;

  factory RainViewerRadar.fromJson(Map<String, dynamic> json) =>
      _$RainViewerRadarFromJson(json);
}

@freezed
abstract class RainViewerFrame with _$RainViewerFrame {
  const factory RainViewerFrame({int? time, String? path}) = _RainViewerFrame;

  factory RainViewerFrame.fromJson(Map<String, dynamic> json) =>
      _$RainViewerFrameFromJson(json);
}
