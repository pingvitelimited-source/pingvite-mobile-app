import 'package:flutter/material.dart';
import 'package:pingvite/core/custom_widgets/app_texts.dart';
import 'package:pingvite/core/theme/app_colors.dart';
import 'package:pingvite/core/theme/app_text_theme.dart';
import 'package:pingvite/core/utils/size_extension.dart';
import 'package:pingvite/core/utils/theme_helper.dart';

/// A widget that displays a count badge with a label
class CountBadge extends StatelessWidget {
  final String label;
  final int count;
  final Color? badgeColor;

  const CountBadge({
    super.key,
    required this.label,
    required this.count,
    this.badgeColor,
  });

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).extension<AppTextTheme>()!;

    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        AppTexts(
          text: label,
          style: textTheme.subheading.copyWith(
            color: ThemeHelper.primaryTextColor(context),
            fontWeight: FontWeight.w600,
          ),
        ),
        SizedBox(width: 8.rpx),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 12.rpx, vertical: 4.rpx),
          decoration: BoxDecoration(
            color: badgeColor ?? AppColors.labelBlue,
            borderRadius: BorderRadius.circular(12.rpx),
          ),
          child: AppTexts(
            text: count.toString(),
            style: textTheme.body1.copyWith(
              color: AppColors.white,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ],
    );
  }
}
