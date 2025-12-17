import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:pingvite/core/custom_widgets/app_texts.dart';
import 'package:pingvite/core/data/event_card_data.dart';
import 'package:pingvite/core/enums/event_card_type.dart';
import 'package:pingvite/core/theme/app_colors.dart';
import 'package:pingvite/core/theme/app_text_theme.dart';
import 'package:pingvite/core/utils/size_extension.dart';
import 'package:pingvite/features/home/presentation/widgets/event_widgets/event_card.dart';

class EventSection extends StatelessWidget {
  final String title;
  final List<EventCardData> events;
  final EventCardType type;
  final VoidCallback? onViewMore;

  const EventSection({
    super.key,
    required this.title,
    required this.events,
    required this.type,
    this.onViewMore,
  });

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).extension<AppTextTheme>()!;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: AppTexts(
            text: title,
            style: textTheme.bold.copyWith(color: AppColors.black100),
          ),
        ),
        Gap(12.gap),
        SizedBox(
          height: type == EventCardType.event ? 300.rpx : 220.rpx,
          child: ListView.separated(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            scrollDirection: Axis.horizontal,
            itemCount: events.length,
            separatorBuilder: (_, __) => SizedBox(width: 20.rpx),
            itemBuilder: (context, index) {
              return EventCard(data: events[index], type: type);
            },
          ),
        ),
        Gap(12.gap),
      ],
    );
  }
}
