import 'package:flutter/material.dart';
import 'package:pingvite/core/theme/app_button_theme.dart';
import 'package:pingvite/core/theme/app_colors.dart';
import 'package:pingvite/core/theme/app_text_theme.dart';
import 'package:pingvite/core/utils/size_extension.dart';
import 'package:pinput/pinput.dart';

class OtpInputText extends StatelessWidget {
  final TextEditingController controller;

  const OtpInputText({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    final buttonTheme = Theme.of(context).extension<AppButtonTheme>()!;
    final textTheme = Theme.of(context).extension<AppTextTheme>()!;

    final defaultPinTheme = PinTheme(
      width: 56.rpx,
      height: 56.rpx,
      textStyle: textTheme.heading.copyWith(fontWeight: FontWeight.w600),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.grey),
        color: Colors.white,
      ),
    );

    return Pinput(
      controller: controller,
      length: 4,
      keyboardType: TextInputType.number,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      defaultPinTheme: defaultPinTheme,
      focusedPinTheme: defaultPinTheme.copyWith(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: buttonTheme.borderColor, width: 2),
          color: buttonTheme.fillColor.withValues(alpha: 0.05),
        ),
      ),
      submittedPinTheme: defaultPinTheme.copyWith(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: buttonTheme.borderColor),
          color: buttonTheme.fillColor.withValues(alpha: 0.08),
        ),
      ),
    );
  }
}
