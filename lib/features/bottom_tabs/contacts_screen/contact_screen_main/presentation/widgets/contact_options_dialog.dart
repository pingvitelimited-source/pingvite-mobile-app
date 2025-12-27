import 'package:flutter/material.dart';
import 'package:pingvite/core/constants/constants.dart';
import 'package:pingvite/core/custom_widgets/app_texts.dart';
import 'package:pingvite/core/theme/app_colors.dart';
import 'package:pingvite/core/theme/app_text_theme.dart';
import 'package:pingvite/core/utils/size_extension.dart';

enum ContactAction { createContact, createList, bulkUpload }

class ContactOptionsDialog extends StatelessWidget {
  const ContactOptionsDialog({super.key});

  static Future<ContactAction?> show(BuildContext context) {
    return showGeneralDialog<ContactAction>(
      context: context,
      barrierDismissible: true,
      barrierLabel: 'Dismiss',
      barrierColor: Colors.black26,
      pageBuilder: (context, animation, secondaryAnimation) {
        return const ContactOptionsDialog();
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
      alignment: Alignment.bottomCenter,
      child: Padding(
        padding: EdgeInsets.only(left: 80.rpx, right: 20.rpx, bottom: 180.rpx),
        child: Material(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12.rpx),
          elevation: 8,
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: 8.rpx),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                _buildOption(
                  context: context,
                  text: Constants.createNewContact,
                  style: textTheme.semiBold.copyWith(color: AppColors.black100),
                  action: ContactAction.createContact,
                ),
                Divider(
                  color: AppColors.black100.withValues(alpha: 0.1),
                  height: 1,
                ),
                _buildOption(
                  context: context,
                  text: Constants.createNewContactList,
                  style: textTheme.semiBold.copyWith(color: AppColors.black100),
                  action: ContactAction.createList,
                ),
                Divider(
                  color: AppColors.black100.withValues(alpha: 0.1),
                  height: 1,
                ),
                _buildOption(
                  context: context,
                  text: Constants.bulkUpload,
                  style: textTheme.semiBold.copyWith(color: AppColors.black100),
                  action: ContactAction.bulkUpload,
                ),
              ],
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
    required ContactAction action,
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
