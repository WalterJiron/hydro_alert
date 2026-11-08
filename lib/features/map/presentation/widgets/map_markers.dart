import 'dart:async';
import 'dart:typed_data';
import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

import '../../../../app/theme/app_colors.dart';
import '../../../alerts/domain/entities/seismic_event.dart';
import '../../../alerts/presentation/widgets/seismic_visuals.dart';
import '../../../community_reports/domain/entities/community_report.dart';
import '../../../community_reports/domain/entities/report_category.dart';
import '../../../community_reports/presentation/widgets/report_category_visuals.dart';

/// Paints the custom map pins into bitmaps that Google Maps can display.
///
/// Google Maps requires a [BitmapDescriptor] for each marker, so every pin
/// variant is rendered once with [ui.Canvas] and cached. The bitmaps are drawn
/// at the device pixel ratio to stay sharp on high-density screens.
class MapMarkerIcons {
  MapMarkerIcons._();

  static final Map<String, BitmapDescriptor> _cache = {};
  static final Map<String, Future<BitmapDescriptor>> _pending = {};

  static String seismicKey(SeismicEvent event, double pixelRatio) =>
      'seismic-${event.magnitudeLabel}-${_ratioKey(pixelRatio)}';

  static String reportKey(CommunityReport report, double pixelRatio) =>
      'report-${report.category.name}-${_ratioKey(pixelRatio)}';

  static String userLocationKey(double pixelRatio) =>
      'user-location-${_ratioKey(pixelRatio)}';

  static BitmapDescriptor? cached(String key) => _cache[key];

  static Future<BitmapDescriptor> seismic(
    SeismicEvent event,
    double pixelRatio,
  ) {
    final key = seismicKey(event, pixelRatio);
    return _resolve(key, () => _paintSeismicPin(event, pixelRatio));
  }

  static Future<BitmapDescriptor> report(
    CommunityReport report,
    double pixelRatio,
  ) {
    final key = reportKey(report, pixelRatio);
    return _resolve(key, () => _paintReportPin(report.category, pixelRatio));
  }

  static Future<BitmapDescriptor> userLocation(double pixelRatio) {
    final key = userLocationKey(pixelRatio);
    return _resolve(key, () => _paintUserLocation(pixelRatio));
  }

  static Future<BitmapDescriptor> _resolve(
    String key,
    Future<BitmapDescriptor> Function() build,
  ) {
    final cached = _cache[key];
    if (cached != null) {
      return Future.value(cached);
    }

    return _pending.putIfAbsent(key, () async {
      try {
        final descriptor = await build();
        _cache[key] = descriptor;
        return descriptor;
      } finally {
        unawaited(_pending.remove(key));
      }
    });
  }

  static Future<BitmapDescriptor> _paintSeismicPin(
    SeismicEvent event,
    double pixelRatio,
  ) async {
    final isStrong = event.magnitude >= 5;
    final pinWidth = isStrong ? 46.0 : 40.0;
    final pinHeight = pinWidth * 1.22;

    final bytes = await _record(Size(pinWidth, pinHeight), pixelRatio, (
      canvas,
    ) {
      _paintPinBody(
        canvas,
        size: Size(pinWidth, pinHeight),
        color: seismicColorFor(event.magnitude),
        highlighted: isStrong,
      );
      _paintGlyph(
        canvas,
        icon: LucideIcons.activity,
        size: pinWidth * 0.38,
        center: Offset(pinWidth / 2, pinWidth * 0.34),
      );
      _paintMagnitude(
        canvas,
        label: event.magnitudeLabel,
        color: seismicColorFor(event.magnitude),
        center: Offset(pinWidth / 2, pinWidth * 0.69),
        fontSize: pinWidth * 0.24,
      );
    });

    return _descriptor(bytes, pixelRatio);
  }

  static Future<BitmapDescriptor> _paintReportPin(
    ReportCategory category,
    double pixelRatio,
  ) async {
    const pinWidth = 42.0;
    const pinHeight = 51.0;

    final bytes = await _record(const Size(pinWidth, pinHeight), pixelRatio, (
      canvas,
    ) {
      _paintPinBody(
        canvas,
        size: const Size(pinWidth, pinHeight),
        color: reportCategoryColor(category),
        highlighted: false,
      );
      _paintGlyph(
        canvas,
        icon: reportCategoryIcon(category),
        size: 18,
        center: const Offset(pinWidth / 2, pinWidth * 0.44),
      );
    });

    return _descriptor(bytes, pixelRatio);
  }

  static Future<BitmapDescriptor> _paintUserLocation(double pixelRatio) async {
    const size = 34.0;

    final bytes = await _record(const Size(size, size), pixelRatio, (canvas) {
      const center = Offset(size / 2, size / 2);

      canvas.drawCircle(
        center,
        15,
        Paint()..color = AppColors.mapUserLocation.withValues(alpha: 0.18),
      );
      canvas.drawCircle(
        center,
        11,
        Paint()..color = AppColors.mapUserLocation.withValues(alpha: 0.28),
      );
      canvas.drawCircle(center, 7, Paint()..color = AppColors.mapUserLocation);
      canvas.drawCircle(
        center,
        7,
        Paint()
          ..color = Colors.white
          ..style = PaintingStyle.stroke
          ..strokeWidth = 2.5,
      );
    });

    return _descriptor(bytes, pixelRatio);
  }

  static Future<Uint8List> _record(
    Size logicalSize,
    double pixelRatio,
    void Function(ui.Canvas canvas) paint,
  ) async {
    final width = (logicalSize.width * pixelRatio).ceil();
    final height = (logicalSize.height * pixelRatio).ceil();
    final recorder = ui.PictureRecorder();
    final canvas = ui.Canvas(recorder);

    canvas.scale(pixelRatio);
    paint(canvas);

    final picture = recorder.endRecording();
    final image = await picture.toImage(width, height);
    final data = await image.toByteData(format: ui.ImageByteFormat.png);
    image.dispose();
    picture.dispose();

    if (data == null) {
      throw StateError('No se pudo generar el icono del mapa.');
    }
    return data.buffer.asUint8List();
  }

  static BitmapDescriptor _descriptor(Uint8List bytes, double pixelRatio) {
    return BitmapDescriptor.bytes(bytes, imagePixelRatio: pixelRatio);
  }

  static void _paintPinBody(
    ui.Canvas canvas, {
    required Size size,
    required Color color,
    required bool highlighted,
  }) {
    final radius = size.width / 2;
    final center = Offset(radius, radius);
    final path = Path()
      ..addOval(Rect.fromCircle(center: center, radius: radius))
      ..moveTo(radius - radius * 0.46, radius + radius * 0.72)
      ..lineTo(radius, size.height)
      ..lineTo(radius + radius * 0.46, radius + radius * 0.72)
      ..close();

    canvas.drawPath(
      path.shift(const Offset(0, 2)),
      Paint()
        ..color = AppColors.mapPinShadow
        ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 5),
    );
    canvas.drawPath(path, Paint()..color = color);
    canvas.drawPath(
      path,
      Paint()
        ..color = Colors.white
        ..style = PaintingStyle.stroke
        ..strokeWidth = 2,
    );

    if (highlighted) {
      canvas.drawCircle(
        center,
        radius - 5,
        Paint()
          ..color = Colors.white.withValues(alpha: 0.85)
          ..style = PaintingStyle.stroke
          ..strokeWidth = 1.5,
      );
    }
  }

  static void _paintGlyph(
    ui.Canvas canvas, {
    required IconData icon,
    required double size,
    required Offset center,
  }) {
    final painter = TextPainter(
      text: TextSpan(
        text: String.fromCharCode(icon.codePoint),
        style: TextStyle(
          fontSize: size,
          fontFamily: icon.fontFamily,
          package: icon.fontPackage,
          color: Colors.white,
          height: 1,
        ),
      ),
      textDirection: TextDirection.ltr,
    )..layout();

    painter.paint(
      canvas,
      center - Offset(painter.width / 2, painter.height / 2),
    );
    painter.dispose();
  }

  static void _paintMagnitude(
    ui.Canvas canvas, {
    required String label,
    required Color color,
    required Offset center,
    required double fontSize,
  }) {
    final painter = TextPainter(
      text: TextSpan(
        text: label,
        style: TextStyle(
          fontSize: fontSize,
          fontWeight: FontWeight.w800,
          color: color,
          height: 1.1,
        ),
      ),
      textDirection: TextDirection.ltr,
    )..layout();

    final pill = RRect.fromRectAndRadius(
      Rect.fromCenter(
        center: center,
        width: painter.width + 9,
        height: painter.height + 3,
      ),
      Radius.circular((painter.height + 3) / 2),
    );

    canvas.drawRRect(
      pill.shift(const Offset(0, 1)),
      Paint()..color = Colors.black.withValues(alpha: 0.08),
    );
    canvas.drawRRect(pill, Paint()..color = Colors.white);
    painter.paint(
      canvas,
      center - Offset(painter.width / 2, painter.height / 2),
    );
    painter.dispose();
  }

  static String _ratioKey(double pixelRatio) =>
      pixelRatio.toStringAsFixed(2).replaceAll('.', '_');
}
