import 'package:flutter/material.dart';
import 'package:pingvite/core/constants/constants.dart';
import 'package:pingvite/core/custom_widgets/app_images.dart';
import 'package:pingvite/core/custom_widgets/app_texts.dart';
import 'package:pingvite/core/theme/app_text_theme.dart';
import 'package:pingvite/core/theme/app_top_bar_theme.dart';
import 'package:pingvite/features/dashboard/presentation/widgets/notification_bell.dart';
import 'package:pingvite/features/dashboard/presentation/widgets/notification_handler.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  // Common
  final bool showBackButton;
  final bool showLocation;
  final bool hasNotification;
  final bool? showNotificationBell;

  // Dashboard
  final String? greeting;
  final String? userName;
  final String? userImageUrl;

  // Back button
  final String? title;
  final VoidCallback? onBackPressed;

  // Location
  final String? location;
  final VoidCallback? onLocationTap;
  final VoidCallback? onMenuTap;

  // Notification
  final VoidCallback? onNotificationTap;

  const CustomAppBar({
    super.key,
    this.greeting,
    this.userName,
    this.userImageUrl,
    this.title,
    this.onBackPressed,
    this.location,
    this.onLocationTap,
    this.onMenuTap,
    this.onNotificationTap,
    this.hasNotification = false,
    this.showBackButton = false,
    this.showLocation = false,
    this.showNotificationBell,
  });

  // Factory constructors for easy usage
  const CustomAppBar.dashboard({
    super.key,
    required this.greeting,
    required this.userName,
    this.userImageUrl,
    this.onNotificationTap,
    this.hasNotification = false,
    this.showNotificationBell,
  }) : showBackButton = false,
       showLocation = false,
       title = null,
       onBackPressed = null,
       location = null,
       onLocationTap = null,
       onMenuTap = null;

  const CustomAppBar.withBackButton({
    super.key,
    this.title,
    this.onBackPressed,
    this.onNotificationTap,
    this.hasNotification = false,
    this.showNotificationBell,
  }) : showBackButton = true,
       showLocation = false,
       greeting = null,
       userName = null,
       userImageUrl = null,
       location = null,
       onLocationTap = null,
       onMenuTap = null;

  const CustomAppBar.withLocation({
    super.key,
    required this.location,
    this.onLocationTap,
    this.onMenuTap,
    this.onNotificationTap,
    this.hasNotification = false,
    this.showNotificationBell = true,
  }) : showLocation = true,
       showBackButton = false,
       greeting = null,
       userName = null,
       userImageUrl = null,
       title = null,
       onBackPressed = null;

  @override
  Widget build(BuildContext context) {
    final appBarTheme = Theme.of(context).extension<AppTopBarTheme>()!;
    final textTheme = Theme.of(context).extension<AppTextTheme>()!;
    final showBell = showNotificationBell ?? !showBackButton;

    return Container(
      height: preferredSize.height,
      decoration: BoxDecoration(color: appBarTheme.backgroundColor),
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Row(
            children: [
              _buildLeft(context, appBarTheme),
              const SizedBox(width: 12),
              Expanded(child: _buildCenter(context, textTheme, appBarTheme)),
              if (showBell)
                NotificationBell(
                  count: hasNotification ? 3 : 0,
                  onTap: () {
                    if (onNotificationTap != null) {
                      onNotificationTap!();
                    } else {
                      NotificationHandler.handleNotificationTap(context);
                    }
                  },
                ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildLeft(BuildContext context, AppTopBarTheme theme) {
    if (showLocation) {
      return GestureDetector(
        onTap: onMenuTap,
        child: AppImages.svgIcon(context, Constants.menuIcon, 24, 24),
      );
    }

    if (showBackButton) {
      final isDarkMode = Theme.of(context).brightness == Brightness.dark;
      return GestureDetector(
        onTap: onBackPressed ?? () => Navigator.pop(context),
        child: Container(
          width: 48,
          height: 48,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: theme.backButtonColor,
            boxShadow: isDarkMode
                ? null
                : [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.1),
                      blurRadius: 8,
                      offset: const Offset(0, 2),
                    ),
                  ],
          ),
          child: Padding(
            padding: const EdgeInsets.all(14),
            child: AppImages.svgIcon(
              context,
              Constants.backArrow,
              20,
              12,
              theme.backButtonIconColor,
            ),
          ),
        ),
      );
    }

    return Container(
      width: 48,
      height: 48,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(color: Colors.blue, width: 1),
      ),
      child: CircleAvatar(
        backgroundImage: userImageUrl != null
            ? NetworkImage(userImageUrl!)
            : const AssetImage(Constants.sample) as ImageProvider,
      ),
    );
  }

  Widget _buildCenter(
    BuildContext context,
    AppTextTheme textTheme,
    AppTopBarTheme appBarTheme,
  ) {
    if (showLocation) {
      return GestureDetector(
        onTap: onLocationTap,
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            AppImages.svgIcon(context, Constants.locationIcon, 24, 24),
            const SizedBox(width: 6),
            AppTexts(text: location ?? '', style: textTheme.semiBold),
            const SizedBox(width: 4),
            const Icon(Icons.keyboard_arrow_down),
          ],
        ),
      );
    }

    if (showBackButton) {
      return AppTexts(text: title ?? '', style: textTheme.semiBold);
    }

    return RichText(
      text: TextSpan(
        children: [
          TextSpan(
            text: '$greeting, ',
            style: textTheme.heading.copyWith(color: appBarTheme.greetingColor),
          ),
          TextSpan(
            text: userName ?? '',
            style: textTheme.heading.copyWith(color: appBarTheme.titleColor),
          ),
        ],
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight + 56);
}
