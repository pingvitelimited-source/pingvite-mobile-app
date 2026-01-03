import 'package:flutter/material.dart';
import 'package:pingvite/core/custom_widgets/app_texts.dart';
import 'package:pingvite/core/routes.dart';
import 'package:pingvite/core/theme/app_colors.dart';
import 'package:pingvite/core/theme/app_text_theme.dart';
import 'package:pingvite/core/utils/session_manager.dart';
import 'package:pingvite/features/home/presentation/widgets/app_drawer_widgets/app_drawer_header.dart';
import 'package:pingvite/features/home/presentation/widgets/app_drawer_widgets/section_items.dart';
import 'package:pingvite/features/home/presentation/widgets/app_drawer_widgets/section_title.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer({super.key});

  void _navigateTo(BuildContext context, String route) {
    Navigator.pop(context); // Close drawer
    Navigator.pushNamed(context, route);
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).extension<AppTextTheme>()!;
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    return Drawer(
      backgroundColor: isDarkMode ? AppColors.darkBackground : AppColors.white,
      child: SafeArea(
        child: Column(
          children: [
            AppDrawerHeader(),
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SectionTitle(title: 'Discover'),
                    SectionItems(item: 'Find Events'),
                    SectionItems(item: 'Find Venue'),
                    SectionItems(item: 'Exhibitions'),
                    SectionItems(item: 'Business Conventions'),
                    SectionItems(item: 'For Startups'),

                    _divider(),

                    SectionTitle(title: 'Host'),
                    SectionItems(item: 'Create an Invite'),
                    SectionItems(
                      item: 'Create Event',
                      onTap: () => _navigateTo(context, AppRoutes.createEvent),
                    ),
                    SectionItems(item: 'My Events'),
                    SectionItems(
                      item: 'My Contacts',
                      onTap: () => _navigateTo(context, AppRoutes.myContacts),
                    ),
                    SectionItems(
                      item: 'My Venues',
                      onTap: () => _navigateTo(context, AppRoutes.myVenues),
                    ),
                    SectionItems(item: 'Browse E-Card Templates'),

                    _divider(),

                    SectionTitle(title: 'For Organizers'),
                    SectionItems(item: 'Dashboard'),
                    SectionItems(
                      item: 'Create Event',
                      onTap: () => _navigateTo(context, AppRoutes.createEvent),
                    ),
                    SectionItems(item: 'Manage Events'),
                    SectionItems(
                      item: 'My Venues',
                      onTap: () => _navigateTo(context, AppRoutes.myVenues),
                    ),
                    SectionItems(item: 'Promotion'),

                    _divider(),

                    SectionItems(item: 'FAQ'),
                    SectionItems(item: 'Support'),
                    SectionItems(item: 'Contact Us'),
                    SectionItems(
                      item: 'Log Out',
                      onTap: () => _handleLogout(context),
                    ),

                    const SizedBox(height: 24),

                    AppTexts(
                      text: 'version 1.1',
                      style: textTheme.accent.copyWith(color: AppColors.grey),
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

  Future<void> _handleLogout(BuildContext context) async {
    // Show confirmation dialog
    final shouldLogout = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Log Out'),
        content: const Text('Are you sure you want to log out?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context, true),
            child: const Text('Log Out'),
          ),
        ],
      ),
    );

    if (shouldLogout == true && context.mounted) {
      Navigator.pop(context); // Close drawer first
      await SessionManager.clearSession();
      if (context.mounted) {
        Navigator.pushNamedAndRemoveUntil(
          context,
          AppRoutes.initial,
          (route) => false,
        );
      }
    }
  }
}

Widget _divider() {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 16),
    child: Container(
      height: 1,
      color: Colors.pinkAccent.withValues(alpha: 0.6),
    ),
  );
}
