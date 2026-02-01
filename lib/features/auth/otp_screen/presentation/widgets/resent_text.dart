import 'package:flutter/material.dart';
import 'package:pingvite/core/custom_widgets/app_rich_text.dart';
import 'package:pingvite/core/theme/app_text_theme.dart';
import 'package:pingvite/core/utils/theme_helper.dart';

class ResendText extends StatelessWidget {
  final VoidCallback onTap;

  const ResendText({super.key, required this.onTap});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).extension<AppTextTheme>()!;
    final textColor = ThemeHelper.primaryTextColor(context);

    return AppRichText(
      spans: [
        TextSpanItem(
          text: "Didn't receive code? ",
          style: textTheme.subheading.copyWith(color: textColor),
        ),
        TextSpanItem(
          text: 'Resend',
          style: textTheme.subheading.copyWith(
            color: textColor,
            fontWeight: FontWeight.bold,
          ),
          onTap: onTap,
        ),
      ],
    );
  }
}
