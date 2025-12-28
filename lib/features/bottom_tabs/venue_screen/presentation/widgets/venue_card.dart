import 'package:flutter/material.dart';
import 'package:pingvite/core/custom_widgets/app_images.dart';
import 'package:pingvite/core/custom_widgets/app_texts.dart';
import 'package:pingvite/core/theme/app_colors.dart';
import 'package:pingvite/core/theme/app_text_theme.dart';
import 'package:pingvite/core/utils/size_extension.dart';
import 'package:pingvite/features/bottom_tabs/venue_screen/data/model/venue.dart';

enum VenueCardAction { edit, duplicate, delete }

class VenueCard extends StatelessWidget {
  final Venue venue;
  final Function(VenueCardAction)? onAction;

  const VenueCard({super.key, required this.venue, this.onAction});

  void _showOptionsMenu(BuildContext context, GlobalKey menuKey) {
    final RenderBox renderBox =
        menuKey.currentContext!.findRenderObject() as RenderBox;
    final Offset offset = renderBox.localToGlobal(Offset.zero);
    final Size size = renderBox.size;
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;

    final textTheme = Theme.of(context).extension<AppTextTheme>()!;

    // Estimate menu height (3 items * ~48px each + padding)
    final estimatedMenuHeight = 160.rpx;

    // Check if menu would go outside screen at bottom
    final spaceBelow = screenHeight - offset.dy - size.height - 8.rpx;
    final showAbove = spaceBelow < estimatedMenuHeight;

    showGeneralDialog(
      context: context,
      barrierDismissible: true,
      barrierLabel: 'Dismiss',
      barrierColor: Colors.black26,
      pageBuilder: (context, animation, secondaryAnimation) {
        return Stack(
          children: [
            Positioned(
              top: showAbove ? null : offset.dy + size.height + 8.rpx,
              bottom: showAbove ? screenHeight - offset.dy + 8.rpx : null,
              right: screenWidth - offset.dx - size.width,
              child: Material(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12.rpx),
                elevation: 8,
                child: IntrinsicWidth(
                  child: Padding(
                    padding: EdgeInsets.symmetric(vertical: 8.rpx),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _buildMenuItem(
                          context: context,
                          text: 'Edit Venue',
                          textStyle: textTheme.semiBold.copyWith(
                            color: AppColors.labelPink,
                          ),
                          action: VenueCardAction.edit,
                        ),
                        Divider(
                          color: AppColors.black100.withValues(alpha: 0.1),
                          height: 1,
                        ),
                        _buildMenuItem(
                          context: context,
                          text: 'Duplicate',
                          textStyle: textTheme.semiBold.copyWith(
                            color: AppColors.black100,
                          ),
                          action: VenueCardAction.duplicate,
                        ),
                        Divider(
                          color: AppColors.black100.withValues(alpha: 0.1),
                          height: 1,
                        ),
                        _buildMenuItem(
                          context: context,
                          text: 'Delete',
                          textStyle: textTheme.semiBold.copyWith(
                            color: AppColors.black100,
                          ),
                          action: VenueCardAction.delete,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        );
      },
      transitionBuilder: (context, animation, secondaryAnimation, child) {
        return FadeTransition(
          opacity: animation,
          child: ScaleTransition(
            scale: Tween<double>(begin: 0.95, end: 1.0).animate(
              CurvedAnimation(parent: animation, curve: Curves.easeOut),
            ),
            alignment: showAbove ? Alignment.bottomRight : Alignment.topRight,
            child: child,
          ),
        );
      },
      transitionDuration: const Duration(milliseconds: 150),
    );
  }

  Widget _buildMenuItem({
    required BuildContext context,
    required String text,
    required TextStyle textStyle,
    required VenueCardAction action,
  }) {
    return InkWell(
      onTap: () {
        Navigator.pop(context);
        onAction?.call(action);
      },
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.rpx, vertical: 14.rpx),
        child: AppTexts(text: text, style: textStyle),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).extension<AppTextTheme>()!;
    final GlobalKey menuKey = GlobalKey();

    return Container(
      margin: EdgeInsets.only(bottom: 16.rpx),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(16.rpx),
        boxShadow: [
          BoxShadow(
            color: AppColors.black.withValues(alpha: 0.05),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Image
          ClipRRect(
            borderRadius: BorderRadius.vertical(top: Radius.circular(16.rpx)),
            child: AppImages.image(
              venue.image,
              180,
              double.infinity,
              BoxFit.cover,
            ),
          ),

          Padding(
            padding: EdgeInsets.all(16.rpx),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Name and menu
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: AppTexts(
                        text: venue.name,
                        style: textTheme.body2.copyWith(
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    GestureDetector(
                      key: menuKey,
                      onTap: () => _showOptionsMenu(context, menuKey),
                      child: const Icon(Icons.more_vert, color: Colors.grey),
                    ),
                  ],
                ),
                SizedBox(height: 8.rpx),

                // Location with icon
                Row(
                  children: [
                    Icon(
                      Icons.location_on,
                      color: AppColors.labelPink,
                      size: 16,
                    ),
                    SizedBox(width: 4.rpx),
                    AppTexts(
                      text: venue.location,
                      style: textTheme.accent.copyWith(
                        color: AppColors.labelPink,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 12.rpx),

                // Location and Capacity row
                Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          AppTexts(
                            text: 'Location',
                            style: textTheme.accent.copyWith(
                              color: Colors.grey,
                            ),
                          ),
                          SizedBox(height: 2.rpx),
                          AppTexts(
                            text: venue.address,
                            style: textTheme.subheading,
                          ),
                        ],
                      ),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        AppTexts(
                          text: 'Capacity',
                          style: textTheme.accent.copyWith(color: Colors.grey),
                        ),
                        SizedBox(height: 2.rpx),
                        AppTexts(
                          text: venue.capacity,
                          style: textTheme.subheading,
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
