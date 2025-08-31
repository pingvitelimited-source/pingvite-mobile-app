import 'package:flutter/material.dart';
import 'package:pingvite/core/theme/app_colors.dart';
import 'package:pingvite/core/utils/sizeconfig.dart';
import 'package:pingvite/service_locator_dependencies.dart';

@immutable
class AppTextTheme extends ThemeExtension<AppTextTheme> {
  final TextStyle heading;
  final TextStyle subheading;
  final TextStyle body;
  final TextStyle accent;

  const AppTextTheme({
    required this.heading,
    required this.subheading,
    required this.body,
    required this.accent,
  });

  @override
  AppTextTheme copyWith({
    TextStyle? heading,
    TextStyle? subheading,
    TextStyle? body,
    TextStyle? accent,
  }) {
    return AppTextTheme(
      heading: heading ?? this.heading,
      subheading: subheading ?? this.subheading,
      body: body ?? this.body,
      accent: accent ?? this.accent,
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
    );
  }

  // Light theme text styles
  static AppTextTheme light = AppTextTheme(
    heading: TextStyle(
      fontSize: sl<SizeConfig>().rpx(24),
      fontWeight: FontWeight.w600,
      color: AppColors.lightPrimaryText,
    ),
    subheading: TextStyle(
      fontSize: sl<SizeConfig>().rpx(16),
      fontWeight: FontWeight.w500,
      color: AppColors.lightSecondaryText,
    ),
    body: TextStyle(
      fontSize: sl<SizeConfig>().rpx(14),
      fontWeight: FontWeight.w400,
      color: AppColors.lightPrimaryText,
    ),
    accent: TextStyle(
      fontSize: sl<SizeConfig>().rpx(12),
      fontWeight: FontWeight.w500,
      color: AppColors.lightSecondaryText,
    ),
  );

  // Dark theme text styles
  static AppTextTheme dark = AppTextTheme(
    heading: TextStyle(
      fontSize: sl<SizeConfig>().rpx(24),
      fontWeight: FontWeight.w600,
      color: AppColors.darkPrimaryText,
    ),
    subheading: TextStyle(
      fontSize: sl<SizeConfig>().rpx(16),
      fontWeight: FontWeight.w500,
      color: AppColors.darkSecondaryText,
    ),
    body: TextStyle(
      fontSize: sl<SizeConfig>().rpx(14),
      fontWeight: FontWeight.w400,
      color: AppColors.darkPrimaryText,
    ),
    accent: TextStyle(
      fontSize: sl<SizeConfig>().rpx(16),
      fontWeight: FontWeight.w600,
      color: AppColors.darkAccentText,
    ),
  );
}
