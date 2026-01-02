import 'package:flutter/material.dart';
import 'package:pingvite/core/custom_widgets/app_primary_buttons.dart';
import 'package:pingvite/core/theme/app_button_theme.dart';
import 'package:pingvite/core/theme/app_colors.dart';
import 'package:pingvite/core/theme/app_text_theme.dart';
import 'package:pingvite/core/utils/sizeconfig.dart';
import 'package:pingvite/service_locator_dependencies.dart';

/// Reusable Form Bottom Buttons widget
/// Can be configured for single button or dual button layout
class FormBottomButtons extends StatelessWidget {
  final String? primaryButtonText;
  final String? secondaryButtonText;
  final VoidCallback? onPrimaryPressed;
  final VoidCallback? onSecondaryPressed;
  final bool showSecondaryButton;

  const FormBottomButtons({
    super.key,
    this.primaryButtonText,
    this.secondaryButtonText,
    this.onPrimaryPressed,
    this.onSecondaryPressed,
    this.showSecondaryButton = true,
  });

  /// Factory for single submit button
  factory FormBottomButtons.single({
    required String buttonText,
    required VoidCallback onPressed,
  }) {
    return FormBottomButtons(
      primaryButtonText: buttonText,
      onPrimaryPressed: onPressed,
      showSecondaryButton: false,
    );
  }

  /// Factory for save draft + submit buttons
  factory FormBottomButtons.dualAction({
    String secondaryText = "Save draft",
    String primaryText = "Submit",
    required VoidCallback onSecondaryPressed,
    required VoidCallback onPrimaryPressed,
  }) {
    return FormBottomButtons(
      secondaryButtonText: secondaryText,
      primaryButtonText: primaryText,
      onSecondaryPressed: onSecondaryPressed,
      onPrimaryPressed: onPrimaryPressed,
      showSecondaryButton: true,
    );
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).extension<AppTextTheme>()!;
    final buttonTheme = Theme.of(context).extension<AppButtonTheme>()!;

    return SafeArea(
      child: Padding(
        padding: EdgeInsets.all(sl<SizeConfig>().rpx(20)),
        child: IntrinsicHeight(
          child: showSecondaryButton
              ? _buildDualButtons(textTheme, buttonTheme)
              : _buildSingleButton(textTheme, buttonTheme),
        ),
      ),
    );
  }

  Widget _buildDualButtons(AppTextTheme textTheme, AppButtonTheme buttonTheme) {
    return Row(
      children: [
        Expanded(
          child: AppPrimaryButton(
            title: secondaryButtonText ?? "Save draft",
            textTheme: textTheme,
            buttonTheme: buttonTheme,
            onPressed: onSecondaryPressed ?? () {},
            backgroundColor: AppColors.unSelectedTabText,
            buttonTextColor: AppColors.darkPrimaryText,
            contentPadding: EdgeInsets.symmetric(
              vertical: sl<SizeConfig>().rpx(15),
            ),
            textStyle: textTheme.semiBold.copyWith(
              color: AppColors.darkPrimaryText,
            ),
          ),
        ),
        SizedBox(width: sl<SizeConfig>().rpx(12)),
        Expanded(
          child: AppPrimaryButton(
            title: primaryButtonText ?? "Submit",
            textTheme: textTheme,
            buttonTheme: buttonTheme,
            onPressed: onPrimaryPressed ?? () {},
            gradient: const LinearGradient(
              colors: [AppColors.lightGradient, AppColors.darkGradient],
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
            ),
            buttonTextColor: AppColors.darkPrimaryText,
            contentPadding: EdgeInsets.symmetric(
              vertical: sl<SizeConfig>().rpx(15),
            ),
            textStyle: textTheme.semiBold.copyWith(
              color: AppColors.darkPrimaryText,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildSingleButton(
    AppTextTheme textTheme,
    AppButtonTheme buttonTheme,
  ) {
    return AppPrimaryButton(
      title: primaryButtonText ?? "Submit",
      textTheme: textTheme,
      buttonTheme: buttonTheme,
      onPressed: onPrimaryPressed ?? () {},
      gradient: const LinearGradient(
        colors: [AppColors.lightGradient, AppColors.darkGradient],
        begin: Alignment.centerLeft,
        end: Alignment.centerRight,
      ),
      buttonTextColor: AppColors.darkPrimaryText,
      contentPadding: EdgeInsets.symmetric(
        horizontal: sl<SizeConfig>().rpx(30),
        vertical: sl<SizeConfig>().rpx(15),
      ),
      textStyle: textTheme.semiBold.copyWith(color: AppColors.darkPrimaryText),
    );
  }
}
