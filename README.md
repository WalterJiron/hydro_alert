# HydroAlert

**Información que protege.** Aplicación móvil Flutter para Nicaragua que reúne actividad sísmica, clima, un mapa operativo y reportes comunitarios en una interfaz de baja carga cognitiva.

> HydroAlert es una herramienta informativa. No sustituye a SINAPRED, INETER, cuerpos de emergencia ni a ninguna autoridad. Los eventos sísmicos de INETER (o del respaldo de USGS) **no** son alertas oficiales de evacuación y los reportes comunitarios **no están verificados**.

## Funcionalidad

| Pestaña | Qué hace |
| --- | --- |
| **Inicio** | Resumen del día, clima actual, últimos sismos, reportes recientes y acceso rápido a la guía de emergencia. |
| **Mapa** | Google Maps con marcadores personalizados de sismos y reportes, ubicación del usuario y radar RainViewer opcional. |
| **Reportes** | Lista de reportes comunitarios activos y asistente de dos pasos para crear uno con foto y ubicación. Publicar requiere una cuenta de reportante; explorar no. |
| **Alertas** | Pestañas de sismos de INETER (respaldo USGS) y avisos meteorológicos de WeatherAPI con detalle y enlace a la fuente. |
| **Emergencia** | Guía visual de actuación y modo SOS visual a pantalla completa. No llama, no envía ubicación y no despacha ayuda. |

El mapa, el inicio, las alertas y la lista de reportes están disponibles como invitado. Solo publicar un reporte requiere crear una cuenta o iniciar sesión; la sesión se guarda localmente y nunca bloquea la navegación.

La interfaz sigue automáticamente el tema claro u oscuro configurado en el dispositivo (`ThemeMode.system`); no hay un selector manual dentro de la app.

## Stack

- Flutter 3.44.6 / Dart 3.12.2, null safety estricto.
- Riverpod 3 (`Notifier` / `AsyncNotifier` + `riverpod_generator`).
- Freezed 3 y `json_serializable`.
- `go_router` con `StatefulShellRoute` de cinco ramas.
- `google_maps_flutter` + Google Maps + RainViewer.
- Dio para el backend FastAPI, USGS, WeatherAPI y OpenWeatherMap (respaldo).
- `shared_preferences` para persistir la sesión y `web_socket_channel` para reportes y notificaciones en tiempo real.
- Firebase Core / Messaging **opcional**.
- `image_picker` para cámara/galería y `geolocator` para ubicación bajo demanda.
- Arquitectura Screaming Architecture + MVVM, componentes compartidos inspirados en Atomic Design y tokens centralizados (`AppColors`, `AppPalette`, `AppTypography`, `AppTheme`).

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
│   ├── services/        # ubicación, notificaciones, push y WebSocket
│   └── utils/           # fechas en español y mensajes de error
├── features/
│   ├── alerts/          # INETER (respaldo USGS), WeatherAPI y OpenWeather
│   ├── auth/            # cuentas de reportante, invitado y sesión persistida
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
| `API_BASE_URL` | No | URL base del backend FastAPI. Por defecto usa `http://10.0.2.2:8000/api/v1` en el emulador Android y `http://localhost:8000/api/v1` en el resto. Si se omite el prefijo `/api/v1`, se agrega automáticamente. |
| `FIREBASE_ENABLED` | No | `true` activa Firebase Messaging. Por defecto `false`. |
| `SOS_MAGNITUDE_THRESHOLD` | No | Magnitud mínima para el overlay crítico. Por defecto `5.0`. |
| `SOS_EVENT_MAX_AGE_MINUTES` | No | Antigüedad máxima de un sismo para el overlay. Por defecto `15`. |

Las claves nativas de Google Maps no se pasan por `--dart-define`. Se configuran una sola vez en cada plataforma (ver abajo).

Ejemplo:

```bash
flutter run \
  --dart-define=WEATHERAPI_KEY=tu_clave \
  --dart-define=API_BASE_URL=http://localhost:8000/api/v1 \
  --dart-define=FIREBASE_ENABLED=false
```

En un dispositivo físico, reemplaza `localhost` por la IP de la máquina que ejecuta el backend, por ejemplo `http://192.168.1.20:8000/api/v1`.

Para desarrollo local, Android permite HTTP solo en las variantes debug/profile (`src/debug` y `src/profile`); los builds release mantienen `usesCleartextTraffic="false"`. iOS permite redes locales con `NSAllowsLocalNetworking`. En producción usa `https://` y `wss://`.

### Google Maps

El mapa base usa el SDK nativo de Google Maps.

**Android**

1. Agrega la clave en `android/local.properties` (ignorado por git):

   ```properties
   GOOGLE_MAPS_API_KEY=tu_clave
   ```

2. `android/app/build.gradle.kts` la inyecta como `manifestPlaceholders["googleMapsApiKey"]` y `AndroidManifest.xml` la publica en `com.google.android.geo.API_KEY`.

**iOS**

`ios/Runner/AppDelegate.swift` llama a `GMSServices.provideAPIKey("...")` antes de inicializar Flutter. El proyecto requiere **iOS 14 o superior** por el SDK de Google Maps.

**Restricciones recomendadas en Google Cloud**

- Habilitar **Maps SDK for Android** y **Maps SDK for iOS**.
- Restringir la clave de Android al package `ni.hydroalert.app` y al SHA-1 del keystore usado para firmar.
- Restringir la clave de iOS al bundle ID de la app.
- Si el mapa aparece en blanco o gris, revisa `adb logcat`/Xcode en busca de `API key not valid` o restricciones de paquete/SHA-1.

## Fuentes de datos y límites

### INETER (primaria)

- El backend FastAPI sincroniza los eventos de INETER y los expone en `GET {API_BASE_URL}/seismic-events`.
- Parámetros usados por la app: `page=1`, `page_size=100` y `from_date` con los últimos 30 días.
- Campos leídos: `id`, `event_at` (o `event_date` + `event_time`), `latitude`, `longitude`, `depth_km`, `magnitude`, `location`, `pais`, `status`, `source`.
- Si `event_at` falta, la app interpreta `event_date`/`event_time` como hora local de Nicaragua (UTC-6).
- Los eventos se muestran con la etiqueta de su fuente; una lista vacía de INETER se muestra como estado vacío y **no** activa el respaldo.
- Si el backend o INETER fallan, se consulta USGS como respaldo.

### USGS (respaldo)

- Endpoint: `https://earthquake.usgs.gov/fdsnws/event/1/query`.
- Filtro para Nicaragua: latitud `10.7..15.0`, longitud `-87.7..-82.5`.
- Magnitud mínima `2.5`, orden por tiempo, ventana de 30 días, límite 50.
- Solo se consulta cuando el backend/INETER no está disponible.
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
- Capa de radar opcional, activada manualmente por el usuario.
- RainViewer sirve teselas de radar hasta **zoom 7**; por encima, la app recorta y amplía la tesela padre de zoom 7 en lugar de pedir niveles inexistentes.
- Se muestra atribución de Google Maps (logotipo del mapa) y RainViewer cuando la capa está activa. La leyenda incluye los créditos completos.

### Cuentas de reportante

- `POST {API_BASE_URL}/auth/register` con `name`, `email`, `password` y `cedula`; responde `{ token, user: { id, name, email } }`.
- `POST {API_BASE_URL}/auth/login` con `email` y `password`; devuelve la misma estructura.
- La cédula debe tener el formato `000-000000-0000A` y la contraseña al menos 8 caracteres.
- El token se guarda con `shared_preferences`; cerrar sesión lo elimina.
- Sin cuenta se puede explorar la app completa. El asistente de reportes abre la hoja de acceso solo al enviar.

### Reportes comunitarios

- `GET {API_BASE_URL}/reports/active` es público y no requiere token.
- `POST {API_BASE_URL}/reports` usa multipart con `category`, `description`, `latitude`, `longitude` y `photo` opcional; exige `Authorization: Bearer <token>`.
- Categorías en el cable: `flood`, `damaged_drain`, `fallen_tree`, `landslide`, `fire`, `earthquake_damage`, `other`.
- La foto puede ser una URL absoluta (Supabase) o una ruta relativa como `/api/v1/reports/photos/{id}`; ambas se resuelven contra el origen del API.
- La app tolera variantes de campos en lectura: `id`/`_id`, `photoUrl`/`photo_url`, `createdAt`/`created_at`.
- Los mensajes del backend llegan en inglés y se traducen a español para el usuario (`email_already_registered`, `cedula_already_registered`, `invalid_credentials`, `invalid_token`, `photo_too_large`, `unsupported_photo`, `rate_limited`, entre otros).
- Todos los reportes se muestran con la etiqueta **Sin verificar**; nunca se presentan como alertas oficiales.

### Tiempo real (WebSocket)

- Endpoint: `ws://{host}:8000/api/v1/ws?channels=reports,notifications` (`wss://` en producción).
- Es público: no requiere token y la app entra como invitada.
- Eventos: `connection.ready`, `report.created`, `report.deleted`, `notification.created`, `pong` y `error`.
- La app envía `{"action":"ping","sentAt":"..."}` cada 30 s, reanuda con `lastEventId` y reconecta con retroceso exponencial.
- `report.created` y `report.deleted` refrescan la lista de reportes en silencio.
- `notification.created` alimenta el overlay crítico de emergencia.

## Firebase (opcional)

La app funciona completamente sin Firebase. Para habilitar notificaciones push:

1. Crea el proyecto en Firebase y registra Android (`ni.hydroalert.app`) e iOS (`ni.hydroalert.app`).
2. Agrega `android/app/google-services.json` y `ios/Runner/GoogleService-Info.plist`.
3. Aplica el plugin de Google Services en Android y sube los archivos a la configuración de iOS.
4. Compila con `--dart-define=FIREBASE_ENABLED=true`.

Sin esos archivos, `NotificationService` captura el fallo, lo registra y la app sigue funcionando. El overlay crítico también reacciona a sismos recientes de INETER publicados por el backend, a notificaciones en tiempo real y a mensajes push, según el umbral configurado, sin depender de Firebase.

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
dart format lib test
flutter analyze
flutter test
```

Estado actual: `flutter analyze` sin incidencias y pruebas unitarias y de widget aprobadas.

## Pendientes conocidos

- Configurar `API_BASE_URL` del backend FastAPI desplegado y usar `wss://` en producción.
- Configurar la clave de WeatherAPI para habilitar clima y avisos (OpenWeatherMap es opcional como respaldo).
- Configurar Firebase si se requieren notificaciones push.
- Configurar firma de release para Android e iOS.
