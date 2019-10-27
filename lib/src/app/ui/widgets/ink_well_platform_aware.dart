import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:stars_race/src/app/ui/widgets/hover_aware.dart';

class InkWellPlatformAware extends InkWell {
  InkWellPlatformAware({
    Key key,
    Widget child,
    GestureTapCallback onTap,
  }) : super(
          key: key,
          child: !kIsWeb ? child : HoverAware(child: child),
          onTap: onTap,
        );
}
