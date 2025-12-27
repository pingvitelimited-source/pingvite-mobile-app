import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/material.dart';
import 'package:pingvite/core/constants/constants.dart';
import 'package:pingvite/core/custom_widgets/app_images.dart';
import 'package:pingvite/core/custom_widgets/app_texts.dart';
import 'package:pingvite/core/theme/app_colors.dart';
import 'package:pingvite/core/theme/app_text_theme.dart';
import 'package:pingvite/core/utils/size_extension.dart';
import 'package:pingvite/features/event_creation_tabs/attendees_screen/presentation/widgets/tag_label.dart';

class SelectableContactTile extends StatelessWidget {
  final Map<String, String> contact;
  final bool isSelected;
  final bool showSelection;
  final bool showDeleteIcon;
  final bool showDivider;
  final VoidCallback? onTap;
  final VoidCallback? onDelete;

  const SelectableContactTile({
    super.key,
    required this.contact,
    this.isSelected = false,
    this.showSelection = false,
    this.showDeleteIcon = false,
    this.showDivider = true,
    this.onTap,
    this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).extension<AppTextTheme>()!;

    return Column(
      children: [
        InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(8),
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: 8.rpx),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // Selection indicator
                if (showSelection) ...[
                  _buildSelectionIndicator(),
                  SizedBox(width: 12.rpx),
                ],

                // Profile Image
                CircleAvatar(
                  radius: 36.rpx,
                  backgroundImage: AssetImage(
                    contact["image"] ?? Constants.sample,
                  ),
                ),
                SizedBox(width: 12.rpx),

                // Name + Email + Tag
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      TagLabel(tag: contact["tag"] ?? "Friend"),
                      SizedBox(height: 6.rpx),
                      AppTexts(
                        text: contact["name"] ?? "",
                        style: textTheme.subheading.copyWith(
                          color: AppColors.black,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      SizedBox(height: 4.rpx),
                      AppTexts(
                        text: contact["email"] ?? "",
                        style: textTheme.accent.copyWith(
                          color: AppColors.lightPrimaryText,
                        ),
                      ),
                    ],
                  ),
                ),

                // Delete Icon
                if (showDeleteIcon)
                  GestureDetector(
                    onTap: onDelete,
                    child: Padding(
                      padding: EdgeInsets.only(right: 8.rpx),
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
          ),
        ),

        SizedBox(height: 8.rpx),

        // Dashed Divider
        if (showDivider)
          const DottedLine(
            dashLength: 6,
            dashGapLength: 4,
            lineThickness: 1,
            dashColor: AppColors.unSelectedTabText,
          ),

        SizedBox(height: 8.rpx),
      ],
    );
  }

  Widget _buildSelectionIndicator() {
    return Container(
      width: 20.rpx,
      height: 20.rpx,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(
          color: isSelected
              ? AppColors.blue
              : AppColors.grey.withValues(alpha: 0.4),
          width: 2,
        ),
        color: isSelected
            ? AppColors.blue.withValues(alpha: 0.2)
            : Colors.transparent,
      ),
      child: isSelected
          ? Center(
              child: Container(
                width: 10.rpx,
                height: 10.rpx,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: AppColors.blue,
                ),
              ),
            )
          : null,
    );
  }
}
