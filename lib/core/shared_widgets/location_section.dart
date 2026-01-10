import 'package:flutter/material.dart';
import 'package:pingvite/core/custom_widgets/app_texts.dart';
import 'package:pingvite/core/theme/app_card_theme.dart';
import 'package:pingvite/core/theme/app_colors.dart';
import 'package:pingvite/core/theme/app_text_theme.dart';
import 'package:pingvite/core/utils/sizeconfig.dart';
import 'package:pingvite/service_locator_dependencies.dart';

/// Reusable Location Section widget with map placeholder
class LocationSection extends StatelessWidget {
  final String title;
  final VoidCallback? onLocationTap;
  final double? height;
  final bool showTitle;

  const LocationSection({
    super.key,
    this.title = "Location",
    this.onLocationTap,
    this.height,
    this.showTitle = true,
  });

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).extension<AppTextTheme>()!;
    final cardTheme = Theme.of(context).extension<AppCardTheme>()!;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (showTitle) ...[
          AppTexts(
            text: title,
            style: textTheme.body2.copyWith(
              fontWeight: FontWeight.w600,
              color: cardTheme.sectionLabelColor,
            ),
          ),
          SizedBox(height: sl<SizeConfig>().rpx(12)),
        ],
        LocationMapContainer(height: height, onTap: onLocationTap),
      ],
    );
  }
}

/// Reusable Location Map Container
class LocationMapContainer extends StatelessWidget {
  final double? height;
  final VoidCallback? onTap;

  const LocationMapContainer({super.key, this.height, this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: height ?? sl<SizeConfig>().rpx(180),
        width: double.infinity,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: AppColors.grey.withValues(alpha: 0.3)),
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(12),
          child: Stack(children: [const _MapPlaceholder(), const _MapPin()]),
        ),
      ),
    );
  }
}

class _MapPlaceholder extends StatelessWidget {
  const _MapPlaceholder();

  @override
  Widget build(BuildContext context) {
    final cardTheme = Theme.of(context).extension<AppCardTheme>()!;

    return Container(
      color: cardTheme.mapBackgroundColor,
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
