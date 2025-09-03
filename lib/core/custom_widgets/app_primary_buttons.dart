import 'package:flutter/material.dart';
import 'package:pingvite/core/custom_widgets/app_texts.dart';
import 'package:pingvite/core/theme/app_button_theme.dart';
import 'package:pingvite/core/theme/app_colors.dart';
import 'package:pingvite/core/theme/app_text_theme.dart';
import 'package:pingvite/core/utils/sizeconfig.dart';
import 'package:pingvite/service_locator_dependencies.dart';

class AppPrimaryButton extends StatelessWidget {
  final String title;
  final bool? isLoading;
  final AppTextTheme textTheme;
  final AppButtonTheme buttonTheme;
  final VoidCallback onPressed;
  final Gradient? gradient;
  final Color? backgroundColor;
  final Color? buttonTextColor;
  final double? textFontSize;
  final Color? borderColor;
  final EdgeInsetsGeometry? contentPadding;

  const AppPrimaryButton({
    super.key,
    required this.title,
    this.isLoading = false,
    required this.textTheme,
    required this.buttonTheme,
    required this.onPressed,
    this.gradient,
    this.backgroundColor,
    required this.buttonTextColor,
    this.textFontSize = 18,
    this.borderColor,
    this.contentPadding = const EdgeInsets.symmetric(
      horizontal: 18,
      vertical: 8,
    ),
  });

  @override
  Widget build(BuildContext context) {
    final borderRadius = BorderRadius.circular(sl<SizeConfig>().rpx(12));
    return Container(
      height: sl<SizeConfig>().rpx(50),
      decoration: BoxDecoration(
        borderRadius: borderRadius,
        gradient: gradient,
        color: gradient == null
            ? (backgroundColor ?? buttonTheme.primaryButtonColor)
            : null,
        border: Border.all(
          color: borderColor ?? buttonTheme.borderColor,
          width: sl<SizeConfig>().rpx(1),
        ),
      ),
      child: ElevatedButton(
        onPressed: (isLoading ?? false) ? null : onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.transparent,
          shadowColor: Colors.transparent,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(sl<SizeConfig>().rpx(12)),
          ),
          padding: EdgeInsets.zero,
        ),
        child: (isLoading ?? false)
            ? SizedBox(
                height: sl<SizeConfig>().rpx(20),
                width: sl<SizeConfig>().rpx(20),
                child: const CircularProgressIndicator(
                  strokeWidth: 2,
                  valueColor: AlwaysStoppedAnimation<Color>(
                    AppColors.darkPrimaryText,
                  ),
                ),
              )
            : Padding(
                padding: contentPadding ?? EdgeInsets.zero,
                child: AppTexts(
                  text: title,
                  style: textTheme.body.copyWith(
                    color: buttonTextColor,
                    fontWeight: FontWeight.w600,
                    fontSize: sl<SizeConfig>().rpx(textFontSize!),
                  ),
                ),
              ),
      ),
    );
  }
}
