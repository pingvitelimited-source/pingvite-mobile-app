import 'dart:ui';

import 'package:flutter/material.dart';
import 'app_colors.dart';

class AppCardTheme extends ThemeExtension<AppCardTheme> {
  final Color backgroundColor;
  final Color borderColor;
  final double borderRadius;
  final double elevation;
  final Color sectionLabelColor;
  final Color mapBackgroundColor;
  final Color screenBackgroundColor;

  const AppCardTheme({
    required this.backgroundColor,
    required this.borderColor,
    required this.borderRadius,
    required this.elevation,
    required this.sectionLabelColor,
    required this.mapBackgroundColor,
    required this.screenBackgroundColor,
  });

  @override
  AppCardTheme copyWith({
    Color? backgroundColor,
    Color? borderColor,
    double? borderRadius,
    double? elevation,
    Color? sectionLabelColor,
    Color? mapBackgroundColor,
    Color? screenBackgroundColor,
  }) {
    return AppCardTheme(
      backgroundColor: backgroundColor ?? this.backgroundColor,
      borderColor: borderColor ?? this.borderColor,
      borderRadius: borderRadius ?? this.borderRadius,
      elevation: elevation ?? this.elevation,
      sectionLabelColor: sectionLabelColor ?? this.sectionLabelColor,
      mapBackgroundColor: mapBackgroundColor ?? this.mapBackgroundColor,
      screenBackgroundColor:
          screenBackgroundColor ?? this.screenBackgroundColor,
    );
  }

  @override
  AppCardTheme lerp(AppCardTheme? other, double t) {
    if (other is! AppCardTheme) return this;
    return AppCardTheme(
      backgroundColor: Color.lerp(backgroundColor, other.backgroundColor, t)!,
      borderColor: Color.lerp(borderColor, other.borderColor, t)!,
      borderRadius: lerpDouble(borderRadius, other.borderRadius, t)!,
      elevation: lerpDouble(elevation, other.elevation, t)!,
      sectionLabelColor: Color.lerp(
        sectionLabelColor,
        other.sectionLabelColor,
        t,
      )!,
      mapBackgroundColor: Color.lerp(
        mapBackgroundColor,
        other.mapBackgroundColor,
        t,
      )!,
      screenBackgroundColor: Color.lerp(
        screenBackgroundColor,
        other.screenBackgroundColor,
        t,
      )!,
    );
  }

  static const light = AppCardTheme(
    backgroundColor: Colors.white,
    borderColor: AppColors.lightSecondaryText,
    borderRadius: 18,
    elevation: 2,
    sectionLabelColor: AppColors.lightPrimaryText,
    mapBackgroundColor: AppColors.homebackground,
    screenBackgroundColor: AppColors.homebackground,
  );

  static const dark = AppCardTheme(
    backgroundColor: Color(0xFF2C2C2C),
    borderColor: AppColors.darkSecondaryText,
    borderRadius: 18,
    elevation: 2,
    sectionLabelColor: AppColors.darkPrimaryText,
    mapBackgroundColor: Color(0xFF3A3A3A),
    screenBackgroundColor: AppColors.darkBackground,
  );
}
