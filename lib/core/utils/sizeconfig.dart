import 'package:flutter/material.dart';

class SizeConfig {
  static late double screenWidth;
  static late double screenHeight;
  static late double scaleFactorHeight;
  static late double scaleFactorWidth;
  static late double scaleFactor;

  void init(
    BuildContext context, {
    double referenceHeight = 812,
    double referenceWidth = 375,
  }) {
    screenWidth = MediaQuery.of(context).size.width;
    screenHeight = MediaQuery.of(context).size.height;

    scaleFactorHeight = screenHeight / referenceHeight;
    scaleFactorWidth = screenWidth / referenceWidth;

    // 🔥 ONE scale to rule them all
    scaleFactor = scaleFactorHeight < scaleFactorWidth
        ? scaleFactorHeight
        : scaleFactorWidth;

    // cap so tablets don’t explode UI
    if (scaleFactor > 1.4) scaleFactor = 1.4;
  }

  // Base scale
  double rpx(double px) => px * scaleFactor;

  // Icons slightly restrained
  double isz(double px) => px * (scaleFactor * 0.95);

  // Text should scale less aggressively
  double sp(double px) => px * (scaleFactor * 0.9);

  // Gaps should feel natural
  double gap(double px) => px * (scaleFactor * 0.85);

  double h(double percent) => screenHeight * percent / 100;
  double w(double percent) => screenWidth * percent / 100;
}
