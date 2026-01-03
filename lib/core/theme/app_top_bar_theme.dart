import 'package:flutter/material.dart';
import 'app_colors.dart';

@immutable
class AppTopBarTheme extends ThemeExtension<AppTopBarTheme> {
  const AppTopBarTheme({
    required this.backgroundColor,
    required this.titleColor,
    required this.greetingColor,
    required this.iconColor,
    required this.bellBackgroundColor,
    required this.backButtonColor,
    required this.backButtonIconColor,
    required this.elevation,
  });

  final Color backgroundColor;
  final Color titleColor;
  final Color greetingColor;
  final Color iconColor;
  final Color bellBackgroundColor;
  final Color backButtonColor;
  final Color backButtonIconColor;
  final double elevation;

  static const AppTopBarTheme light = AppTopBarTheme(
    backgroundColor: AppColors.lightbackground,
    titleColor: AppColors.darkBackground,
    greetingColor: AppColors.greetingColor,
    iconColor: AppColors.darkBackground,
    bellBackgroundColor: AppColors.white,
    backButtonColor: AppColors.white,
    backButtonIconColor: AppColors.darkBackground,
    elevation: 0,
  );

  static const AppTopBarTheme dark = AppTopBarTheme(
    backgroundColor: AppColors.darkBackground,
    titleColor: AppColors.lightbackground,
    greetingColor: AppColors.greetingColor,
    iconColor: AppColors.lightbackground,
    bellBackgroundColor: AppColors.grey,
    backButtonColor: AppColors.white,
    backButtonIconColor: AppColors.darkBackground,
    elevation: 0,
  );

  @override
  AppTopBarTheme copyWith({
    Color? backgroundColor,
    Color? titleColor,
    Color? greetingColor,
    Color? iconColor,
    Color? bellBackgroundColor,
    Color? backButtonColor,
    Color? backButtonIconColor,
    double? elevation,
  }) {
    return AppTopBarTheme(
      backgroundColor: backgroundColor ?? this.backgroundColor,
      titleColor: titleColor ?? this.titleColor,
      greetingColor: greetingColor ?? this.greetingColor,
      iconColor: iconColor ?? this.iconColor,
      bellBackgroundColor: bellBackgroundColor ?? this.bellBackgroundColor,
      backButtonColor: backButtonColor ?? this.backButtonColor,
      backButtonIconColor: backButtonIconColor ?? this.backButtonIconColor,
      elevation: elevation ?? this.elevation,
    );
  }

  @override
  AppTopBarTheme lerp(AppTopBarTheme? other, double t) {
    if (other is! AppTopBarTheme) return this;
    return AppTopBarTheme(
      backgroundColor: Color.lerp(backgroundColor, other.backgroundColor, t)!,
      titleColor: Color.lerp(titleColor, other.titleColor, t)!,
      greetingColor: Color.lerp(greetingColor, other.greetingColor, t)!,
      iconColor: Color.lerp(iconColor, other.iconColor, t)!,
      bellBackgroundColor: Color.lerp(
        bellBackgroundColor,
        other.bellBackgroundColor,
        t,
      )!,
      backButtonColor: Color.lerp(backButtonColor, other.backButtonColor, t)!,
      backButtonIconColor: Color.lerp(
        backButtonIconColor,
        other.backButtonIconColor,
        t,
      )!,
      elevation: lerpDouble(elevation, other.elevation, t) ?? elevation,
    );
  }

  double? lerpDouble(double? a, double? b, double t) {
    if (a == null && b == null) return null;
    a ??= 0.0;
    b ??= 0.0;
    return a + (b - a) * t;
  }
}
