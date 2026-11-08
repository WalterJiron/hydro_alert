import 'package:url_launcher/url_launcher.dart';

/// Opens [url] in the platform browser.
///
/// Returns `false` when the URL cannot be parsed or the platform has no
/// application able to handle it, so callers can show their own feedback.
Future<bool> openExternalUrl(String url) async {
  final uri = Uri.tryParse(url);
  if (uri == null) {
    return false;
  }

  try {
    return await launchUrl(uri, mode: LaunchMode.externalApplication);
  } catch (_) {
    return false;
  }
}
