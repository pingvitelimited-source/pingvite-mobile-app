import 'package:flutter/widgets.dart';

class SizeConfig {
  static late double screenWidth;
  static late double screenHeight;
  static late double scaleFactorHeight;
  static late double scaleFactorWidth;

  void init(
    BuildContext context, {
    double referenceHeight = 812,
    double referenceWidth = 375,
  }) {
    screenWidth = MediaQuery.of(context).size.width;
    screenHeight = MediaQuery.of(context).size.height;

    scaleFactorHeight = screenHeight / referenceHeight;
    scaleFactorWidth = screenWidth / referenceWidth;
  }

  double rpx(double px) {
    return px * scaleFactorHeight;
  }

  double iconSize(double px) {
    double minScale = scaleFactorHeight < scaleFactorWidth
        ? scaleFactorHeight
        : scaleFactorWidth;
    minScale = minScale > 1.5 ? 1.5 : minScale;
    return px * minScale;
  }

  double h(double percent) => screenHeight * percent / 100;
  double w(double percent) => screenWidth * percent / 100;
}
