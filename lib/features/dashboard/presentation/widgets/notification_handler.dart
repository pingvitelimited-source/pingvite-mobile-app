import 'package:flutter/material.dart';
import 'package:pingvite/core/custom_widgets/app_texts.dart';

class NotificationHandler {
  static void handleNotificationTap(BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: const AppTexts(text: 'No new notifications yet'),
        duration: const Duration(seconds: 1),
      ),
    );
  }
}
