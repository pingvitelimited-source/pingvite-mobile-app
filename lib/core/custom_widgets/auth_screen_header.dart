import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:pingvite/core/constants/constants.dart';
import 'package:pingvite/core/custom_widgets/app_images.dart';
import 'package:pingvite/core/custom_widgets/app_texts.dart';
import 'package:pingvite/core/theme/app_colors.dart';
import 'package:pingvite/core/theme/app_text_theme.dart';
import 'package:pingvite/core/utils/sizeconfig.dart';
import 'package:pingvite/service_locator_dependencies.dart';

class AuthScreenHeader extends StatelessWidget {
  const AuthScreenHeader({super.key});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).extension<AppTextTheme>()!;
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;

    return Column(
      children: [
        // Logo icon + App name in same row
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // New logo with white background
            AppImages.image(Constants.appLogoNew, 55, 55),
            Gap(sl<SizeConfig>().rpx(8)),
            // App name - white in dark mode, dark in light mode
            AppTexts(
              text: Constants.appTitle,
              style: textTheme.heading.copyWith(
                fontSize: 36,
                fontWeight: FontWeight.bold,
                color: isDarkMode ? AppColors.white : const Color(0xFF2C3E50),
              ),
            ),
          ],
        ),
        Gap(sl<SizeConfig>().rpx(4)),
        // Tagline - light gray in dark mode, original color in light mode
        AppTexts(
          text: Constants.loginHeaderText,
          style: textTheme.subheading.copyWith(
            fontStyle: FontStyle.italic,
            fontSize: 16,
            color: isDarkMode
                ? AppColors.darkSecondaryText
                : AppColors.lightSecondaryText,
          ),
        ),
      ],
    );
  }
}
