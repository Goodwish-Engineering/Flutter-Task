import 'package:flutter/material.dart';
 import 'package:task/core/utils/device_dimension.dart';

class SpacingUtils {
  static Widget verticalGap(BuildContext context) {
    return SizedBox(
      height: context.responsive(
        mobile: context.screenHeight * 0.02,
        tablet: context.screenHeight * 0.025,
        desktop: context.screenHeight * 0.03,
      ),
    );
  }

  static Widget horizontalGap(BuildContext context) {
    return SizedBox(width: getHorizontalGapWidth(context));
  }

  static double getHorizontalGapWidth(BuildContext context) {
    return context.responsive(
      mobile: context.screenWidth * 0.02,
      tablet: context.screenWidth * 0.03,
      desktop: context.screenWidth * 0.04,
    );
  }

  static EdgeInsets horizontalPadding(BuildContext context) {
    return EdgeInsets.symmetric(
      horizontal: context.responsive(
        mobile: context.screenWidth * 0.05,
        tablet: context.screenWidth * 0.07,
        desktop: context.screenWidth * 0.1,
      ),
    );
  }
}
