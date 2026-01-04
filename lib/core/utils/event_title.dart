import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:pingvite/core/custom_widgets/app_texts.dart';
import 'package:pingvite/core/theme/app_colors.dart';
import 'package:pingvite/core/theme/app_text_theme.dart';
import 'package:pingvite/core/utils/size_extension.dart';
import 'package:pingvite/core/utils/theme_helper.dart';

class EventTitle extends StatelessWidget {
  final String title;
  final bool forceLight;
  const EventTitle(this.title, {super.key, this.forceLight = false});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).extension<AppTextTheme>()!;

    // If forceLight is true, always use dark text (for white card backgrounds)
    // Otherwise, use theme-aware colors
    final textColor = forceLight
        ? ThemeHelper.cardPrimaryTextColor()
        : ThemeHelper.primaryTextColor(context);

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AppTexts(
            text: title,
            style: textTheme.bold.copyWith(color: textColor),
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
