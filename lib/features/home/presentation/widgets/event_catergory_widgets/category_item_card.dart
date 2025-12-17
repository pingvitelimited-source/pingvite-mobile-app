import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:pingvite/core/custom_widgets/app_texts.dart';
import 'package:pingvite/core/data/event_category.dart';
import 'package:pingvite/core/theme/app_colors.dart';
import 'package:pingvite/core/theme/app_text_theme.dart';
import 'package:pingvite/core/utils/size_extension.dart';

class CategoryItemCard extends StatelessWidget {
  final EventCategory data;

  const CategoryItemCard({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).extension<AppTextTheme>()!;

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: 50.rpx,
          height: 50.rpx,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: AppColors.blue, // match your design
          ),
          child: Icon(
            data.icon,
            color: AppColors.darkPrimaryText,
            size: 26.isz,
          ),
        ),
        Gap(10.gap),
        ConstrainedBox(
          constraints: BoxConstraints(maxWidth: 70.rpx),
          child: AppTexts(
            text: data.title,
            textAlign: TextAlign.center,
            maxLines: 2,
            style: textTheme.semiBold.copyWith(fontSize: 12.sp),
          ),
        ),
      ],
    );
  }
}
