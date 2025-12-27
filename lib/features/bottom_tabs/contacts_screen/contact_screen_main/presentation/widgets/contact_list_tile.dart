import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/material.dart';
import 'package:pingvite/core/constants/constants.dart';
import 'package:pingvite/core/custom_widgets/app_images.dart';
import 'package:pingvite/core/custom_widgets/app_texts.dart';
import 'package:pingvite/core/theme/app_colors.dart';
import 'package:pingvite/core/theme/app_text_theme.dart';
import 'package:pingvite/core/utils/size_extension.dart';
import 'package:pingvite/features/bottom_tabs/contacts_screen/contact_screen_main/data/contact_list_data.dart';

class ContactListTile extends StatelessWidget {
  final ContactListData listData;
  final VoidCallback? onEdit;
  final VoidCallback? onDelete;

  const ContactListTile({
    super.key,
    required this.listData,
    this.onEdit,
    this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).extension<AppTextTheme>()!;

    return Column(
      children: [
        Padding(
          padding: EdgeInsets.symmetric(vertical: 8.rpx),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Circle Avatar with first letter
              Container(
                width: 50.rpx,
                height: 50.rpx,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: const LinearGradient(
                    colors: [AppColors.lightGradient, AppColors.darkGradient],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                  ),
                ),
                child: Center(
                  child: AppTexts(
                    text: listData.firstLetter,
                    style: textTheme.bold.copyWith(color: AppColors.white),
                  ),
                ),
              ),
              SizedBox(width: 12.rpx),

              // Content
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Tags
                    Wrap(
                      spacing: 6.rpx,
                      runSpacing: 4.rpx,
                      children: listData.tags
                          .map((tag) => _buildTag(tag, textTheme))
                          .toList(),
                    ),
                    SizedBox(height: 6.rpx),

                    // List Name
                    AppTexts(
                      text: listData.name,
                      style: textTheme.semiBold.copyWith(
                        color: AppColors.black100,
                      ),
                    ),
                    SizedBox(height: 4.rpx),

                    // Created date and contact count
                    Row(
                      children: [
                        Flexible(
                          child: AppTexts(
                            text: 'Created: ${listData.createdDate}',
                            style: textTheme.accent.copyWith(
                              color: AppColors.lightPrimaryText,
                            ),
                          ),
                        ),
                        SizedBox(width: 12.rpx),
                        AppTexts(
                          text: '${listData.contactCount} Contacts',
                          style: textTheme.accent.copyWith(
                            color: AppColors.lightPrimaryText,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              // Action buttons
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  GestureDetector(
                    onTap: onEdit,
                    child: AppImages.svgIcon(
                      context,
                      Constants.editIcon,
                      20,
                      20,
                      AppColors.blue,
                    ),
                  ),
                  SizedBox(width: 12.rpx),
                  GestureDetector(
                    onTap: onDelete,
                    child: AppImages.svgIcon(
                      context,
                      Constants.deleteIcon,
                      20,
                      20,
                      AppColors.lightGradient,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        SizedBox(height: 8.rpx),
        const DottedLine(
          dashLength: 6,
          dashGapLength: 4,
          lineThickness: 1,
          dashColor: AppColors.unSelectedTabText,
        ),
      ],
    );
  }

  Widget _buildTag(String tag, AppTextTheme textTheme) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 8.rpx, vertical: 2.rpx),
      decoration: BoxDecoration(
        color: _getTagColor(tag),
        borderRadius: BorderRadius.circular(4.rpx),
      ),
      child: AppTexts(
        text: tag,
        style: textTheme.body1.copyWith(color: AppColors.white),
      ),
    );
  }

  Color _getTagColor(String tag) {
    switch (tag.toLowerCase()) {
      case 'marketing':
        return Colors.green;
      case 'finance':
        return Colors.teal;
      case 'startups':
        return Colors.cyan;
      case 'online':
        return Colors.blueGrey;
      case 'wedding':
        return Colors.pink;
      case 'guest list':
        return Colors.blue;
      default:
        return Colors.grey;
    }
  }
}
