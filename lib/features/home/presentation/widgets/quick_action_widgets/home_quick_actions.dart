import 'package:flutter/material.dart';
import 'package:pingvite/core/data/quickactions.dart';
import 'package:pingvite/core/utils/sizeconfig.dart';
import 'package:pingvite/features/home/presentation/widgets/quick_action_widgets/quick_action_card.dart';
import 'package:pingvite/service_locator_dependencies.dart';

class HomeQuickActions extends StatelessWidget {
  final String? selectedCity;

  const HomeQuickActions({super.key, this.selectedCity});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: sl<SizeConfig>().rpx(55),
      child: ListView.separated(
        padding: const EdgeInsets.symmetric(horizontal: 8),
        scrollDirection: Axis.horizontal,
        itemCount: quickActions.length,
        separatorBuilder: (_, __) => const SizedBox(width: 14),
        itemBuilder: (context, index) {
          // For the first quick action, replace highlight with selected city
          if (index == 0 && selectedCity != null) {
            return QuickActionCard(
              data: HomeQuickAction(
                title: 'Events in',
                highlight: selectedCity!,
              ),
            );
          }
          return QuickActionCard(data: quickActions[index]);
        },
      ),
    );
  }
}

const List<HomeQuickAction> quickActions = [
  HomeQuickAction(title: 'Events in', highlight: 'Mumbai'),
  HomeQuickAction(title: 'Startup', highlight: 'Events'),
  HomeQuickAction(title: 'Trending', highlight: 'this Weekend'),
  HomeQuickAction(title: 'Featured', highlight: 'Events'),
];
