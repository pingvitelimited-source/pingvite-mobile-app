import 'package:flutter/material.dart';
import 'package:pingvite/core/constants/constants.dart';
import 'package:pingvite/core/custom_widgets/app_card.dart';
import 'package:pingvite/core/custom_widgets/app_images.dart';
import 'package:pingvite/core/custom_widgets/app_primary_buttons.dart';
import 'package:pingvite/core/custom_widgets/app_texts.dart';
import 'package:pingvite/core/routes.dart';
import 'package:pingvite/core/theme/app_button_theme.dart';
import 'package:pingvite/core/theme/app_colors.dart';
import 'package:pingvite/core/theme/app_text_theme.dart';

class Hometab extends StatefulWidget {
  const Hometab({super.key});

  @override
  State<Hometab> createState() => _HometabState();
}

class _HometabState extends State<Hometab> {
  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).extension<AppTextTheme>()!;
    final buttonTheme = Theme.of(context).extension<AppButtonTheme>()!;
    return Center(
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            GestureDetector(
              onTap: () {
                Navigator.pushReplacementNamed(context, AppRoutes.signin);
              },
              child: AppImages.pngIcon(
                context,
                Constants.noEvent,
                260,
                269,
                applyColor: false,
                scale: 1.26,
              ),
            ),
            AppCard(
              onTap: () {},
              padding: const EdgeInsets.all(16),
              borderColor: AppColors.white,
              margin: EdgeInsets.zero,
              borderRadius: 10,
              elevation: 0,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  AppTexts(
                    text: Constants.createEventText1,
                    style: textTheme.body2,
                  ),
                  AppTexts(
                    text: Constants.createEventText2,
                    style: textTheme.body2,
                  ),
                  SizedBox(height: 20),
                  AppPrimaryButton(
                    title: Constants.createEventButton,
                    textTheme: textTheme,
                    buttonTheme: buttonTheme,
                    onPressed: () {},
                    gradient: const LinearGradient(
                      colors: [AppColors.lightGradient, AppColors.darkGradient],
                      begin: Alignment.centerLeft,
                      end: Alignment.centerRight,
                    ),
                    buttonTextColor: AppColors.darkPrimaryText,
                    contentPadding: const EdgeInsets.symmetric(
                      horizontal: 38,
                      vertical: 12,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
