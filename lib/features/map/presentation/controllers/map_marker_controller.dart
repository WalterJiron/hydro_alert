import 'dart:typed_data';

import 'package:flutter/widgets.dart';
import 'package:latlong2/latlong.dart' as latlong;
import 'package:mapbox_maps_flutter/mapbox_maps_flutter.dart' as mbx;

import '../../../alerts/domain/entities/seismic_event.dart';
import '../../../community_reports/domain/entities/community_report.dart';
import '../widgets/map_markers.dart';

/// Owns the map annotation managers and turns domain entities into Mapbox
/// point annotations.
///
/// The view only provides the current data and the tap callbacks; caching,
/// asynchronous icon generation, manager creation and stacking order stay
/// here. Managers are created in a fixed order (reports, earthquakes, user)
/// so the user location is always drawn on top.
class MapMarkerController {
  static const String reportsManagerId = 'hydroalert-reports';
  static const String seismsManagerId = 'hydroalert-seisms';
  static const String userManagerId = 'hydroalert-user';

  final Map<String, Uint8List> _icons = {};

  mbx.PointAnnotationManager? _reportsManager;
  mbx.PointAnnotationManager? _seismsManager;
  mbx.PointAnnotationManager? _userManager;

  mbx.Cancelable? _reportsTap;
  mbx.Cancelable? _seismsTap;

  Future<void>? _managersFuture;
  Future<void> _queue = Future<void>.value();

  final Map<String, CommunityReport> _reportsById = {};
  final Map<String, SeismicEvent> _seismsById = {};

  String? _signature;
  bool _disposed = false;

  /// First annotation layer, used as the reference to keep radar layers below
  /// every pin.
  String get annotationBaseLayerId => reportsManagerId;

  /// Starts creating the annotation managers once the native map exists.
  void attach(
    mbx.MapboxMap map, {
    required ValueChanged<CommunityReport> onReportTap,
    required ValueChanged<SeismicEvent> onSeismicTap,
  }) {
    _managersFuture ??= _createManagers(
      map,
      onReportTap: onReportTap,
      onSeismicTap: onSeismicTap,
    );
  }

  Future<void> _createManagers(
    mbx.MapboxMap map, {
    required ValueChanged<CommunityReport> onReportTap,
    required ValueChanged<SeismicEvent> onSeismicTap,
  }) async {
    final reports = await map.annotations.createPointAnnotationManager(
      id: reportsManagerId,
    );
    final seisms = await map.annotations.createPointAnnotationManager(
      id: seismsManagerId,
    );
    final user = await map.annotations.createPointAnnotationManager(
      id: userManagerId,
    );

    for (final manager in [reports, seisms, user]) {
      await manager.setIconAllowOverlap(true);
      await manager.setIconIgnorePlacement(true);
      await manager.setSymbolZOrder(mbx.SymbolZOrder.VIEWPORT_Y);
    }

    _reportsTap = reports.tapEvents(
      onTap: (annotation) {
        final id = _customId(annotation);
        final report = id == null ? null : _reportsById[id];
        if (report != null) {
          onReportTap(report);
        }
      },
    );
    _seismsTap = seisms.tapEvents(
      onTap: (annotation) {
        final id = _customId(annotation);
        final event = id == null ? null : _seismsById[id];
        if (event != null) {
          onSeismicTap(event);
        }
      },
    );

    if (_disposed) {
      _reportsTap?.cancel();
      _seismsTap?.cancel();
      return;
    }

    _reportsManager = reports;
    _seismsManager = seisms;
    _userManager = user;
  }

  /// Schedules an annotation refresh when the visible data changed.
  ///
  /// Calls are serialized and coalesced by [signature], so rebuilding the view
  /// never recreates the same annotations twice.
  void sync({
    required List<SeismicEvent> events,
    required List<CommunityReport> reports,
    required latlong.LatLng? userLocation,
    required double pixelRatio,
  }) {
    if (_disposed || _managersFuture == null) {
      return;
    }

    final signature = _signatureFor(
      events: events,
      reports: reports,
      userLocation: userLocation,
      pixelRatio: pixelRatio,
    );
    if (signature == _signature) {
      return;
    }
    _signature = signature;

    final request = _MarkerRequest(
      events: List<SeismicEvent>.of(events),
      reports: List<CommunityReport>.of(reports),
      userLocation: userLocation,
      pixelRatio: pixelRatio,
    );
    _queue = _queue.then((_) => _apply(request)).catchError((Object _) {
      // Keep the queue alive; the next data change retries the refresh.
    });
  }

  Future<void> _apply(_MarkerRequest request) async {
    if (_disposed) {
      return;
    }

    final managers = _managersFuture;
    if (managers == null) {
      return;
    }
    await managers;

    final reports = _reportsManager;
    final seisms = _seismsManager;
    final user = _userManager;
    if (reports == null || seisms == null || user == null || _disposed) {
      return;
    }

    _reportsById.clear();
    _seismsById.clear();

    final reportOptions = <mbx.PointAnnotationOptions>[];
    for (final report in request.reports) {
      final key = MapMarkerIcons.reportKey(report, request.pixelRatio);
      final image =
          _icons[key] ??
          await MapMarkerIcons.report(report, request.pixelRatio);
      if (_disposed) {
        return;
      }
      _icons[key] = image;
      reportOptions.add(
        mbx.PointAnnotationOptions(
          geometry: mbx.Point(
            coordinates: mbx.Position(report.longitude, report.latitude),
          ),
          image: image,
          iconImage: key,
          iconAnchor: mbx.IconAnchor.BOTTOM,
          iconSize: 1 / request.pixelRatio,
          symbolSortKey: 1,
          customData: <String, Object>{'kind': 'report', 'id': report.id},
        ),
      );
      _reportsById[report.id] = report;
    }

    final seismOptions = <mbx.PointAnnotationOptions>[];
    for (final event in request.events) {
      final key = MapMarkerIcons.seismicKey(event, request.pixelRatio);
      final image =
          _icons[key] ??
          await MapMarkerIcons.seismic(event, request.pixelRatio);
      if (_disposed) {
        return;
      }
      _icons[key] = image;
      seismOptions.add(
        mbx.PointAnnotationOptions(
          geometry: mbx.Point(
            coordinates: mbx.Position(event.longitude, event.latitude),
          ),
          image: image,
          iconImage: key,
          iconAnchor: mbx.IconAnchor.BOTTOM,
          iconSize: 1 / request.pixelRatio,
          symbolSortKey: 2 + event.magnitude,
          customData: <String, Object>{'kind': 'seismic', 'id': event.id},
        ),
      );
      _seismsById[event.id] = event;
    }

    await reports.deleteAll();
    if (_disposed) {
      return;
    }
    if (reportOptions.isNotEmpty) {
      await reports.createMulti(reportOptions);
    }

    await seisms.deleteAll();
    if (_disposed) {
      return;
    }
    if (seismOptions.isNotEmpty) {
      await seisms.createMulti(seismOptions);
    }

    await user.deleteAll();
    if (_disposed) {
      return;
    }

    final location = request.userLocation;
    if (location != null) {
      final key = MapMarkerIcons.userLocationKey(request.pixelRatio);
      final image =
          _icons[key] ?? await MapMarkerIcons.userLocation(request.pixelRatio);
      if (_disposed) {
        return;
      }
      _icons[key] = image;
      await user.create(
        mbx.PointAnnotationOptions(
          geometry: mbx.Point(
            coordinates: mbx.Position(location.longitude, location.latitude),
          ),
          image: image,
          iconImage: key,
          iconAnchor: mbx.IconAnchor.CENTER,
          iconSize: 1 / request.pixelRatio,
          symbolSortKey: 20,
          customData: const <String, Object>{'kind': 'user'},
        ),
      );
    }
  }

  String _signatureFor({
    required List<SeismicEvent> events,
    required List<CommunityReport> reports,
    required latlong.LatLng? userLocation,
    required double pixelRatio,
  }) {
    final buffer = StringBuffer()
      ..write(pixelRatio.toStringAsFixed(2))
      ..write('|');
    for (final report in reports) {
      buffer
        ..write(report.id)
        ..write(':')
        ..write(report.category.name)
        ..write(':')
        ..write(report.latitude)
        ..write(',')
        ..write(report.longitude)
        ..write(';');
    }
    buffer.write('||');
    for (final event in events) {
      buffer
        ..write(event.id)
        ..write(':')
        ..write(event.magnitudeLabel)
        ..write(':')
        ..write(event.latitude)
        ..write(',')
        ..write(event.longitude)
        ..write(';');
    }
    buffer.write('||');
    if (userLocation != null) {
      buffer
        ..write(userLocation.latitude)
        ..write(',')
        ..write(userLocation.longitude);
    }
    return buffer.toString();
  }

  String? _customId(mbx.PointAnnotation annotation) {
    final data = annotation.customData;
    if (data == null) {
      return null;
    }
    final id = data['id'];
    return id?.toString();
  }

  void dispose() {
    _disposed = true;
    _reportsTap?.cancel();
    _seismsTap?.cancel();
    _reportsTap = null;
    _seismsTap = null;
  }
}

class _MarkerRequest {
  const _MarkerRequest({
    required this.events,
    required this.reports,
    required this.userLocation,
    required this.pixelRatio,
  });

  final List<SeismicEvent> events;
  final List<CommunityReport> reports;
  final latlong.LatLng? userLocation;
  final double pixelRatio;
}
