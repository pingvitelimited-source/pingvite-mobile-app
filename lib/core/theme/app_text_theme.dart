import 'package:flutter/material.dart';
import 'package:pingvite/core/theme/app_colors.dart';

@immutable
class AppTextTheme extends ThemeExtension<AppTextTheme> {
  final TextStyle heading;
  final TextStyle subheading;
  final TextStyle body;
  final TextStyle accent;
  final TextStyle body1;
  final TextStyle body2;
  final TextStyle semiBold;
  final TextStyle bold;

  const AppTextTheme({
    required this.heading,
    required this.subheading,
    required this.body,
    required this.accent,
    required this.body1,
    required this.body2,
    required this.semiBold,
    required this.bold,
  });

  @override
  AppTextTheme copyWith({
    TextStyle? heading,
    TextStyle? subheading,
    TextStyle? body,
    TextStyle? accent,
    TextStyle? body1,
    TextStyle? body2,
    TextStyle? semiBold,
    TextStyle? bold,
  }) {
    return AppTextTheme(
      heading: heading ?? this.heading,
      subheading: subheading ?? this.subheading,
      body: body ?? this.body,
      accent: accent ?? this.accent,
      body1: body1 ?? this.body1,
      body2: body2 ?? this.body2,
      semiBold: semiBold ?? this.semiBold,
      bold: bold ?? this.bold,
    );
  }

  @override
  AppTextTheme lerp(AppTextTheme? other, double t) {
    if (other is! AppTextTheme) {
      return this;
    }
    return AppTextTheme(
      heading: TextStyle.lerp(heading, other.heading, t)!,
      subheading: TextStyle.lerp(subheading, other.subheading, t)!,
      body: TextStyle.lerp(body, other.body, t)!,
      accent: TextStyle.lerp(accent, other.accent, t)!,
      body1: TextStyle.lerp(body1, other.body1, t)!,
      body2: TextStyle.lerp(body2, other.body2, t)!,
      semiBold: TextStyle.lerp(semiBold, other.semiBold, t)!,
      bold: TextStyle.lerp(bold, other.bold, t)!,
    );
  }

  // Light theme text styles - using fixed sizes, scaling handled elsewhere
  static const AppTextTheme light = AppTextTheme(
    heading: TextStyle(
      fontFamily: 'Libre Franklin',
      fontSize: 24,
      fontWeight: FontWeight.w600,
      color: AppColors.lightPrimaryText,
    ),
    subheading: TextStyle(
      fontFamily: 'Libre Franklin',
      fontSize: 16,
      fontWeight: FontWeight.w500,
      color: AppColors.lightSecondaryText,
    ),
    body: TextStyle(
      fontFamily: 'Libre Franklin',
      fontSize: 14,
      fontWeight: FontWeight.w400,
      color: AppColors.lightPrimaryText,
    ),
    accent: TextStyle(
      fontFamily: 'Libre Franklin',
      fontSize: 12,
      fontWeight: FontWeight.w500,
      color: AppColors.lightSecondaryText,
    ),
    body1: TextStyle(
      fontFamily: 'Libre Franklin',
      fontSize: 10,
      fontWeight: FontWeight.w500,
      color: AppColors.darkPrimaryText,
    ),
    body2: TextStyle(
      fontFamily: 'Libre Franklin',
      fontSize: 18,
      fontWeight: FontWeight.w500,
      color: AppColors.lightPrimaryText,
    ),
    semiBold: TextStyle(
      fontFamily: 'Libre Franklin',
      fontSize: 16,
      fontWeight: FontWeight.w600,
      color: AppColors.lightPrimaryText,
    ),
    bold: TextStyle(
      fontFamily: 'Libre Franklin',
      fontSize: 20,
      fontWeight: FontWeight.bold,
      color: AppColors.darkPrimaryText,
    ),
  );

  // Dark theme text styles
  static const AppTextTheme dark = AppTextTheme(
    heading: TextStyle(
      fontFamily: 'Libre Franklin',
      fontSize: 24,
      fontWeight: FontWeight.w600,
      color: AppColors.darkPrimaryText,
    ),
    subheading: TextStyle(
      fontFamily: 'Libre Franklin',
      fontSize: 16,
      fontWeight: FontWeight.w500,
      color: AppColors.darkSecondaryText,
    ),
    body: TextStyle(
      fontFamily: 'Libre Franklin',
      fontSize: 14,
      fontWeight: FontWeight.w400,
      color: AppColors.darkPrimaryText,
    ),
    accent: TextStyle(
      fontFamily: 'Libre Franklin',
      fontSize: 16,
      fontWeight: FontWeight.w600,
      color: AppColors.darkAccentText,
    ),
    body1: TextStyle(
      fontFamily: 'Libre Franklin',
      fontSize: 10,
      fontWeight: FontWeight.w500,
      color: AppColors.darkPrimaryText,
    ),
    body2: TextStyle(
      fontFamily: 'Libre Franklin',
      fontSize: 18,
      fontWeight: FontWeight.w500,
      color: AppColors.darkPrimaryText,
    ),
    semiBold: TextStyle(
      fontFamily: 'Libre Franklin',
      fontSize: 16,
      fontWeight: FontWeight.w600,
      color: AppColors.darkPrimaryText,
    ),
    bold: TextStyle(
      fontFamily: 'Libre Franklin',
      fontSize: 20,
      fontWeight: FontWeight.bold,
      color: AppColors.darkPrimaryText,
    ),
  );
}
