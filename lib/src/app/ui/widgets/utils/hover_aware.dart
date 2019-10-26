import 'package:flutter/gestures.dart';
import 'package:flutter/widgets.dart';
import 'package:universal_html/html.dart' as html;

class HoverAware extends Listener {
  static final bodyContainer =
      html.window.document.getElementById('body-container');

  HoverAware({Widget child})
      : super(
          onPointerHover: (PointerHoverEvent evt) {
            bodyContainer.style.cursor = 'pointer';
          },
          onPointerExit: (PointerExitEvent evt) {
            bodyContainer.style.cursor = 'default';
          },
          child: child,
        );
}
