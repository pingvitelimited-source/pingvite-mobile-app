import 'package:flutter/material.dart';
import 'package:pingvite/core/constants/constants.dart';
import 'package:pingvite/core/custom_widgets/app_card.dart';
import 'package:pingvite/core/custom_widgets/app_images.dart';
import 'package:pingvite/core/custom_widgets/app_texts.dart';
import 'package:pingvite/core/theme/app_colors.dart';
import 'package:pingvite/core/theme/app_text_theme.dart';

class CurrentEventHeader extends StatelessWidget {
  const CurrentEventHeader({super.key});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).extension<AppTextTheme>()!;
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      spacing: 20,
      children: [
        Expanded(
          child: AppCard(
            padding: const EdgeInsets.all(4),
            borderColor: AppColors.white,
            margin: EdgeInsets.zero,
            borderRadius: 10,
            elevation: 1,
            child: Padding(
              padding: const EdgeInsets.all(4.0),
              child: Row(
                spacing: 10,
                children: [
                  AppCard(
                    backgroundColor: AppColors.labelPink,
                    borderRadius: 8,
                    padding: EdgeInsets.all(6),
                    borderColor: Colors.transparent,
                    margin: EdgeInsets.zero,
                    elevation: 0,
                    child: AppImages.svgIcon(
                      context,
                      Constants.listedEvent,
                      26,
                      26,
                      AppColors.darkPrimaryText,
                    ),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      AppTexts(
                        text: Constants.listedEvents,
                        style: textTheme.accent.copyWith(
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                      AppTexts(
                        text: '10',
                        style: textTheme.body2.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
        Expanded(
          child: AppCard(
            padding: const EdgeInsets.all(4),
            borderColor: AppColors.white,
            margin: EdgeInsets.zero,
            borderRadius: 10,
            elevation: 1,

            child: Padding(
              padding: const EdgeInsets.all(4.0),
              child: Row(
                spacing: 10,
                children: [
                  AppCard(
                    backgroundColor: AppColors.darkAccentText,
                    borderRadius: 8,
                    padding: EdgeInsets.all(6),
                    borderColor: Colors.transparent,
                    margin: EdgeInsets.zero,
                    elevation: 0,
                    child: AppImages.svgIcon(
                      context,
                      Constants.listedVenue,
                      26,
                      26,
                      AppColors.darkPrimaryText,
                    ),
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      AppTexts(
                        text: Constants.listedVenues,
                        style: textTheme.accent.copyWith(
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                      AppTexts(
                        text: '10',
                        style: textTheme.body2.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
