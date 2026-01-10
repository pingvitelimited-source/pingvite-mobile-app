import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:pingvite/core/custom_widgets/app_texts.dart';
import 'package:pingvite/core/data/event_card_data.dart';
import 'package:pingvite/core/enums/event_card_type.dart';
import 'package:pingvite/core/theme/app_card_theme.dart';
import 'package:pingvite/core/utils/size_extension.dart';
import 'package:pingvite/core/utils/sizeconfig.dart';
import 'package:pingvite/features/dashboard/presentation/widgets/custom_appbar.dart';
import 'package:pingvite/features/home/presentation/widgets/event_widgets/event_card.dart';
import 'package:pingvite/service_locator_dependencies.dart';

class EventsListPage extends StatelessWidget {
  final String title;
  final List<EventCardData> events;
  final EventCardType type;

  const EventsListPage({
    super.key,
    required this.title,
    required this.events,
    required this.type,
  });

  @override
  Widget build(BuildContext context) {
    final cardTheme = Theme.of(context).extension<AppCardTheme>()!;
    final sizeConfig = sl<SizeConfig>();

    return Scaffold(
      backgroundColor: cardTheme.screenBackgroundColor,
      appBar: CustomAppBar.withBackButton(
        title: title,
        onBackPressed: () => Navigator.pop(context),
        showNotificationBell: false,
      ),
      body: events.isEmpty
          ? Center(
              child: AppTexts(
                text: 'No events available',
                style: Theme.of(context).textTheme.bodyLarge,
              ),
            )
          : ListView.separated(
              padding: EdgeInsets.all(sizeConfig.rpx(16)),
              itemCount: events.length,
              separatorBuilder: (_, __) => Gap(sizeConfig.rpx(16)),
              itemBuilder: (context, index) {
                return SizedBox(
                  height: type == EventCardType.event ? 300.rpx : 220.rpx,
                  child: EventCard(data: events[index], type: type),
                );
              },
            ),
    );
  }
}
