import 'package:flutter/material.dart';
import 'package:pingvite/core/constants/constants.dart';
import 'package:pingvite/core/constants/enum_tabs.dart';
import 'package:pingvite/core/custom_widgets/reusable_tab_widget.dart';
import 'package:pingvite/core/model/tab_item.dart';
import 'package:pingvite/features/create_event_screen/presentation/widget/bottom_buttons.dart';
import 'package:pingvite/features/dashboard/presentation/widgets/custom_appbar.dart';
import 'package:pingvite/features/event_creation_tabs/attendees_screen/presentation/pages/attendees_page.dart';
import 'package:pingvite/features/event_creation_tabs/event_details_screen/presentation/pages/event_detail_page.dart';
import 'package:pingvite/features/event_creation_tabs/location_screen/presentation/pages/location_page.dart';
import 'package:pingvite/features/event_creation_tabs/template_screen/presentation/pages/template_page.dart';

class CreateEventScreen extends StatefulWidget {
  const CreateEventScreen({super.key});

  @override
  State<CreateEventScreen> createState() => _CreateEventScreenState();
}

class _CreateEventScreenState extends State<CreateEventScreen> {
  int _selectedIndex = 0;

  final List<Widget> _tabScreens = [
    EventDetailPage(),
    AttendeesPage(),
    LocationPage(),
    TemplatePage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar.withBackButton(
        title: Constants.createNewEvent,
        hasNotification: true,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 12.0),
            child: ReusableTabWidget(
              style: TabStyle.simple,
              showContent: false,
              tabs: [
                TabItem(title: Constants.eventDetails),
                TabItem(title: Constants.attendees),
                TabItem(title: Constants.location),
                TabItem(title: Constants.template),
              ],
              onTabChanged: (index) {
                setState(() {
                  _selectedIndex = index;
                });
              },
            ),
          ),
          Expanded(child: _tabScreens[_selectedIndex]),
        ],
      ),
      bottomNavigationBar: BottomButtons(),
    );
  }
}
