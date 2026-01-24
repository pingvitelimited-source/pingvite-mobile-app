import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:pingvite/core/constants/constants.dart';
import 'package:pingvite/core/custom_widgets/app_texts.dart';
import 'package:pingvite/core/custom_widgets/reusable/card_container_widget.dart';
import 'package:pingvite/core/theme/app_colors.dart';
import 'package:pingvite/core/utils/sizeconfig.dart';
import 'package:pingvite/service_locator_dependencies.dart';

class LocationSelectionHeader extends StatelessWidget {
  final bool isDarkMode;

  const LocationSelectionHeader({super.key, required this.isDarkMode});

  @override
  Widget build(BuildContext context) {
    final sizeConfig = sl<SizeConfig>();

    return CardContainerWidget(
      padding: EdgeInsets.all(sizeConfig.rpx(20)),
      borderColor: AppColors.blueLightAlpha25,
      borderWidth: 1.5,
      borderRadius: BorderRadius.circular(sizeConfig.rpx(16)),
      gradientColors: [
        AppColors.blueLightAlpha12,
        AppColors.labelPink.withValues(alpha: 0.08),
      ],
      gradientBegin: Alignment.topLeft,
      gradientEnd: Alignment.bottomRight,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: EdgeInsets.all(sizeConfig.rpx(8)),
                decoration: BoxDecoration(
                  color: AppColors.blueLightAlpha15,
                  borderRadius: BorderRadius.circular(sizeConfig.rpx(10)),
                ),
                child: Icon(
                  Icons.location_on_outlined,
                  color: AppColors.blue,
                  size: sizeConfig.rpx(24),
                ),
              ),
              Gap(sizeConfig.rpx(12)),
              Expanded(
                child: AppTexts(
                  text: Constants.findEventsNearYou,
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.w700,
                    color: isDarkMode
                        ? AppColors.darkAccentText
                        : AppColors.lightAccentText,
                    letterSpacing: 0.3,
                  ),
                ),
              ),
            ],
          ),
          Gap(sizeConfig.rpx(14)),
          AppTexts(
            text: Constants.selectLocationDescription,
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
              color: isDarkMode
                  ? AppColors.darkSecondaryText
                  : AppColors.lightSecondaryText,
              height: 1.6,
            ),
          ),
        ],
      ),
    );
  }
}
