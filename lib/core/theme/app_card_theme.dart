import 'dart:ui';

import 'package:flutter/material.dart';
import 'app_colors.dart';

class AppCardTheme extends ThemeExtension<AppCardTheme> {
  final Color backgroundColor;
  final Color borderColor;
  final double borderRadius;
  final double elevation;

  const AppCardTheme({
    required this.backgroundColor,
    required this.borderColor,
    required this.borderRadius,
    required this.elevation,
  });

  @override
  AppCardTheme copyWith({
    Color? backgroundColor,
    Color? borderColor,
    double? borderRadius,
    double? elevation,
  }) {
    return AppCardTheme(
      backgroundColor: backgroundColor ?? this.backgroundColor,
      borderColor: borderColor ?? this.borderColor,
      borderRadius: borderRadius ?? this.borderRadius,
      elevation: elevation ?? this.elevation,
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
    );
  }

  static const light = AppCardTheme(
    backgroundColor: Colors.white,
    borderColor: AppColors.lightSecondaryText,
    borderRadius: 18,
    elevation: 2,
  );

  static const dark = AppCardTheme(
    backgroundColor: Color(0xFF2C2C2C),
    borderColor: AppColors.darkSecondaryText,
    borderRadius: 18,
    elevation: 2,
  );
}
