import 'package:flutter/material.dart';
import 'package:pingvite/core/constants/constants.dart';
import 'package:pingvite/core/custom_widgets/app_images.dart';
import 'package:pingvite/core/custom_widgets/app_texts.dart';
import 'package:pingvite/core/theme/app_colors.dart';
import 'package:pingvite/core/theme/app_text_theme.dart';
import 'package:pingvite/core/theme/app_top_bar_theme.dart';
import 'package:pingvite/features/dashboard/presentation/widgets/notification_bell.dart';
import 'package:pingvite/features/dashboard/presentation/widgets/notification_handler.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String? greeting;
  final String? userName;
  final String? userImageUrl;
  final VoidCallback? onNotificationTap;
  final bool hasNotification;
  final String? title;
  final VoidCallback? onBackPressed;
  final bool showBackButton;

  const CustomAppBar({
    super.key,
    this.greeting,
    this.userName,
    this.userImageUrl,
    this.onNotificationTap,
    this.hasNotification = false,
    this.title,
    this.onBackPressed,
    this.showBackButton = false,
  });

  // Factory constructors for easy usage
  const CustomAppBar.dashboard({
    super.key,
    required String this.greeting,
    required String this.userName,
    this.userImageUrl,
    this.onNotificationTap,
    this.hasNotification = false,
  }) : title = null,
       onBackPressed = null,
       showBackButton = false;

  const CustomAppBar.withBackButton({
    super.key,
    required String this.title,
    this.onNotificationTap,
    this.onBackPressed,
    this.hasNotification = false,
  }) : showBackButton = true,
       greeting = null,
       userName = null,
       userImageUrl = null;

  @override
  Widget build(BuildContext context) {
    final appBarTheme = Theme.of(context).extension<AppTopBarTheme>()!;
    final textTheme = Theme.of(context).extension<AppTextTheme>()!;

    return Container(
      height: preferredSize.height,
      decoration: BoxDecoration(color: appBarTheme.backgroundColor),
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Row(
            children: [
              // Left side - User avatar or back button
              if (showBackButton) ...[
                GestureDetector(
                  onTap: onBackPressed ?? () => Navigator.pop(context),
                  child: Container(
                    width: 48,
                    height: 48,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: AppColors.darkPrimaryText,
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(14.0),
                      child: AppImages.svgIcon(
                        context,
                        Constants.backArrow,
                        20,
                        12,
                      ),
                    ),
                  ),
                ),
              ] else ...[
                Container(
                  width: 48,
                  height: 48,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(color: Colors.blue, width: 1),
                  ),
                  child: CircleAvatar(
                    radius: 18,
                    backgroundColor: appBarTheme.iconColor.withValues(
                      alpha: 0.1,
                    ),
                    backgroundImage: userImageUrl != null
                        ? NetworkImage(userImageUrl!)
                        : const AssetImage(Constants.sample) as ImageProvider,
                  ),
                ),
              ],

              const SizedBox(width: 12),

              // Title/Greeting Text
              Expanded(
                child: showBackButton
                    ? AppTexts(text: title ?? '', style: textTheme.semiBold)
                    : RichText(
                        text: TextSpan(
                          children: [
                            TextSpan(
                              text: '$greeting, ',
                              style: textTheme.heading.copyWith(
                                color: appBarTheme.greetingColor,
                              ),
                            ),
                            TextSpan(
                              text: userName ?? '',
                              style: textTheme.heading.copyWith(
                                color: appBarTheme.titleColor,
                              ),
                            ),
                          ],
                        ),
                      ),
              ),

              // Notification bell (always present) - uses global handler
              NotificationBell(
                count: hasNotification ? 3 : 0,
                onTap: () => NotificationHandler.handleNotificationTap(context),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight + 56);
}
