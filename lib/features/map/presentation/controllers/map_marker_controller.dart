import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:latlong2/latlong.dart' as latlong;

import '../../../alerts/domain/entities/seismic_event.dart';
import '../../../community_reports/domain/entities/community_report.dart';
import '../widgets/map_markers.dart';

/// Owns the map marker bitmaps and turns domain entities into [Marker]s.
///
/// The view only provides the current data and the tap callbacks; caching,
/// asynchronous icon generation and z-index rules stay here.
class MapMarkerController {
  final Map<String, BitmapDescriptor> _icons = {};
  final Set<String> _pending = {};

  /// Schedules the generation of the icons that are not cached yet.
  ///
  /// [onReady] runs after the pending bitmaps resolve so the caller can
  /// rebuild the map. Generation starts after the current frame to avoid
  /// calling `setState` during `build`.
  void requestMissing({
    required List<SeismicEvent> events,
    required List<CommunityReport> reports,
    required bool hasUserLocation,
    required double pixelRatio,
    required VoidCallback onReady,
  }) {
    final requests = <String, Future<BitmapDescriptor>>{};

    void request(String key, Future<BitmapDescriptor> future) {
      if (_icons.containsKey(key) || _pending.contains(key)) {
        return;
      }
      requests[key] = future;
    }

    for (final event in events) {
      request(
        MapMarkerIcons.seismicKey(event, pixelRatio),
        MapMarkerIcons.seismic(event, pixelRatio),
      );
    }
    for (final report in reports) {
      request(
        MapMarkerIcons.reportKey(report, pixelRatio),
        MapMarkerIcons.report(report, pixelRatio),
      );
    }
    if (hasUserLocation) {
      request(
        MapMarkerIcons.userLocationKey(pixelRatio),
        MapMarkerIcons.userLocation(pixelRatio),
      );
    }

    if (requests.isEmpty) {
      return;
    }

    _pending.addAll(requests.keys);
    final pending = Map<String, Future<BitmapDescriptor>>.of(requests);

    WidgetsBinding.instance.addPostFrameCallback((_) async {
      final generated = <String, BitmapDescriptor>{};
      for (final entry in pending.entries) {
        try {
          generated[entry.key] = await entry.value;
        } catch (_) {
          // Skip the icon; it is retried on the next rebuild.
        }
      }
      _icons.addAll(generated);
      _pending.removeAll(pending.keys);
      onReady();
    });
  }

  /// Offsets overlapping or coincident report coordinates slightly so every
  /// report pin remains visible and interactive on the map.
  static Map<String, LatLng> computeReportPositions(
    List<CommunityReport> reports,
  ) {
    final positions = <String, LatLng>{};
    if (reports.isEmpty) {
      return positions;
    }

    // Cluster reports that are within ~15 meters of each other (~0.00014 degrees).
    const double clusterThreshold = 0.00014;
    final clusters = <List<CommunityReport>>[];

    for (final report in reports) {
      bool added = false;
      for (final cluster in clusters) {
        final reference = cluster.first;
        final dLat = (report.latitude - reference.latitude).abs();
        final dLng = (report.longitude - reference.longitude).abs();
        if (dLat < clusterThreshold && dLng < clusterThreshold) {
          cluster.add(report);
          added = true;
          break;
        }
      }
      if (!added) {
        clusters.add([report]);
      }
    }

    for (final cluster in clusters) {
      if (cluster.length == 1) {
        final single = cluster.first;
        positions[single.id] = LatLng(single.latitude, single.longitude);
        continue;
      }

      // Compute cluster centroid
      double sumLat = 0.0;
      double sumLng = 0.0;
      for (final r in cluster) {
        sumLat += r.latitude;
        sumLng += r.longitude;
      }
      final centerLat = sumLat / cluster.length;
      final centerLng = sumLng / cluster.length;

      // Disperse coincident markers evenly in a small circle (~12m radius)
      const double radius = 0.00011;
      final latRad = centerLat * (math.pi / 180.0);
      final lngScale = math.cos(latRad).abs().clamp(0.2, 1.0);

      for (var i = 0; i < cluster.length; i++) {
        final angle = (2 * math.pi * i) / cluster.length;
        final offsetLat = radius * math.cos(angle);
        final offsetLng = (radius * math.sin(angle)) / lngScale;
        positions[cluster[i].id] = LatLng(
          centerLat + offsetLat,
          centerLng + offsetLng,
        );
      }
    }

    return positions;
  }

  /// Builds every marker that already has a cached icon.
  Set<Marker> buildMarkers({
    required List<SeismicEvent> events,
    required List<CommunityReport> reports,
    required latlong.LatLng? userLocation,
    required double pixelRatio,
    required ValueChanged<CommunityReport> onReportTap,
    required ValueChanged<SeismicEvent> onSeismicTap,
  }) {
    final markers = <Marker>{};
    final reportPositions = computeReportPositions(reports);

    for (var index = 0; index < reports.length; index++) {
      final report = reports[index];
      final icon = _icons[MapMarkerIcons.reportKey(report, pixelRatio)];
      if (icon == null) {
        continue;
      }
      final position =
          reportPositions[report.id] ??
          LatLng(report.latitude, report.longitude);

      markers.add(
        Marker(
          markerId: MarkerId('report-${report.id}'),
          position: position,
          icon: icon,
          anchor: const Offset(0.5, 1),
          consumeTapEvents: true,
          infoWindow: InfoWindow.noText,
          zIndexInt: 5 + (reports.length - index),
          onTap: () => onReportTap(report),
        ),
      );
    }

    for (final event in events) {
      final icon = _icons[MapMarkerIcons.seismicKey(event, pixelRatio)];
      if (icon == null) {
        continue;
      }
      markers.add(
        Marker(
          markerId: MarkerId('seismic-${event.id}'),
          position: LatLng(event.latitude, event.longitude),
          icon: icon,
          anchor: const Offset(0.5, 1),
          consumeTapEvents: true,
          infoWindow: InfoWindow.noText,
          zIndexInt: 2 + event.magnitude.round(),
          onTap: () => onSeismicTap(event),
        ),
      );
    }

    if (userLocation != null) {
      final icon = _icons[MapMarkerIcons.userLocationKey(pixelRatio)];
      if (icon != null) {
        markers.add(
          Marker(
            markerId: const MarkerId('user-location'),
            position: LatLng(userLocation.latitude, userLocation.longitude),
            icon: icon,
            anchor: const Offset(0.5, 0.5),
            consumeTapEvents: false,
            infoWindow: InfoWindow.noText,
            zIndexInt: 20,
          ),
        );
      }
    }

    return markers;
  }
}
