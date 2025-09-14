import 'package:flutter/material.dart';
import 'package:pingvite/core/constants/constants.dart';
import 'package:pingvite/core/custom_widgets/app_texts.dart';
import 'package:pingvite/core/theme/app_text_theme.dart';
import 'package:pingvite/core/theme/theme_controller.dart';
import 'package:pingvite/features/bottom_tabs/home_tab/hometab.dart';
import 'package:pingvite/features/bottom_tabs/venue_tab/presentation/pages/venue_tab.dart';
import 'package:pingvite/features/dashboard/data/model/navitem.dart';
import 'package:pingvite/features/dashboard/presentation/widgets/app_bottom_navigation.dart';
import 'package:pingvite/features/dashboard/presentation/widgets/custom_appbar.dart';
import 'package:provider/provider.dart';

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

  final _tabs = const <Widget>[
    Hometab(),
    _DummyTab(label: 'Contacts'),
    VenueTab(),
    _DummyTab(label: 'Events'),
    _DummyTab(label: 'Profile'),
  ];

  void _onNotificationTap() {
    final themeController = Provider.of<ThemeController>(
      context,
      listen: false,
    );
    themeController.toggleTheme();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          themeController.isDarkMode
              ? 'Switched to Dark Theme'
              : 'Switched to Light Theme',
        ),
        duration: const Duration(seconds: 1),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar.dashboard(
        greeting: 'Hi',
        userName: 'John',
        userImageUrl: null,
        onNotificationTap: _onNotificationTap,
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
