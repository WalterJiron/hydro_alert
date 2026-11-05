import 'package:dio/dio.dart';

import '../../../../app/config/app_config.dart';
import '../../../../app/constants/api_endpoints.dart';
import '../../../../core/errors/app_failure.dart';
import '../../../../core/network/api_client.dart';
import '../../domain/entities/report_draft.dart';
import '../models/community_report_model.dart';

/// HTTP access to the HydroAlert NestJS backend.
///
/// The reports payload is provisional because the backend OpenAPI contract
/// has not been provided yet. Keep changes isolated here when it is available.
class CommunityReportsRemoteDataSource {
  const CommunityReportsRemoteDataSource(this._dio);

  final Dio _dio;

  Future<List<CommunityReportModel>> fetchActiveReports() async {
    _requireBackend();

    final response = await ApiClient.run(
      () => _dio.get<Object?>(ApiEndpoints.activeReportsPath),
    );

    try {
      final list = _extractList(response.data);
      return list
          .whereType<Map<String, dynamic>>()
          .map(CommunityReportModel.fromJson)
          .toList();
    } catch (error) {
      throw ParsingFailure(cause: error);
    }
  }

  Future<void> createReport(ReportDraft draft) async {
    _requireBackend();

    final category = draft.category;
    final latitude = draft.latitude;
    final longitude = draft.longitude;

    if (category == null ||
        latitude == null ||
        longitude == null ||
        draft.description.trim().isEmpty) {
      throw const ConfigurationFailure(
        message:
            'El reporte está incompleto. Revisa los datos e inténtalo de nuevo.',
      );
    }

    final formData = FormData.fromMap(<String, dynamic>{
      'category': category.wireValue,
      'description': draft.description.trim(),
      'latitude': latitude,
      'longitude': longitude,
      if (draft.photoBytes != null)
        'photo': MultipartFile.fromBytes(
          draft.photoBytes!,
          filename: draft.photoName ?? 'report.jpg',
        ),
    });

    await ApiClient.run(
      () => _dio.post<Object?>(ApiEndpoints.reportsPath, data: formData),
    );
  }

  void _requireBackend() {
    if (!AppConfig.hasBackend) {
      throw const ConfigurationFailure(
        message: 'El servicio de reportes todavía no está configurado.',
      );
    }
  }

  List<Object?> _extractList(Object? data) {
    if (data is List<Object?>) {
      return data;
    }
    if (data is Map<String, dynamic>) {
      final value = data['data'] ?? data['reports'] ?? data['items'];
      if (value is List<Object?>) {
        return value;
      }
    }
    throw const ParsingFailure(
      message: 'La respuesta de reportes tiene un formato inesperado.',
    );
  }
}
