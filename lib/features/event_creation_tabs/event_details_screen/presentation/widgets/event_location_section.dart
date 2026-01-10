import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:pingvite/core/custom_widgets/app_texts.dart';
import 'package:pingvite/core/theme/app_card_theme.dart';
import 'package:pingvite/core/theme/app_colors.dart';
import 'package:pingvite/core/theme/app_text_theme.dart';
import 'package:pingvite/core/utils/sizeconfig.dart';
import 'package:pingvite/service_locator_dependencies.dart';

class EventLocationSection extends StatelessWidget {
  final VoidCallback? onLocationTap;

  const EventLocationSection({super.key, this.onLocationTap});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).extension<AppTextTheme>()!;
    final cardTheme = Theme.of(context).extension<AppCardTheme>()!;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AppTexts(
          text: "Location",
          style: textTheme.body2.copyWith(
            fontWeight: FontWeight.w600,
            color: cardTheme.sectionLabelColor,
          ),
        ),
        Gap(sl<SizeConfig>().rpx(12)),
        const _LocationMapContainer(),
      ],
    );
  }
}

class _LocationMapContainer extends StatelessWidget {
  const _LocationMapContainer();

  @override
  Widget build(BuildContext context) {
    return Container(
      height: sl<SizeConfig>().rpx(180),
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.grey.withValues(alpha: 0.3)),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(12),
        child: Stack(children: [_MapPlaceholder(), const _MapPin()]),
      ),
    );
  }
}

class _MapPlaceholder extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.homebackground,
      child: Center(
        child: Icon(
          Icons.map_outlined,
          size: 48,
          color: AppColors.grey.withValues(alpha: 0.5),
        ),
      ),
    );
  }
}

class _MapPin extends StatelessWidget {
  const _MapPin();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Icon(Icons.location_on, size: 40, color: AppColors.red),
    );
  }
}
