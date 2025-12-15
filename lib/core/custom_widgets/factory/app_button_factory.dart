import 'package:flutter/material.dart';
import 'package:pingvite/core/custom_widgets/app_primary_buttons.dart';
import 'package:pingvite/core/theme/app_button_theme.dart';
import 'package:pingvite/core/theme/app_colors.dart';
import 'package:pingvite/core/theme/app_text_theme.dart';
import 'package:pingvite/core/utils/sizeconfig.dart';
import 'package:pingvite/service_locator_dependencies.dart';

enum ButtonType { withPrefixIcon, simple, gradient }

class AppButtonFactory {
  static Widget build({
    required BuildContext context,
    required ButtonType type,
    required String title,
    required VoidCallback onPressed,
    bool isLoading = false,
    Color? backgroundColor,
    Color? textColor,
    Color? borderColor,
    double? width,
    Widget? prefixIcon,
    Gradient? gradient,
  }) {
    final textTheme = Theme.of(context).extension<AppTextTheme>()!;
    final buttonTheme = Theme.of(context).extension<AppButtonTheme>()!;

    // Default values
    final defaultBackgroundColor = backgroundColor ?? AppColors.lightbackground;
    final defaultTextColor = textColor ?? AppColors.lightPrimaryText;
    final defaultBorderColor = borderColor ?? AppColors.lightPrimaryText;

    switch (type) {
      case ButtonType.withPrefixIcon:
        return AppPrimaryButton(
          width: width ?? double.infinity,
          title: title,
          textTheme: textTheme,
          buttonTheme: buttonTheme,
          onPressed: onPressed,
          isLoading: isLoading,
          backgroundColor: defaultBackgroundColor,
          buttonTextColor: defaultTextColor,
          borderColor: defaultBorderColor,
          contentPadding: EdgeInsets.symmetric(
            horizontal: sl<SizeConfig>().rpx(15),
            vertical: sl<SizeConfig>().rpx(10),
          ),
          textStyle: textTheme.semiBold.copyWith(color: defaultTextColor),
          prefixIcon: prefixIcon,
        );

      case ButtonType.simple:
        return AppPrimaryButton(
          width: width,
          title: title,
          textTheme: textTheme,
          buttonTheme: buttonTheme,
          onPressed: onPressed,
          isLoading: isLoading,
          backgroundColor: defaultBackgroundColor,
          buttonTextColor: defaultTextColor,
          borderColor: defaultBorderColor,
          contentPadding: EdgeInsets.symmetric(
            horizontal: sl<SizeConfig>().rpx(30),
            vertical: sl<SizeConfig>().rpx(10),
          ),
          textStyle: textTheme.semiBold.copyWith(color: defaultTextColor),
        );

      case ButtonType.gradient:
        // Default gradient if none provided
        final defaultGradient =
            gradient ??
            const LinearGradient(
              colors: [AppColors.lightGradient, AppColors.darkGradient],
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
            );

        return AppPrimaryButton(
          title: title,
          textTheme: textTheme,
          buttonTheme: buttonTheme,
          onPressed: onPressed,
          isLoading: isLoading,
          gradient: defaultGradient,
          buttonTextColor: textColor ?? AppColors.white,
          borderColor: Colors.transparent, // No border for gradient buttons
          contentPadding: EdgeInsets.symmetric(
            horizontal: sl<SizeConfig>().rpx(36),
            vertical: sl<SizeConfig>().rpx(10),
          ),
          textStyle: textTheme.semiBold.copyWith(
            fontWeight: FontWeight.w600,
            color: textColor ?? AppColors.white,
          ),
        );
    }
  }
}
