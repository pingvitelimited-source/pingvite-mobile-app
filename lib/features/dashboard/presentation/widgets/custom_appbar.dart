import 'package:flutter/material.dart';
import 'package:pingvite/core/constants/constants.dart';
import 'package:pingvite/core/theme/app_top_bar_theme.dart';
import 'package:pingvite/core/theme/app_text_theme.dart';
import 'package:pingvite/features/dashboard/presentation/widgets/notification_bell.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String greeting;
  final String userName;
  final String? userImageUrl;
  final VoidCallback? onNotificationTap;
  final bool hasNotification;

  const CustomAppBar({
    super.key,
    required this.greeting,
    required this.userName,
    this.userImageUrl,
    this.onNotificationTap,
    this.hasNotification = false,
  });

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
              Container(
                width: 48,
                height: 48,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(color: Colors.blue, width: 1),
                ),
                child: CircleAvatar(
                  radius: 18,
                  backgroundColor: appBarTheme.iconColor.withValues(alpha: 0.1),
                  backgroundImage: userImageUrl != null
                      ? NetworkImage(userImageUrl!)
                      : const AssetImage(Constants.sample) as ImageProvider,
                ),
              ),

              const SizedBox(width: 12),

              // Greeting Text
              Expanded(
                child: RichText(
                  text: TextSpan(
                    children: [
                      TextSpan(
                        text: '$greeting, ',
                        style: textTheme.heading.copyWith(
                          color: appBarTheme.greetingColor,
                        ),
                      ),
                      TextSpan(
                        text: userName,
                        style: textTheme.heading.copyWith(
                          color: appBarTheme.titleColor,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              NotificationBell(
                count: hasNotification ? 3 : 0,
                onTap: onNotificationTap,
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
