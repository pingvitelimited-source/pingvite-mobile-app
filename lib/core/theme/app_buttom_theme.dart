import 'package:flutter/material.dart';

@immutable
class AppButtonTheme extends ThemeExtension<AppButtonTheme> {
  final Color primaryButtonColor;
  final Color primaryButtonTextColor;
  final Color borderColor;
  final Color focusedBorderColor;
  final Color fillColor;

  const AppButtonTheme({
    required this.primaryButtonColor,
    required this.primaryButtonTextColor,
    required this.borderColor,
    required this.focusedBorderColor,
    required this.fillColor,
  });

  @override
  AppButtonTheme copyWith({
    Color? primaryButtonColor,
    Color? primaryButtonTextColor,
    Color? borderColor,
    Color? focusedBorderColor,
    Color? fillColor,
  }) {
    return AppButtonTheme(
      primaryButtonColor: primaryButtonColor ?? this.primaryButtonColor,
      primaryButtonTextColor:
          primaryButtonTextColor ?? this.primaryButtonTextColor,
      borderColor: borderColor ?? this.borderColor,
      focusedBorderColor: focusedBorderColor ?? this.focusedBorderColor,
      fillColor: fillColor ?? this.fillColor,
    );
  }

  @override
  AppButtonTheme lerp(AppButtonTheme? other, double t) {
    if (other is! AppButtonTheme) return this;
    return AppButtonTheme(
      primaryButtonColor: Color.lerp(
        primaryButtonColor,
        other.primaryButtonColor,
        t,
      )!,
      primaryButtonTextColor: Color.lerp(
        primaryButtonTextColor,
        other.primaryButtonTextColor,
        t,
      )!,
      borderColor: Color.lerp(borderColor, other.borderColor, t)!,
      focusedBorderColor: Color.lerp(
        focusedBorderColor,
        other.focusedBorderColor,
        t,
      )!,
      fillColor: Color.lerp(fillColor, other.fillColor, t)!,
    );
  }

  static const light = AppButtonTheme(
    primaryButtonColor: Color(0xFFE53E3E),
    primaryButtonTextColor: Colors.white,
    borderColor: Color(0xFFE0E0E0),
    focusedBorderColor: Color(0xFF6366F1),
    fillColor: Color(0xFFF9FAFB),
  );

  static const dark = AppButtonTheme(
    primaryButtonColor: Color(0xFFE53E3E),
    primaryButtonTextColor: Colors.white,
    borderColor: Color(0xFF404040),
    focusedBorderColor: Color(0xFF8B5CF6),
    fillColor: Color(0xFF1F1F1F),
  );
}
