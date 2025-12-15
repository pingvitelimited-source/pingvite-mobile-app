import 'package:flutter/material.dart';
import 'package:pingvite/core/constants/constants.dart';
import 'package:pingvite/core/custom_widgets/app_images.dart';
import 'package:pingvite/core/custom_widgets/app_texts.dart';
import 'package:pingvite/core/theme/app_text_theme.dart';

class AuthScreenHeader extends StatelessWidget {
  const AuthScreenHeader({super.key});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).extension<AppTextTheme>()!;
    return Column(
      children: [
        AppImages.image(Constants.appLogo, 63, 242),
        AppTexts(
          text: Constants.loginHeaderText,
          style: textTheme.subheading.copyWith(
            fontStyle: FontStyle.italic,
            fontSize: 15,
          ),
        ),
      ],
    );
  }
}
