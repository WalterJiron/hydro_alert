/// User-facing failures. Technical details stay out of the UI.
sealed class AppFailure implements Exception {
  const AppFailure(this.message, {this.cause});

  final String message;
  final Object? cause;

  @override
  String toString() => message;
}

final class NetworkFailure extends AppFailure {
  const NetworkFailure({
    String message =
        'No pudimos conectar con el servicio. Revisa tu conexión e inténtalo de nuevo.',
    Object? cause,
  }) : super(message, cause: cause);
}

final class TimeoutFailure extends AppFailure {
  const TimeoutFailure({
    String message =
        'El servicio tardó demasiado en responder. Inténtalo de nuevo.',
    Object? cause,
  }) : super(message, cause: cause);
}

final class ServerFailure extends AppFailure {
  const ServerFailure({
    String message =
        'El servicio no está disponible en este momento. Inténtalo más tarde.',
    Object? cause,
    this.statusCode,
  }) : super(message, cause: cause);

  final int? statusCode;
}

final class UnauthorizedFailure extends AppFailure {
  const UnauthorizedFailure({
    String message =
        'No pudimos autenticar el servicio. Revisa la configuración.',
    Object? cause,
  }) : super(message, cause: cause);
}

final class NotFoundFailure extends AppFailure {
  const NotFoundFailure({
    String message = 'No encontramos la información solicitada.',
    Object? cause,
  }) : super(message, cause: cause);
}

final class RateLimitFailure extends AppFailure {
  const RateLimitFailure({
    String message =
        'Se alcanzó el límite de consultas del servicio. Espera un momento e inténtalo de nuevo.',
    Object? cause,
  }) : super(message, cause: cause);
}

final class ParsingFailure extends AppFailure {
  const ParsingFailure({
    String message = 'Recibimos información con un formato inesperado.',
    Object? cause,
  }) : super(message, cause: cause);
}

final class ConfigurationFailure extends AppFailure {
  const ConfigurationFailure({
    String message = 'Este servicio todavía no está configurado.',
    super.cause,
  }) : super(message);
}

final class LocationFailure extends AppFailure {
  const LocationFailure({
    String message =
        'No pudimos obtener tu ubicación. Revisa los permisos del dispositivo.',
    super.cause,
  }) : super(message);
}

final class CancelledFailure extends AppFailure {
  const CancelledFailure({
    String message = 'La operación fue cancelada.',
    Object? cause,
  }) : super(message, cause: cause);
}

final class UnknownFailure extends AppFailure {
  const UnknownFailure({
    String message = 'Ocurrió un error inesperado. Inténtalo de nuevo.',
    Object? cause,
  }) : super(message, cause: cause);
}
