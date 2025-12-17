import 'package:flutter/material.dart';
import 'package:pingvite/core/custom_widgets/app_texts.dart';
import 'package:pingvite/core/data/event_card_data.dart';
import 'package:pingvite/core/theme/app_colors.dart';
import 'package:pingvite/core/theme/app_text_theme.dart';
import 'package:pingvite/core/utils/size_extension.dart';

class ActivityTitle extends StatelessWidget {
  final EventCardData data;
  final bool clipBottom;
  const ActivityTitle(this.data, {super.key, this.clipBottom = false});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).extension<AppTextTheme>()!;
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(horizontal: 14.rpx, vertical: 10.rpx),
      decoration: BoxDecoration(
        color: AppColors.blue,
        borderRadius: clipBottom
            ? const BorderRadius.only(
                bottomLeft: Radius.circular(20),
                bottomRight: Radius.circular(20),
              )
            : null,
      ),
      child: AppTexts(
        text: data.title,
        style: textTheme.body.copyWith(
          color: Colors.white,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
