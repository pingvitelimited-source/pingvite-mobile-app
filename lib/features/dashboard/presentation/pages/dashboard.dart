import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pingvite/core/constants/constants.dart';
import 'package:pingvite/core/custom_widgets/app_texts.dart';
import 'package:pingvite/core/theme/app_text_theme.dart';
import 'package:pingvite/features/bottom_tabs/contacts_screen/contact_screen_main/presentation/pages/contacts_main.dart';
import 'package:pingvite/features/bottom_tabs/contacts_screen/contact_screen_main/presentation/bloc/contact_list_bloc.dart';
import 'package:pingvite/features/bottom_tabs/events_screen/presentation/pages/event_main.dart';
import 'package:pingvite/features/bottom_tabs/home_tab/hometab.dart';
import 'package:pingvite/features/bottom_tabs/venue_screen/presentation/pages/venue_tab.dart';
import 'package:pingvite/features/dashboard/data/model/navitem.dart';
import 'package:pingvite/features/dashboard/presentation/widgets/app_bottom_navigation.dart';
import 'package:pingvite/features/dashboard/presentation/widgets/custom_appbar.dart';
import 'package:pingvite/service_locator_dependencies.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({super.key});

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  int _currentIndex = 0;
  static const _navItems = [
    NavItem(iconPath: Constants.home, label: Constants.homeLabel),
    NavItem(iconPath: Constants.contact, label: Constants.contactLabel),
    NavItem(iconPath: Constants.venue, label: Constants.venueLabel),
    NavItem(iconPath: Constants.event, label: Constants.eventLabel),
    NavItem(iconPath: Constants.profile, label: Constants.profileLabel),
  ];

  final _tabs = <Widget>[
    const Hometab(),
    BlocProvider<ContactListBloc>(
      create: (context) => sl<ContactListBloc>(),
      child: const ContactsMain(),
    ),
    const VenueTab(),
    const EventMain(),
    const _DummyTab(label: 'Profile'),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar.dashboard(
        greeting: 'Hi',
        userName: 'John',
        userImageUrl: null,
        hasNotification: true,
      ),
      body: IndexedStack(index: _currentIndex, children: _tabs),
      bottomNavigationBar: AppBottomNavigation(
        currentIndex: _currentIndex,
        onTap: (index) => setState(() => _currentIndex = index),
        items: _navItems,
      ),
    );
  }
}

class _DummyTab extends StatelessWidget {
  final String label;
  const _DummyTab({required this.label});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).extension<AppTextTheme>()!;

    return Center(
      child: AppTexts(text: label, style: textTheme.heading),
    );
  }
}
