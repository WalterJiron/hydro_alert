import '../errors/app_failure.dart';

/// Converts any error into a safe sentence for the UI.
String errorMessageOf(Object error) {
  if (error is AppFailure) {
    return error.message;
  }
  return 'Ocurrió un error inesperado. Inténtalo de nuevo.';
}
