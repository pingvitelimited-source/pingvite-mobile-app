import 'package:flutter/material.dart';
import 'package:pingvite/core/theme/app_colors.dart';

/// Centralized helper for theme-aware colors and utilities.
/// Use this instead of manually checking isDarkMode everywhere.
class ThemeHelper {
  ThemeHelper._();

  /// Check if the current theme is dark mode
  static bool isDarkMode(BuildContext context) {
    return Theme.of(context).brightness == Brightness.dark;
  }

  /// Get the primary text color based on current theme
  /// Use for main text on scaffold backgrounds
  static Color primaryTextColor(BuildContext context) {
    return isDarkMode(context)
        ? AppColors.darkPrimaryText
        : AppColors.lightPrimaryText;
  }

  /// Get the secondary text color based on current theme
  /// Use for subtitles, hints, less prominent text
  static Color secondaryTextColor(BuildContext context) {
    return isDarkMode(context)
        ? AppColors.darkSecondaryText
        : AppColors.lightSecondaryText;
  }

  /// Get the scaffold/screen background color based on current theme
  static Color backgroundColor(BuildContext context) {
    return isDarkMode(context)
        ? AppColors.darkBackground
        : AppColors.lightbackground;
  }

  /// Get the icon color based on current theme
  static Color iconColor(BuildContext context) {
    return isDarkMode(context)
        ? AppColors.darkPrimaryText
        : AppColors.lightPrimaryText;
  }

  /// Colors for content on white/light card backgrounds
  /// Always returns dark colors regardless of theme
  static Color cardPrimaryTextColor() => AppColors.lightPrimaryText;
  static Color cardSecondaryTextColor() => AppColors.lightSecondaryText;
  static Color cardIconColor() => AppColors.lightPrimaryText;

  /// Get appropriate color for a card background
  /// Cards typically stay white in both themes
  static Color cardBackgroundColor() => AppColors.white;

  /// Get the accent text color based on current theme
  static Color accentTextColor(BuildContext context) {
    return isDarkMode(context)
        ? AppColors.darkAccentText
        : AppColors.lightAccentText;
  }
}
