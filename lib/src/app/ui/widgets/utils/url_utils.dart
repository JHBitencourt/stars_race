import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:universal_html/html.dart' as html;

void launchURL(String url) async {
  /// Checking web first, because running Platform.is on web throws error
  if(kIsWeb) {
    html.window.open(url, '');
    return;
  }

  if(Platform.isWindows || Platform.isLinux || Platform.isMacOS) {
    await launch(url);
    return;
  }

  if (await canLaunch(url)) {
    await launch(url);
  }
}