import 'package:flutter/material.dart';

class AppColors {
  //// Background colors
  static const Color lightbackground = Color(0xFFF8FBFF);
  static const Color darkBackground = Color(0xFF0D2541);

  // Text colors that adapt to theme
  static const Color lightPrimaryText = Color(0xFF333333);
  static const Color darkPrimaryText = Color(0xFFFFFFFF);

  static const Color lightSecondaryText = Color(0xFF666666);
  static const Color darkSecondaryText = Color(0xFFB3B3B3);

  static const Color lightAccentText = Color(0xFF1976D2);
  static const Color darkAccentText = Color(0xFF64B5F6);

  //Gradient Button Color
  static const Color lightGradient = Color(0xFFDF2A2C);
  static const Color darkGradient = Color(0xFF4611C2);

  //basic colors
  static const Color white = Colors.white;
  static const Color black = Colors.black;
  static const Color black100 = Color(0xFF000738);
  static const Color red = Colors.red;
  static const Color blue = Color(0xFF61A0FF);
  static const Color homebackground = Color(0xFFF0FAFE);
  static const Color greenColor = Color(0xFF4BD670);
  static const Color circleColor1 = Color(0xFFBD0D6A);
  static const Color labelPink = Color(0xFFBD0D6A);
  static const Color labelBlue = Color(0xFF1F78D5);
  static const Color imageUploadCardColor = Color(0xFFE8EAEC);
  static const Color grey = Color(0xFF2F2E36);
  static const Color transparent = Color(0x00000000);

  //bottombar app color
  static const Color selectedTab = Color(0xFF61A0FF);
  static const Color unSelectedTabText = Color(0x66666666);

  //Appbar Color
  static const Color greetingColor = Color(0xFFFECF24);

  // Section header colors
  static const Color lightSectionBackground = Color(0xFFF5F5F5);
  static const Color darkSectionBackground = Color(0xFF2A2A2A);

  // Blue color opacity variants
  static Color get blueLightAlpha08 => blue.withValues(alpha: 0.08);
  static Color get blueLightAlpha12 => blue.withValues(alpha: 0.12);
  static Color get blueLightAlpha15 => blue.withValues(alpha: 0.15);
  static Color get blueLightAlpha25 => blue.withValues(alpha: 0.25);

  // Icon badge backgrounds
  static const Color iconBadgeBackground = Color(0xFFE3F2FD);
  static const Color iconBadgeBackgroundDark = Color(0xFF1A237E);

  // Card border color
  static const Color cardBorderLight = Color(0xFFE0E0E0);
  static const Color cardBorderDark = Color(0xFF424242);
}
