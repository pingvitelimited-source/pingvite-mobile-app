import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:pingvite/core/custom_widgets/app_texts.dart';
import 'package:pingvite/core/data/event_card_data.dart';
import 'package:pingvite/core/theme/app_colors.dart';
import 'package:pingvite/core/theme/app_text_theme.dart';
import 'package:pingvite/core/utils/size_extension.dart';

class EventDetails extends StatelessWidget {
  final EventCardData data;
  const EventDetails(this.data, {super.key});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).extension<AppTextTheme>()!;
    // Event card has white background, so always use dark text
    // Use consistent font size to prevent overflow in dark mode
    final detailStyle = textTheme.accent.copyWith(
      color: AppColors.lightSecondaryText,
      fontSize: 12,
      fontWeight: FontWeight.w500,
    );
    return Padding(
      padding: EdgeInsets.all(14.rpx),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AppTexts(
            text: data.title,
            style: textTheme.semiBold.copyWith(
              color: AppColors.lightPrimaryText,
            ),
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
          Gap(6.gap),
          AppTexts(text: '${data.dateTime}', style: detailStyle),
          Gap(4.gap),
          AppTexts(
            text: data.venue ?? '',
            style: detailStyle,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          Gap(6.gap),
          AppTexts(text: data.price ?? '', style: detailStyle),
        ],
      ),
    );
  }
}
