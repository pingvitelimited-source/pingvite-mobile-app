import 'package:flutter/material.dart';
import 'package:pingvite/core/constants/constants.dart';
import 'package:pingvite/core/constants/enum_tabs.dart';
import 'package:pingvite/core/custom_widgets/custom_fab.dart';
import 'package:pingvite/core/custom_widgets/reusable_tab_widget.dart';
import 'package:pingvite/core/model/tab_item.dart';
import 'package:pingvite/core/routes.dart';
import 'package:pingvite/features/bottom_tabs/events_tab/data/model/event_model.dart';
import 'package:pingvite/features/bottom_tabs/events_tab/presentation/widgets/event_card_widget.dart';

class EventMain extends StatefulWidget {
  const EventMain({super.key});

  @override
  State<EventMain> createState() => _EventMainState();
}

class _EventMainState extends State<EventMain> {
  int _selectedIndex = 0;

  final List<String> tabs = [
    Constants.allEvents,
    Constants.upcoming,
    Constants.completed,
    Constants.draft,
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 12.0,
              vertical: 12.0,
            ),
            child: ReusableTabWidget(
              style: TabStyle.boxy,
              showContent: false,
              tabs: tabs.map((title) => TabItem(title: title)).toList(),
              onTabChanged: (index) {
                setState(() {
                  _selectedIndex = index;
                });
              },
            ),
          ),
          Expanded(child: _buildTabContent(tabs[_selectedIndex])),
        ],
      ),
      floatingActionButton: CustomFAB(
        onPressed: () {
          Navigator.pushNamed(context, AppRoutes.createEvent);
        },
        child: const Icon(Icons.add, color: Colors.white, size: 28),
      ),
    );
  }

  Widget _buildTabContent(String tabName) {
    final List<EventModel> dummyEvents = [
      EventModel(
        title: "Summer Pool Party",
        location: "Kolkata Water Park",
        imageUrl: "https://picsum.photos/600/300",
        startDate: DateTime(2025, 7, 10, 10, 0),
        endDate: DateTime(2025, 7, 10, 18, 0),
      ),
      EventModel(
        title: "Summer Time Bash",
        location: "Goa Beach",
        imageUrl: "https://picsum.photos/700/300",
        startDate: DateTime(2025, 8, 5, 19, 0),
        endDate: DateTime(2025, 8, 6, 1, 0),
      ),
      EventModel(
        title: "Summer Pool Party",
        location: "Kolkata Water Park",
        imageUrl: "https://picsum.photos/600/300",
        startDate: DateTime(2025, 7, 10, 10, 0),
        endDate: DateTime(2025, 7, 10, 18, 0),
      ),
      EventModel(
        title: "Summer Time Bash",
        location: "Goa Beach",
        imageUrl: "https://picsum.photos/700/300",
        startDate: DateTime(2025, 8, 5, 19, 0),
        endDate: DateTime(2025, 8, 6, 1, 0),
      ),
    ];

    return EventCardWidget(dummyEvents: dummyEvents);
  }
}
