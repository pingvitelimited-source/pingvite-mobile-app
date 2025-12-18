import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:pingvite/core/custom_widgets/app_texts.dart';
import 'package:pingvite/core/theme/app_colors.dart';
import 'package:pingvite/core/theme/app_text_theme.dart';
import 'package:pingvite/core/utils/size_extension.dart';

class EventTitle extends StatelessWidget {
  final String title;
  const EventTitle(this.title, {super.key});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).extension<AppTextTheme>()!;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AppTexts(
            text: title,
            style: textTheme.bold.copyWith(color: AppColors.black100),
          ),
          Gap(5.gap),
          Container(
            width: 80.rpx, // length of blue line
            height: 2.rpx, // thickness
            decoration: BoxDecoration(
              color: AppColors.blue, // your blue color
              borderRadius: BorderRadius.circular(2),
            ),
          ),
        ],
      ),
    );
  }
}
