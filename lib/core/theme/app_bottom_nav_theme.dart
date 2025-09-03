import 'package:flutter/material.dart';
import 'package:pingvite/core/theme/app_colors.dart';

@immutable
class AppBottomNavTheme extends ThemeExtension<AppBottomNavTheme> {
  final Color selectedColor;
  final Color unselectedColor;
  final Color backgroundColor;

  const AppBottomNavTheme({
    required this.selectedColor,
    required this.unselectedColor,
    required this.backgroundColor,
  });

  @override
  AppBottomNavTheme copyWith({
    Color? selectedColor,
    Color? unselectedColor,
    Color? backgroundColor,
  }) {
    return AppBottomNavTheme(
      selectedColor: selectedColor ?? this.selectedColor,
      unselectedColor: unselectedColor ?? this.unselectedColor,
      backgroundColor: backgroundColor ?? this.backgroundColor,
    );
  }

  @override
  AppBottomNavTheme lerp(AppBottomNavTheme? other, double t) {
    if (other is! AppBottomNavTheme) return this;
    return AppBottomNavTheme(
      selectedColor: Color.lerp(selectedColor, other.selectedColor, t)!,
      unselectedColor: Color.lerp(unselectedColor, other.unselectedColor, t)!,
      backgroundColor: Color.lerp(backgroundColor, other.backgroundColor, t)!,
    );
  }

  static const light = AppBottomNavTheme(
    selectedColor: AppColors.selectedTab,
    unselectedColor: AppColors.lightSecondaryText,
    backgroundColor: Colors.white,
  );

  static const dark = AppBottomNavTheme(
    selectedColor: AppColors.darkAccentText,
    unselectedColor: AppColors.darkSecondaryText,
    backgroundColor: Color(0xFF1E1E1E),
  );
}
