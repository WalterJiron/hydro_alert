# HydroAlert

**Información que protege.** Aplicación móvil Flutter para Nicaragua que reúne actividad sísmica, clima, un mapa operativo y reportes comunitarios en una interfaz de baja carga cognitiva.

> HydroAlert es una herramienta informativa. No sustituye a SINAPRED, INETER, cuerpos de emergencia ni a ninguna autoridad. Los eventos de USGS **no** son alertas oficiales de evacuación y los reportes comunitarios **no están verificados**.

## Funcionalidad

| Pestaña | Qué hace |
| --- | --- |
| **Inicio** | Resumen del día, clima actual, últimos sismos, reportes recientes y acceso rápido a la guía de emergencia. |
| **Mapa** | Google Maps con marcadores personalizados de sismos y reportes, ubicación del usuario y radar RainViewer opcional. |
| **Reportes** | Lista de reportes comunitarios activos y asistente de dos pasos para crear uno con foto y ubicación. |
| **Alertas** | Pestañas de sismos USGS y avisos meteorológicos OpenWeatherMap con detalle y enlace a la fuente. |
| **Emergencia** | Guía visual de actuación y modo SOS visual a pantalla completa. No llama, no envía ubicación y no despacha ayuda. |

La app inicia con acceso como invitado. No hay credenciales de autenticación ni backend de cuentas en esta entrega.

## Stack

- Flutter 3.44.6 / Dart 3.12.2, null safety estricto.
- Riverpod 3 (`Notifier` / `AsyncNotifier` + `riverpod_generator`).
- Freezed 3 y `json_serializable`.
- `go_router` con `StatefulShellRoute` de cinco ramas.
- `google_maps_flutter` + Google Maps + RainViewer.
- Dio para USGS, OpenWeatherMap y el backend NestJS.
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
│   ├── alerts/          # USGS, OpenWeather y sus vistas
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
| `OPENWEATHER_API_KEY` | No | Clave de OpenWeatherMap One Call 3.0. Sin ella, el clima muestra un estado no disponible. |
| `API_BASE_URL` | No | URL base del backend NestJS de reportes. Sin ella, los reportes quedan deshabilitados. |
| `FIREBASE_ENABLED` | No | `true` activa Firebase Messaging. Por defecto `false`. |
| `SOS_MAGNITUDE_THRESHOLD` | No | Magnitud mínima para el overlay crítico. Por defecto `5.0`. |
| `SOS_EVENT_MAX_AGE_MINUTES` | No | Antigüedad máxima de un sismo para el overlay. Por defecto `15`. |

Las claves nativas de Google Maps no se pasan por `--dart-define`. Se configuran una sola vez en cada plataforma (ver abajo).

Ejemplo:

```bash
flutter run \
  --dart-define=OPENWEATHER_API_KEY=tu_clave \
  --dart-define=API_BASE_URL=https://tu-backend.vercel.app/api/v1 \
  --dart-define=FIREBASE_ENABLED=false
```

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

### USGS

- Endpoint: `https://earthquake.usgs.gov/fdsnws/event/1/query`.
- Filtro para Nicaragua: latitud `10.7..15.0`, longitud `-87.7..-82.5`.
- Magnitud mínima `2.5`, orden por tiempo, ventana de 30 días, límite 50.
- Los registros se muestran como información de USGS, nunca como alerta oficial de evacuación.

### OpenWeatherMap

- Endpoint: One Call 3.0 (`data/3.0/onecall`), unidades métricas, idioma español.
- Ubicación por defecto: Managua (`12.136389, -86.251389`).
- Requiere clave y suscripción activa a One Call 3.0.
- Sin clave o con clave inválida, la interfaz degrada a un estado informativo; no se inventan datos.

### RainViewer

- Metadatos: `https://api.rainviewer.com/public/weather-maps.json`.
- Capa de radar opcional, activada manualmente por el usuario.
- RainViewer sirve teselas de radar hasta **zoom 7**; por encima, la app recorta y amplía la tesela padre de zoom 7 en lugar de pedir niveles inexistentes.
- Se muestra atribución de Google Maps (logotipo del mapa) y RainViewer cuando la capa está activa. La leyenda incluye los créditos completos.

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
- Configurar la clave de OpenWeatherMap para habilitar clima y avisos.
- Configurar Firebase si se requieren notificaciones push.
- Implementar autenticación real cuando exista el servicio de cuentas.
- Configurar firma de release para Android e iOS.
