import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:pingvite/core/custom_widgets/app_texts.dart';
import 'package:pingvite/core/theme/app_text_theme.dart';
import 'package:pingvite/core/utils/size_extension.dart';
import 'package:pingvite/core/utils/theme_helper.dart';

class OtpHeader extends StatelessWidget {
  final String email;

  const OtpHeader({super.key, required this.email});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).extension<AppTextTheme>()!;
    final textColor = ThemeHelper.primaryTextColor(context);

    return Column(
      children: [
        AppTexts(
          text: 'Verification',
          style: textTheme.heading.copyWith(
            fontWeight: FontWeight.bold,
            fontSize: 30.rpx,
            color: textColor,
          ),
        ),
        Gap(12.rpx),
        AppTexts(
          text: 'Enter the code sent to the email',
          style: textTheme.subheading.copyWith(
            fontSize: 18.rpx,
            color: textColor,
          ),
          textAlign: TextAlign.center,
        ),
        Gap(15.rpx),
        AppTexts(
          text: email,
          style: textTheme.subheading.copyWith(
            fontWeight: FontWeight.bold,
            color: textColor,
          ),
        ),
      ],
    );
  }
}
