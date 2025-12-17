import 'package:flutter/material.dart';
import 'package:pingvite/core/data/quickactions.dart';
import 'package:pingvite/core/utils/sizeconfig.dart';
import 'package:pingvite/features/home/presentation/widgets/quick_action_widgets/quick_action_card.dart';
import 'package:pingvite/service_locator_dependencies.dart';

class HomeQuickActions extends StatelessWidget {
  const HomeQuickActions({super.key});

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
