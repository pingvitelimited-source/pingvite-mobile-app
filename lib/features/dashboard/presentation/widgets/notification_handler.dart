import 'package:flutter/material.dart';
import 'package:pingvite/core/theme/theme_controller.dart';
import 'package:provider/provider.dart';

class NotificationHandler {
  static void handleNotificationTap(BuildContext context) {
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
}
