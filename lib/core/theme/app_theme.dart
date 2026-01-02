import 'package:flutter/material.dart';
import 'package:pingvite/core/theme/app_bottom_nav_theme.dart';
import 'package:pingvite/core/theme/app_button_theme.dart';
import 'package:pingvite/core/theme/app_card_theme.dart';
import 'package:pingvite/core/theme/app_image_theme.dart';
import 'package:pingvite/core/theme/app_text_theme.dart';
import 'package:pingvite/core/theme/app_top_bar_theme.dart';
import 'app_colors.dart';

class AppTheme {
  // Define the text theme using bundled Libre Franklin font
  static const String _fontFamily = 'Libre Franklin';

  static ThemeData lightTheme = ThemeData(
    brightness: Brightness.light,
    scaffoldBackgroundColor: AppColors.lightbackground,
    fontFamily: _fontFamily,
    extensions: <ThemeExtension<dynamic>>[
      AppTextTheme.light,
      AppImageTheme.light,
      AppButtonTheme.light,
      AppBottomNavTheme.light,
      AppTopBarTheme.light,
      AppCardTheme.light,
    ],
  );

  static ThemeData darkTheme = ThemeData(
    brightness: Brightness.dark,
    scaffoldBackgroundColor: AppColors.darkBackground,
    fontFamily: _fontFamily,
    extensions: <ThemeExtension<dynamic>>[
      AppTextTheme.dark,
      AppImageTheme.dark,
      AppButtonTheme.dark,
      AppBottomNavTheme.dark,
      AppTopBarTheme.dark,
      AppCardTheme.dark,
    ],
  );
}
