import 'package:flutter/material.dart';
import 'package:pingvite/core/theme/app_colors.dart';

@immutable
class AppImageTheme extends ThemeExtension<AppImageTheme> {
  final Color iconColor;

  const AppImageTheme({required this.iconColor});

  @override
  AppImageTheme copyWith({Color? iconColor}) {
    return AppImageTheme(iconColor: iconColor ?? this.iconColor);
  }

  @override
  AppImageTheme lerp(AppImageTheme? other, double t) {
    if (other is! AppImageTheme) {
      return this;
    }
    return AppImageTheme(iconColor: Color.lerp(iconColor, other.iconColor, t)!);
  }

  // Light theme
  static const light = AppImageTheme(iconColor: AppColors.lightPrimaryText);

  // Dark theme
  static const dark = AppImageTheme(iconColor: AppColors.darkPrimaryText);
}
