import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pingvite/core/theme/app_buttom_theme.dart';
import 'package:pingvite/core/theme/app_image_theme.dart';
import 'package:pingvite/core/theme/app_text_theme.dart';
import 'app_colors.dart';

class AppTheme {
  static ThemeData lightTheme = ThemeData(
    brightness: Brightness.light,
    scaffoldBackgroundColor: AppColors.lightbackground,
    textTheme: GoogleFonts.libreFranklinTextTheme(),
    extensions: <ThemeExtension<dynamic>>[
      AppTextTheme.light,
      AppImageTheme.light,
      AppButtonTheme.light,
    ],
  );

  static ThemeData darkTheme = ThemeData(
    brightness: Brightness.dark,
    scaffoldBackgroundColor: AppColors.darkBackground,
    textTheme: GoogleFonts.libreFranklinTextTheme(),
    extensions: <ThemeExtension<dynamic>>[
      AppTextTheme.dark,
      AppImageTheme.dark,
      AppButtonTheme.dark,
    ],
  );
}
