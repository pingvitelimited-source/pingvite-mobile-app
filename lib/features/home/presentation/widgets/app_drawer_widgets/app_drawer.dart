import 'package:flutter/material.dart';
import 'package:pingvite/core/constants/constants.dart';
import 'package:pingvite/core/custom_widgets/app_texts.dart';
import 'package:pingvite/core/routes.dart';
import 'package:pingvite/core/theme/app_colors.dart';
import 'package:pingvite/core/theme/app_text_theme.dart';

import 'package:pingvite/core/utils/theme_helper.dart';
 
import 'package:pingvite/features/home/presentation/widgets/app_drawer_widgets/app_drawer_header.dart';
import 'package:pingvite/features/home/presentation/widgets/app_drawer_widgets/section_items.dart';
import 'package:pingvite/features/home/presentation/widgets/app_drawer_widgets/section_title.dart';
import 'package:pingvite/features/home/presentation/widgets/app_drawer_widgets/drawer_divider.dart';
import 'package:pingvite/features/home/presentation/widgets/app_drawer_widgets/segment_option.dart';
import 'package:pingvite/features/home/presentation/widgets/app_drawer_widgets/drawer_theme_toggle.dart';
import 'package:pingvite/features/home/presentation/widgets/app_drawer_widgets/drawer_logout_button.dart';
 

enum DrawerSegment { organizer, discover, host }

class AppDrawer extends StatefulWidget {
  const AppDrawer({super.key});

  @override
  State<AppDrawer> createState() => _AppDrawerState();
}

class _AppDrawerState extends State<AppDrawer> {
  DrawerSegment _activeSegment = DrawerSegment.organizer;

  void _navigateTo(BuildContext context, String route) {
    Navigator.pop(context); // Close drawer
    Navigator.pushNamed(context, route);
  }

  void _openSegmentPicker(BuildContext context) {
    showModalBottomSheet<void>(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) {
        return SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                SegmentOption(
                  title: Constants.drawerForOrganizers,
                  isSelected: _activeSegment == DrawerSegment.organizer,
                  onTap: () => _setActiveSegment(DrawerSegment.organizer, context),
                ),
                SegmentOption(
                  title: Constants.drawerDiscover,
                  isSelected: _activeSegment == DrawerSegment.discover,
                  onTap: () => _setActiveSegment(DrawerSegment.discover, context),
                ),
                SegmentOption(
                  title: Constants.drawerHost,
                  isSelected: _activeSegment == DrawerSegment.host,
                  onTap: () => _setActiveSegment(DrawerSegment.host, context),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  void _setActiveSegment(DrawerSegment segment, BuildContext context) {
    setState(() => _activeSegment = segment);
    Navigator.pop(context);
  }

  bool _isOrganizerActive() => _activeSegment == DrawerSegment.organizer;
  bool _isDiscoverActive() => _activeSegment == DrawerSegment.discover;
  bool _isHostActive() => _activeSegment == DrawerSegment.host;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).extension<AppTextTheme>()!;
    return Drawer(
      backgroundColor: ThemeHelper.isDarkMode(context)
          ? AppColors.darkBackground
          : AppColors.white,
      child: SafeArea(
        child: Column(
          children: [
            AppDrawerHeader(onSegmentTap: () => _openSegmentPicker(context)),
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SectionTitle(
                      title: Constants.drawerForOrganizers,
                      isEnabled: _isOrganizerActive(),
                    ),
                    SectionItems(
                      item: Constants.drawerDashboard,
                      isEnabled: _isOrganizerActive(),
                      isActive: _isOrganizerActive(),
                    ),
                    SectionItems(
                      item: Constants.drawerCreateEvent,
                      isEnabled: _isOrganizerActive(),
                      onTap: () => _navigateTo(context, AppRoutes.createEvent),
                    ),
                    SectionItems(
                      item: Constants.drawerManageEvents,
                      isEnabled: _isOrganizerActive(),
                    ),
                    SectionItems(
                      item: Constants.drawerMyVenues,
                      isEnabled: _isOrganizerActive(),
                      onTap: () => _navigateTo(context, AppRoutes.myVenues),
                    ),
                    SectionItems(
                      item: Constants.drawerPromotion,
                      isEnabled: _isOrganizerActive(),
                    ),

                    const DrawerDivider(),

                    SectionTitle(
                      title: Constants.drawerDiscover,
                      isEnabled: _isDiscoverActive(),
                    ),
                    SectionItems(
                      item: Constants.drawerFindEvents,
                      isEnabled: _isDiscoverActive(),
                      isActive: _isDiscoverActive(),
                    ),
                    SectionItems(
                      item: Constants.drawerFindVenue,
                      isEnabled: _isDiscoverActive(),
                    ),
                    SectionItems(
                      item: Constants.drawerExhibitions,
                      isEnabled: _isDiscoverActive(),
                    ),
                    SectionItems(
                      item: Constants.drawerBusinessConventions,
                      isEnabled: _isDiscoverActive(),
                    ),
                    SectionItems(
                      item: Constants.drawerForStartups,
                      isEnabled: _isDiscoverActive(),
                    ),

                    const DrawerDivider(),

                    SectionTitle(title: Constants.drawerHost, isEnabled: _isHostActive()),
                    SectionItems(
                      item: Constants.drawerCreateEvent,
                      isEnabled: _isHostActive(),
                      isActive: _isHostActive(),
                      onTap: () => _navigateTo(context, AppRoutes.createEvent),
                    ),
                    SectionItems(item: Constants.drawerMyEvents, isEnabled: _isHostActive()),
                    SectionItems(
                      item: Constants.drawerMyContacts,
                      isEnabled: _isHostActive(),
                      onTap: () => _navigateTo(context, AppRoutes.myContacts),
                    ),
                    SectionItems(
                      item: Constants.drawerMyVenues,
                      isEnabled: _isHostActive(),
                      onTap: () => _navigateTo(context, AppRoutes.myVenues),
                    ),

                    const DrawerDivider(),

                    SectionTitle(title: Constants.drawerAccount),
                    SectionItems(item: Constants.drawerMyProfile),
                    SectionItems(item: Constants.drawerMyTickets),
                    SectionItems(item: Constants.drawerBilling),

                    const DrawerDivider(),

                    SectionTitle(title: Constants.drawerContact),
                    SectionItems(item: Constants.drawerFAQ),
                    SectionItems(item: Constants.drawerSupport),
                    SectionItems(item: Constants.drawerContactUs),

                    const DrawerDivider(),

                    const DrawerThemeToggle(),

                    const SizedBox(height: 16),

                    const DrawerLogoutButton(),

                    const SizedBox(height: 16),

                    AppTexts(
                      text: Constants.drawerVersion,
                      style: textTheme.subheading.copyWith(
                        color: ThemeHelper.primaryTextColor(context),
                      ),
                    ),

                    const SizedBox(height: 16),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
