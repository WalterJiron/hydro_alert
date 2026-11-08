# HydroAlert

**Información que protege.** Aplicación móvil Flutter para Nicaragua que reúne actividad sísmica, clima, un mapa operativo y reportes comunitarios en una interfaz de baja carga cognitiva.

> HydroAlert es una herramienta informativa. No sustituye a SINAPRED, INETER, cuerpos de emergencia ni a ninguna autoridad. Los eventos de USGS **no** son alertas oficiales de evacuación y los reportes comunitarios **no están verificados**.

## Funcionalidad

| Pestaña | Qué hace |
| --- | --- |
| **Inicio** | Resumen del día, clima actual, últimos sismos, reportes recientes y acceso rápido a la guía de emergencia. |
| **Mapa** | Mapbox con marcadores personalizados de sismos y reportes, ubicación del usuario y radar RainViewer animado opcional. |
| **Reportes** | Lista de reportes comunitarios activos y asistente de dos pasos para crear uno con foto y ubicación. |
| **Alertas** | Pestañas de sismos USGS y avisos meteorológicos de WeatherAPI con detalle y enlace a la fuente. |
| **Emergencia** | Guía visual de actuación y modo SOS visual a pantalla completa. No llama, no envía ubicación y no despacha ayuda. |

La app inicia con acceso como invitado. No hay credenciales de autenticación ni backend de cuentas en esta entrega.

## Stack

- Flutter 3.44.6 / Dart 3.12.2, null safety estricto.
- Riverpod 3 (`Notifier` / `AsyncNotifier` + `riverpod_generator`).
- Freezed 3 y `json_serializable`.
- `go_router` con `StatefulShellRoute` de cinco ramas.
- `mapbox_maps_flutter` + Mapbox + RainViewer.
- Dio para USGS, WeatherAPI, OpenWeatherMap (respaldo) y el backend NestJS.
- Firebase Core / Messaging **opcional**.
- `image_picker` para cámara/galería y `geolocator` para ubicación bajo demanda.
- Arquitectura Screaming Architecture + MVVM, componentes compartidos inspirados en Atomic Design y tokens centralizados (`AppColors`, `AppTypography`, `AppTheme`).

## Estructura

```text
lib/
├── app/
│   ├── config/          # dart-defines y banderas de funcionalidad
│   ├── constants/       # endpoints externos y límites geográficos
│   ├── router/          # GoRouter y shell de cinco pestañas
│   └── theme/           # colores, tipografía y tema Material 3
├── core/
│   ├── errors/          # fallos de usuario
│   ├── network/         # clientes Dio y mapeo de errores
│   ├── services/        # ubicación, notificaciones y push
│   └── utils/           # fechas en español y mensajes de error
├── features/
│   ├── alerts/          # USGS, WeatherAPI, OpenWeather (respaldo) y sus vistas
│   ├── auth/            # acceso invitado
│   ├── community_reports/ # reportes y asistente
│   ├── emergency_sos/   # guía y overlay crítico
│   ├── home/            # tablero
│   └── map/             # mapa, radar y capas
└── shared/
    ├── atoms/           # botón, logo, badges, estado
    ├── feedback/        # carga, error y vacío
    ├── molecules/       # tarjetas, encabezados, avisos
    └── organisms/       # shell y host de alertas críticas
```

Los archivos generados (`*.g.dart`, `*.freezed.dart`, `*.riverpod.dart`) se producen con `build_runner` y están excluidos del análisis estático.

## Puesta en marcha

```bash
flutter pub get
dart run build_runner build
flutter analyze
flutter test
flutter run
```

### Variables de compilación

Nunca se guardan secretos en el repositorio. Usa `--dart-define`:

| Variable | Obligatoria | Descripción |
| --- | --- | --- |
| `WEATHERAPI_KEY` | No | Clave de WeatherAPI (fuente primaria del clima y sus avisos). Sin ella ni `OPENWEATHER_API_KEY`, el clima muestra un estado no disponible. |
| `OPENWEATHER_API_KEY` | No | Clave de OpenWeatherMap One Call 3.0, usada solo como respaldo cuando WeatherAPI falla. |
| `MAPBOX_ACCESS_TOKEN` | No | Token público de Mapbox (`pk.`). Sin él, la pestaña de mapa muestra un estado no configurado y el resto de la app sigue funcionando. |
| `API_BASE_URL` | No | URL base del backend NestJS de reportes. Sin ella, los reportes quedan deshabilitados. |
| `FIREBASE_ENABLED` | No | `true` activa Firebase Messaging. Por defecto `false`. |
| `SOS_MAGNITUDE_THRESHOLD` | No | Magnitud mínima para el overlay crítico. Por defecto `5.0`. |
| `SOS_EVENT_MAX_AGE_MINUTES` | No | Antigüedad máxima de un sismo para el overlay. Por defecto `15`. |

El token de Mapbox se pasa como variable de compilación; no hay claves nativas que configurar en el código.

Ejemplo:

```bash
flutter run \
  --dart-define=MAPBOX_ACCESS_TOKEN=pk.tu_token \
  --dart-define=WEATHERAPI_KEY=tu_clave \
  --dart-define=API_BASE_URL=https://tu-backend.vercel.app/api/v1 \
  --dart-define=FIREBASE_ENABLED=false
```

También puedes crear un `dart_defines.json` local (ignorado por git) y compilar con `--dart-define-from-file=dart_defines.json`.

### Mapbox

El mapa base usa `mapbox_maps_flutter` con el estilo **Outdoors**.

1. Crea un token público (`pk.`) en tu cuenta de Mapbox.
2. Compílalo con `--dart-define=MAPBOX_ACCESS_TOKEN=pk...`.
3. Restringe el token a tu aplicación (URL de descarga o bundle/package) desde el panel de Mapbox.

Sin token, `AppConfig.hasMapbox` es `false`: la app no construye el `MapWidget`, muestra un estado informativo y deshabilita los controles del mapa. El resto de la aplicación funciona con normalidad.

## Fuentes de datos y límites

### USGS

- Endpoint: `https://earthquake.usgs.gov/fdsnws/event/1/query`.
- Filtro para Nicaragua: latitud `10.7..15.0`, longitud `-87.7..-82.5`.
- Magnitud mínima `2.5`, orden por tiempo, ventana de 30 días, límite 50.
- Los registros se muestran como información de USGS, nunca como alerta oficial de evacuación.

### WeatherAPI (primaria)

- Endpoint: `https://api.weatherapi.com/v1/forecast.json`.
- Parámetros: ubicación `lat,lon`, `days=3` (límite del plan Free), `aqi=no`, `alerts=yes`, `lang=es`.
- Ubicación por defecto: Managua (`12.136389, -86.251389`).
- Los avisos se muestran como información de WeatherAPI; no sustituyen a SINAPRED o INETER.
- Sin clave o con clave inválida, el repositorio intenta OpenWeatherMap si está configurado; si tampoco lo está, la interfaz degrada a un estado informativo sin inventar datos.

### OpenWeatherMap (respaldo)

- Endpoint: One Call 3.0 (`data/3.0/onecall`), unidades métricas, idioma español.
- Solo se consulta cuando WeatherAPI no está configurada o su petición falla.
- Requiere clave y suscripción activa a One Call 3.0.

### RainViewer

- Metadatos: `https://api.rainviewer.com/public/weather-maps.json`.
- Capa de radar opcional, activada manualmente por el usuario, con reproducción animada de los últimos fotogramas.
- Cada fotograma se dibuja con capas raster nativas de Mapbox, debajo de los pines de sismos y reportes.
- RainViewer sirve teselas de radar hasta **zoom 7**; Mapbox sobrescala la imagen por encima de ese nivel.
- Con movimiento reducido activo se muestra solo el último fotograma, sin bucle.
- Se muestra el crédito de RainViewer y la hora del fotograma; el logotipo y la atribución de Mapbox los dibuja el propio mapa.

### Reportes comunitarios

**Contrato provisional.** La especificación OpenAPI del backend NestJS todavía no fue entregada. La implementación actual asume:

- `GET {API_BASE_URL}/reports/active` → lista o `{ data | reports | items: [...] }`.
- `POST {API_BASE_URL}/reports` multipart con `category`, `description`, `latitude`, `longitude` y `photo` opcional.
- Categorías en el cable: `flood`, `damaged_drain`, `fallen_tree`, `landslide`, `fire`, `earthquake_damage`, `other`.
- Campos tolerados en lectura: `id`/`_id`, `photoUrl`/`photo_url`, `createdAt`/`created_at`.

Estos nombres deben validarse contra el Swagger real antes de producción. Todos los reportes se muestran con la etiqueta **Sin verificar**; nunca se presentan como alertas oficiales. Sin `API_BASE_URL`, el envío y la consulta quedan deshabilitados con un mensaje claro.

## Firebase (opcional)

La app funciona completamente sin Firebase. Para habilitar notificaciones push:

1. Crea el proyecto en Firebase y registra Android (`ni.hydroalert.app`) e iOS (`ni.hydroalert.app`).
2. Agrega `android/app/google-services.json` y `ios/Runner/GoogleService-Info.plist`.
3. Aplica el plugin de Google Services en Android y sube los archivos a la configuración de iOS.
4. Compila con `--dart-define=FIREBASE_ENABLED=true`.

Sin esos archivos, `NotificationService` captura el fallo, lo registra y la app sigue funcionando. El overlay crítico también reacciona a sismos recientes de USGS según el umbral configurado, sin depender de Firebase.

## SOS visual

El botón de emergencia y el overlay **no** realizan llamadas, **no** envían mensajes, **no** comparten la ubicación y **no** despachan ayuda automáticamente. Solo muestran instrucciones grandes y claras. La ubicación solo se solicita cuando el usuario pulsa explícitamente «Usar mi ubicación» en el mapa o en el asistente de reportes.

## Permisos

- Android: internet, ubicación aproximada/precisa, cámara y notificaciones.
- iOS: ubicación en uso, cámara, fototeca y modo remoto de notificaciones.
- Los permisos se solicitan en el momento en que se usan, nunca al iniciar.

## Identificadores

- Nombre visible: **HydroAlert**.
- Bundle ID / applicationId: `ni.hydroalert.app`.
- Paquete Dart: `hydro_alert`.

## Validación

```bash
dart format .
flutter analyze
flutter test
```

Estado actual: `flutter analyze` sin incidencias y pruebas de widget aprobadas.

## Pendientes conocidos

- Confirmar el contrato OpenAPI del backend NestJS y la URL real de Vercel.
- Configurar la clave de WeatherAPI para habilitar clima y avisos (OpenWeatherMap es opcional como respaldo).
- Configurar `MAPBOX_ACCESS_TOKEN` para habilitar el mapa y el radar.
- Configurar Firebase si se requieren notificaciones push.
- Implementar autenticación real cuando exista el servicio de cuentas.
- Configurar firma de release para Android e iOS.
