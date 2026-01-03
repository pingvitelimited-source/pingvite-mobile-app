import 'package:flutter/material.dart';
import 'package:pingvite/core/data/event_category.dart';
import 'package:pingvite/core/theme/app_colors.dart';
import 'package:pingvite/core/utils/size_extension.dart';
import 'package:pingvite/features/home/presentation/widgets/event_catergory_widgets/category_item_card.dart';

class EventCategoryStrip extends StatelessWidget {
  const EventCategoryStrip({super.key});

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    return Container(
      color: isDarkMode ? AppColors.darkBackground : AppColors.white,
      child: SizedBox(
        height: 100.rpx,
        child: ListView.separated(
          padding: EdgeInsets.symmetric(horizontal: 16.rpx, vertical: 10.rpx),
          scrollDirection: Axis.horizontal,
          itemCount: homeCategories.length,
          separatorBuilder: (_, __) => SizedBox(width: 20.gap),
          itemBuilder: (context, index) {
            return CategoryItemCard(data: homeCategories[index]);
          },
        ),
      ),
    );
  }
}

const List<EventCategory> homeCategories = [
  EventCategory(title: 'Diwali', icon: Icons.event),
  EventCategory(title: 'Halloween', icon: Icons.celebration),
  EventCategory(title: 'Music', icon: Icons.music_note),
  EventCategory(title: 'Drama', icon: Icons.theater_comedy),
  EventCategory(title: 'Fitness', icon: Icons.fitness_center),
  EventCategory(title: 'Business', icon: Icons.business_center),
];
