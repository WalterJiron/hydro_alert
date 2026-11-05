import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/network/network_providers.dart';
import '../datasources/rainviewer_datasource.dart';

final rainViewerDataSourceProvider = Provider<RainViewerDataSource>((ref) {
  return RainViewerDataSource(ref.watch(rainViewerDioProvider));
});
