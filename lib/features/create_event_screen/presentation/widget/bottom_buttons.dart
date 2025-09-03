import 'package:flutter/material.dart';
import 'package:pingvite/core/constants/constants.dart';
import 'package:pingvite/core/custom_widgets/app_primary_buttons.dart';
import 'package:pingvite/core/routes.dart';
import 'package:pingvite/core/theme/app_button_theme.dart';
import 'package:pingvite/core/theme/app_colors.dart';
import 'package:pingvite/core/theme/app_text_theme.dart';
import 'package:pingvite/core/utils/sizeconfig.dart';
import 'package:pingvite/service_locator_dependencies.dart';

class BottomButtons extends StatelessWidget {
  const BottomButtons({super.key});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).extension<AppTextTheme>()!;
    final buttonTheme = Theme.of(context).extension<AppButtonTheme>()!;
    return Padding(
      padding: EdgeInsets.all(sl<SizeConfig>().rpx(30)),
      child: Row(
        children: [
          Expanded(
            child: AppPrimaryButton(
              title: Constants.saveAsDraft,
              textTheme: textTheme,
              buttonTheme: buttonTheme,
              onPressed: () {
                Navigator.pushNamed(context, AppRoutes.createEvent);
              },
              backgroundColor: AppColors.unSelectedTabText,
              buttonTextColor: AppColors.darkPrimaryText,
              contentPadding: const EdgeInsets.symmetric(vertical: 12),
            ),
          ),
          const SizedBox(width: 12), // spacing between buttons
          Expanded(
            child: AppPrimaryButton(
              title: Constants.continueButton,
              textTheme: textTheme,
              buttonTheme: buttonTheme,
              onPressed: () {
                Navigator.pushNamed(context, AppRoutes.createEvent);
              },
              gradient: const LinearGradient(
                colors: [AppColors.lightGradient, AppColors.darkGradient],
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
              ),
              buttonTextColor: AppColors.darkPrimaryText,
              contentPadding: const EdgeInsets.symmetric(vertical: 12),
            ),
          ),
        ],
      ),
    );
  }
}
