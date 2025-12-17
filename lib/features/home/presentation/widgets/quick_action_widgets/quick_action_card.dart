import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:pingvite/core/constants/constants.dart';
import 'package:pingvite/core/custom_widgets/app_images.dart';
import 'package:pingvite/core/custom_widgets/app_rich_text.dart';
import 'package:pingvite/core/data/quickactions.dart';
import 'package:pingvite/core/theme/app_colors.dart';
import 'package:pingvite/core/theme/app_text_theme.dart';
import 'package:pingvite/core/utils/sizeconfig.dart';
import 'package:pingvite/service_locator_dependencies.dart';

class QuickActionCard extends StatelessWidget {
  final HomeQuickAction data;
  const QuickActionCard({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).extension<AppTextTheme>()!;

    return Container(
      constraints: const BoxConstraints(minWidth: 180, maxWidth: 300),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.circleColor1),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        mainAxisSize: MainAxisSize.min,
        children: [
          Flexible(
            child: AppRichText(
              maxLines: 2,
              spans: [
                TextSpanItem(text: '${data.title} ', style: textTheme.semiBold),
                TextSpanItem(
                  text: data.highlight,
                  style: textTheme.semiBold.copyWith(color: AppColors.blue),
                ),
              ],
            ),
          ),

          Gap(sl<SizeConfig>().rpx(15)),
          Align(
            alignment: Alignment.topRight,
            child: AppImages.svgIcon(context, Constants.arrowIcon, 16, 16),
          ),
        ],
      ),
    );
  }
}
