import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:pingvite/core/data/event_card_data.dart';
import 'package:pingvite/core/enums/event_card_type.dart';
import 'package:pingvite/core/utils/size_extension.dart';
import 'package:pingvite/features/home/presentation/widgets/event_widgets/event_card.dart';
import 'package:pingvite/core/utils/event_title.dart';

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
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        EventTitle(title),
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
