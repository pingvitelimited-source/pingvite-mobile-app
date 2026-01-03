import 'package:flutter/material.dart';
import 'package:pingvite/core/constants/constants.dart';
import 'package:pingvite/core/custom_widgets/app_images.dart';
import 'package:pingvite/core/custom_widgets/app_texts.dart';
import 'package:pingvite/core/theme/app_colors.dart';
import 'package:pingvite/core/theme/app_text_theme.dart';
import 'package:pingvite/core/theme/app_top_bar_theme.dart';

class NotificationBell extends StatelessWidget {
  final int count;
  final VoidCallback? onTap;

  const NotificationBell({super.key, this.count = 0, this.onTap});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).extension<AppTextTheme>()!;
    final appBarTheme = Theme.of(context).extension<AppTopBarTheme>()!;

    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(50),
      child: Container(
        width: 48,
        height: 48,
        decoration: BoxDecoration(
          color: appBarTheme.bellBackgroundColor,
          shape: BoxShape.circle,
        ),
        child: Center(
          child: Badge(
            label: count > 0
                ? AppTexts(text: '$count', style: textTheme.body1)
                : null,
            backgroundColor: AppColors.lightGradient,
            alignment: Alignment.topRight,
            child: AppImages.svgIcon(context, Constants.notifybell, 25, 28),
          ),
        ),
      ),
    );
  }
}
