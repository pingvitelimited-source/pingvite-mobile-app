import 'package:flutter/material.dart';
import 'package:pingvite/core/custom_widgets/app_texts.dart';
import 'package:pingvite/core/theme/app_colors.dart';
import 'package:pingvite/core/theme/app_text_theme.dart';
import 'package:pingvite/core/utils/size_extension.dart';

enum VenueAction { addNewVenue }

class VenueOptionsDialog extends StatelessWidget {
  const VenueOptionsDialog({super.key});

  static Future<VenueAction?> show(BuildContext context) {
    return showGeneralDialog<VenueAction>(
      context: context,
      barrierDismissible: true,
      barrierLabel: 'Dismiss',
      barrierColor: Colors.black26,
      pageBuilder: (context, animation, secondaryAnimation) {
        return const VenueOptionsDialog();
      },
      transitionBuilder: (context, animation, secondaryAnimation, child) {
        return SlideTransition(
          position: Tween<Offset>(
            begin: const Offset(0, 0.2),
            end: Offset.zero,
          ).animate(CurvedAnimation(parent: animation, curve: Curves.easeOut)),
          child: FadeTransition(opacity: animation, child: child),
        );
      },
      transitionDuration: const Duration(milliseconds: 200),
    );
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).extension<AppTextTheme>()!;

    return Align(
      alignment: Alignment.bottomRight,
      child: Padding(
        padding: EdgeInsets.only(right: 20.rpx, bottom: 90.rpx),
        child: Material(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12.rpx),
          elevation: 8,
          child: IntrinsicWidth(
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: 8.rpx),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  _buildOption(
                    context: context,
                    text: 'Add New Venue',
                    style: textTheme.semiBold.copyWith(
                      color: AppColors.black100,
                    ),
                    action: VenueAction.addNewVenue,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildOption({
    required BuildContext context,
    required String text,
    required TextStyle style,
    required VenueAction action,
  }) {
    return InkWell(
      onTap: () => Navigator.pop(context, action),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.rpx, vertical: 16.rpx),
        child: AppTexts(text: text, style: style),
      ),
    );
  }
}
