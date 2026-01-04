import 'package:flutter/material.dart';
import 'package:pingvite/core/custom_widgets/factory/app_button_factory.dart';
import 'package:pingvite/core/utils/size_extension.dart';
import 'package:pingvite/core/utils/theme_helper.dart';

/// Bottom section with the Import Contacts button
class BulkUploadBottomButton extends StatelessWidget {
  final bool isLoading;
  final VoidCallback onPressed;

  const BulkUploadBottomButton({
    super.key,
    required this.isLoading,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(24.rpx),
      decoration: BoxDecoration(
        color: ThemeHelper.backgroundColor(context),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 10,
            offset: const Offset(0, -4),
          ),
        ],
      ),
      child: SizedBox(
        width: double.infinity,
        child: AppButtonFactory.build(
          context: context,
          type: ButtonType.gradient,
          title: 'Import Contacts',
          isLoading: isLoading,
          onPressed: onPressed,
        ),
      ),
    );
  }
}
