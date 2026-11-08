import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../data/tile_providers/rainviewer_tile_provider.dart';

/// Keeps a single RainViewer [TileProvider] alive while the radar template
/// does not change, so Google Maps reuses cached tiles between rebuilds.
class RadarOverlayController {
  RainViewerTileProvider? _provider;
  String? _template;

  TileOverlay overlayFor(String tileUrlTemplate) {
    if (_provider == null || _template != tileUrlTemplate) {
      _provider = RainViewerTileProvider(tileUrlTemplate: tileUrlTemplate);
      _template = tileUrlTemplate;
    }

    return TileOverlay(
      tileOverlayId: const TileOverlayId('rainviewer-radar'),
      tileProvider: _provider!,
      transparency: 0.2,
      fadeIn: true,
      zIndex: 1,
    );
  }
}
