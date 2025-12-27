import 'package:flutter/material.dart';
import 'package:pingvite/core/custom_widgets/app_card.dart';
import 'package:pingvite/core/custom_widgets/app_images.dart';
import 'package:pingvite/core/custom_widgets/app_texts.dart';
import 'package:pingvite/core/theme/app_colors.dart';
import 'package:pingvite/core/theme/app_text_theme.dart';
import 'package:pingvite/core/utils/sizeconfig.dart';
import 'package:pingvite/features/bottom_tabs/venue_screen/data/model/venue.dart';
import 'package:pingvite/service_locator_dependencies.dart';

class VenueCard extends StatelessWidget {
  final Venue venue;

  const VenueCard({super.key, required this.venue});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).extension<AppTextTheme>()!;
    return AppCard(
      padding: const EdgeInsets.all(12),
      borderColor: AppColors.white,
      elevation: 1,
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Image
          ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: AppImages.image(
              venue.image,
              sl<SizeConfig>().rpx(180),
              double.infinity,
              BoxFit.cover,
            ),
          ),
          const SizedBox(height: 12),

          AppTexts(
            text: venue.name,
            style: textTheme.body2.copyWith(
              color: AppColors.labelPink,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 6),
          AppTexts(text: venue.address, style: textTheme.subheading),
          const SizedBox(height: 6),
          Text.rich(
            TextSpan(
              text: "Capacity: ",
              style: textTheme.semiBold.copyWith(color: AppColors.labelBlue),
              children: [
                TextSpan(
                  text: venue.capacity,
                  style: textTheme.semiBold.copyWith(
                    color: AppColors.labelBlue,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
