import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class SizeConfig {
  final MediaQueryData mediaQueryData;

  SizeConfig(this.mediaQueryData);

  static SizeConfig of(BuildContext context) =>
      SizeConfig(MediaQuery.of(context));

  double dynamicScaleSize(
    double size, {
    double scaleFactorWeb = 1.2,
    double scaleFactorTablet = 1.1,
    double scaleFactorMini = 0.8,
  }) {
    if (kIsWeb) return size * scaleFactorWeb;
    if (isTablet()) return size * scaleFactorTablet;
    if (isMini()) return size * scaleFactorMini;
    return size;
  }

  /// Defines device type based on logical device pixels. Bigger than 600 means it is a tablet
  bool isTablet() {
    final shortestSide = mediaQueryData.size.shortestSide;
    return shortestSide > 600;
  }

  /// Defines device type based on logical device pixels. Less or equal than 320 means it is a mini device
  bool isMini() {
    final shortestSide = mediaQueryData.size.shortestSide;
    return shortestSide <= 320;
  }
}
