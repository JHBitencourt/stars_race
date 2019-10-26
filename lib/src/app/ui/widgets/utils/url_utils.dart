import 'package:flutter/foundation.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:universal_html/html.dart' as html;

void launchURL(String url) async {
  if(kIsWeb) {
    html.window.open(url, '');
    return;
  }

  if (await canLaunch(url)) {
    await launch(url);
  }
}