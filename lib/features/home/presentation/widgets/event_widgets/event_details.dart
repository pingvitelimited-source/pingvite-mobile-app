import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:pingvite/core/custom_widgets/app_texts.dart';
import 'package:pingvite/core/data/event_card_data.dart';
import 'package:pingvite/core/theme/app_text_theme.dart';
import 'package:pingvite/core/utils/size_extension.dart';

class EventDetails extends StatelessWidget {
  final EventCardData data;
  const EventDetails(this.data, {super.key});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).extension<AppTextTheme>()!;
    return Padding(
      padding: EdgeInsets.all(14.rpx),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AppTexts(text: data.title, style: textTheme.semiBold),
          Gap(6.gap),
          AppTexts(text: '${data.dateTime}', style: textTheme.accent),
          Gap(4.gap),
          AppTexts(text: data.venue ?? '', style: textTheme.accent),
          Gap(6.gap),
          AppTexts(text: data.price ?? '', style: textTheme.accent),
        ],
      ),
    );
  }
}
