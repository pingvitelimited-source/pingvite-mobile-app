import 'package:flutter/material.dart';
import 'package:pingvite/core/constants/constants.dart';
import 'package:pingvite/core/custom_widgets/app_rich_text.dart';
import 'package:pingvite/core/custom_widgets/factory/app_text_factory.dart';
import 'package:pingvite/core/theme/app_text_theme.dart';
import 'package:pingvite/core/utils/theme_helper.dart';

class TermAndCondition extends StatelessWidget {
  const TermAndCondition({super.key});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).extension<AppTextTheme>()!;
    final textColor = ThemeHelper.secondaryTextColor(context);
    final linkColor = ThemeHelper.accentTextColor(context);

    return Padding(
      padding: const EdgeInsets.all(30.0),
      child: AppTextFactory.build(
        type: TextType.rich,
        style: textTheme.body.copyWith(color: textColor),
        textAlign: TextAlign.center,
        spans: [
          TextSpanItem(text: Constants.acceptText),
          TextSpanItem(
            text: Constants.termsAndCondition,
            style: textTheme.body.copyWith(color: linkColor),
            onTap: () {
              // Navigate to Terms and Conditions
              Navigator.pushNamed(context, '/terms');
            },
          ),
          TextSpanItem(text: Constants.and),
          TextSpanItem(
            text: Constants.privacyPolicy,
            style: textTheme.body.copyWith(color: linkColor),
            onTap: () {
              // Navigate to Privacy Policy
              Navigator.pushNamed(context, '/privacy');
            },
          ),
        ],
      ),
    );
  }
}
