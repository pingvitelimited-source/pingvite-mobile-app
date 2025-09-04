import 'package:flutter/material.dart';
import 'package:pingvite/core/constants/constants.dart';
import 'package:pingvite/core/custom_widgets/app_images.dart';
import 'package:pingvite/core/custom_widgets/app_texts.dart';
import 'package:pingvite/core/theme/app_colors.dart';
import 'package:pingvite/core/theme/app_text_theme.dart';

class AttendeesHeader extends StatelessWidget {
  final int total;

  const AttendeesHeader({super.key, required this.total});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).extension<AppTextTheme>()!;
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        // Left side
        Row(
          children: [
            AppTexts(
              text: Constants.eventAttendees,
              style: textTheme.subheading.copyWith(color: AppColors.black),
            ),
            const SizedBox(width: 5),
            Container(
              width: 24,
              height: 24,
              decoration: const BoxDecoration(
                color: AppColors.circleColor1,
                shape: BoxShape.circle,
              ),
              child: Center(
                child: AppTexts(
                  text: '$total',
                  style: textTheme.accent.copyWith(color: AppColors.white),
                ),
              ),
            ),
          ],
        ),

        // Right side
        Row(
          children: [
            AppImages.svgIcon(context, Constants.addImage, 28, 28),
            const SizedBox(width: 5),
            AppTexts(
              text: Constants.attendees,
              style: textTheme.subheading.copyWith(color: AppColors.blue),
            ),
          ],
        ),
      ],
    );
  }
}
