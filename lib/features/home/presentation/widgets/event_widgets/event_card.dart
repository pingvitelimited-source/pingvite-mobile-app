import 'package:flutter/material.dart';
import 'package:pingvite/core/data/event_card_data.dart';
import 'package:pingvite/core/enums/event_card_type.dart';
import 'package:pingvite/core/utils/size_extension.dart';
import 'package:pingvite/features/home/presentation/widgets/event_widgets/activity_title.dart';
import 'package:pingvite/features/home/presentation/widgets/event_widgets/event_details.dart';
import 'package:pingvite/features/home/presentation/widgets/event_widgets/image_section.dart';

class EventCard extends StatelessWidget {
  final EventCardData data;
  final EventCardType type;

  const EventCard({super.key, required this.data, required this.type});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 220.rpx,

      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
      ),
      clipBehavior: Clip.antiAlias,
      child: type == EventCardType.activity ? _activityCard() : _eventCard(),
    );
  }

  Widget _eventCard() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [ImageSection(data), EventDetails(data)],
    );
  }

  Widget _activityCard() {
    return Stack(
      children: [
        Positioned.fill(child: ImageSection(data)),
        Positioned(
          left: 0,
          right: 0,
          bottom: 0,
          child: ActivityTitle(data, clipBottom: true),
        ),
      ],
    );
  }
}
