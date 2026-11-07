import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';

/// Maximum size accepted for a report photo.
const int maxReportPhotoBytes = 5 * 1024 * 1024;

/// Extensions accepted for a report photo.
const Set<String> allowedReportPhotoExtensions = {'jpg', 'jpeg', 'png', 'webp'};

/// Returns the validation error for a selected photo, or `null` when valid.
///
/// Kept as a pure function so the rules can be tested without the platform
/// image picker.
String? validateReportPhoto({
  required int byteLength,
  required String fileName,
}) {
  if (byteLength <= 0) {
    return 'La imagen seleccionada está vacía. Intenta con otra.';
  }
  if (byteLength > maxReportPhotoBytes) {
    return 'La imagen supera los 5 MB. Elige una foto más liviana.';
  }

  final extension = fileName.toLowerCase().split('.').last;
  if (!allowedReportPhotoExtensions.contains(extension)) {
    return 'Formato no compatible. Usa JPG, PNG o WebP.';
  }
  return null;
}

/// A photo ready to be attached to a community report.
class ReportPhoto {
  const ReportPhoto({required this.bytes, required this.name});

  final Uint8List bytes;
  final String name;
}

/// A user-facing failure while picking or validating a report photo.
class ReportPhotoException implements Exception {
  const ReportPhotoException(this.message);

  final String message;

  @override
  String toString() => message;
}

/// Wraps `image_picker` so the wizard does not depend on the platform plugin.
class ReportPhotoPicker {
  ReportPhotoPicker({ImagePicker? imagePicker})
    : _imagePicker = imagePicker ?? ImagePicker();

  final ImagePicker _imagePicker;

  Future<ReportPhoto?> pickFromCamera() => _pick(ImageSource.camera);

  Future<ReportPhoto?> pickFromGallery() => _pick(ImageSource.gallery);

  Future<ReportPhoto?> _pick(ImageSource source) async {
    try {
      final file = await _imagePicker.pickImage(
        source: source,
        maxWidth: 1600,
        imageQuality: 82,
      );
      if (file == null) {
        return null;
      }

      final bytes = await file.readAsBytes();
      final error = validateReportPhoto(
        byteLength: bytes.length,
        fileName: file.name,
      );
      if (error != null) {
        throw ReportPhotoException(error);
      }

      return ReportPhoto(bytes: bytes, name: file.name);
    } on ReportPhotoException {
      rethrow;
    } on PlatformException {
      throw const ReportPhotoException(
        'No pudimos acceder a la cámara o galería. Revisa los permisos.',
      );
    } catch (_) {
      throw const ReportPhotoException(
        'No pudimos adjuntar la foto. Inténtalo de nuevo.',
      );
    }
  }
}
