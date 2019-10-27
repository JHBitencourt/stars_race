import 'package:flutter/foundation.dart'
    show debugDefaultTargetPlatformOverride, kIsWeb;
import 'package:flutter/material.dart';
import 'package:stars_race/src/app.dart';

void main()  {
  if(!kIsWeb && debugDefaultTargetPlatformOverride == null) {
    debugDefaultTargetPlatformOverride = TargetPlatform.fuchsia;
  }
  print(debugDefaultTargetPlatformOverride);

  runApp(MyApp());
}

/// This doesn't work on web, more at https://github.com/flutter/flutter/issues/36126
//void _updateTargetPlatform() {
//  TargetPlatform targetPlatform;
//  if (Platform.isMacOS) {
//    targetPlatform = TargetPlatform.iOS;
//  } else if (Platform.isLinux || Platform.isWindows) {
//    targetPlatform = TargetPlatform.android;
//  }
//  if (targetPlatform != null) {
//    debugDefaultTargetPlatformOverride = targetPlatform;
//  }
//}
