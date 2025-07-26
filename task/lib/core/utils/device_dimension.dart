import 'package:flutter/material.dart';

extension DeviceDimension on BuildContext {
  bool get isMobile => MediaQuery.of(this).size.width < 600;

  bool get isTablet =>
      MediaQuery.of(this).size.width >= 600 &&
      MediaQuery.of(this).size.width < 900;

  bool get isDesktop => MediaQuery.of(this).size.width >= 900;

  double get screenWidth => MediaQuery.of(this).size.width;

  double get screenHeight => MediaQuery.of(this).size.height;

  T responsive<T>({required T mobile, T? tablet, T? desktop}) {
    if (isDesktop && desktop != null) {
      return desktop;
    } else if (isTablet && tablet != null) {
      return tablet;
    } else {
      return mobile;
    }
  }
}
