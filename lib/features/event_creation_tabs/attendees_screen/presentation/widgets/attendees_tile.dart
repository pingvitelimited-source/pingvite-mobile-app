import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/material.dart';
import 'package:pingvite/core/constants/constants.dart';
import 'package:pingvite/core/custom_widgets/app_images.dart';
import 'package:pingvite/core/custom_widgets/app_texts.dart';
import 'package:pingvite/core/theme/app_card_theme.dart';
import 'package:pingvite/core/theme/app_colors.dart';
import 'package:pingvite/core/theme/app_text_theme.dart';
import 'package:pingvite/core/utils/sizeconfig.dart';
import 'package:pingvite/features/event_creation_tabs/attendees_screen/presentation/widgets/tag_label.dart';
import 'package:pingvite/service_locator_dependencies.dart';

class AttendeeTile extends StatelessWidget {
  final Map<String, String> attendee;
  final bool isVisible;
  final bool
  forceLight; // When true, uses dark text (for white card backgrounds)

  const AttendeeTile({
    super.key,
    required this.attendee,
    required this.isVisible,
    this.forceLight = false,
  });

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).extension<AppTextTheme>()!;
    final cardTheme = Theme.of(context).extension<AppCardTheme>()!;
    final isDark = Theme.of(context).brightness == Brightness.dark;

    // When forceLight is true (on white cards), always use dark text
    // Otherwise, use theme-aware colors based on dark/light mode
    final textColor = forceLight
        ? AppColors.lightPrimaryText
        : (isDark ? AppColors.darkPrimaryText : cardTheme.sectionLabelColor);
    final secondaryTextColor = forceLight
        ? AppColors.lightSecondaryText
        : (isDark
              ? AppColors.darkSecondaryText
              : cardTheme.sectionLabelColor.withValues(alpha: 0.7));

    return Column(
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            /// Profile Image
            CircleAvatar(
              radius: sl<SizeConfig>().rpx(36),
              backgroundImage: AssetImage(attendee["image"]!),
            ),
            const SizedBox(width: 12),

            /// Name + Email + Tag
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TagLabel(tag: attendee["tag"]!),
                  const SizedBox(height: 6),
                  AppTexts(
                    text: attendee["name"]!,
                    style: textTheme.subheading.copyWith(color: textColor),
                  ),
                  const SizedBox(height: 4),
                  AppTexts(
                    text: attendee["email"]!,
                    style: textTheme.accent.copyWith(color: secondaryTextColor),
                  ),
                ],
              ),
            ),

            /// Delete Icon
            Visibility(
              visible: isVisible,
              child: Padding(
                padding: EdgeInsets.only(
                  right: sl<SizeConfig>().rpx(20),
                  top: sl<SizeConfig>().rpx(25),
                ),
                child: AppImages.pngIcon(
                  context,
                  Constants.delete,
                  22,
                  22,
                  color: AppColors.lightGradient,
                ),
              ),
            ),
          ],
        ),

        const SizedBox(height: 12),

        /// Dashed Divider
        const DottedLine(
          dashLength: 6,
          dashGapLength: 4,
          lineThickness: 1,
          dashColor: AppColors.unSelectedTabText,
        ),

        const SizedBox(height: 12),
      ],
    );
  }
}
