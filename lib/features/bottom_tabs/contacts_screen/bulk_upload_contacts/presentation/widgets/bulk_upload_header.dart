import 'package:flutter/material.dart';
import 'package:pingvite/core/custom_widgets/factory/app_button_factory.dart';
import 'package:pingvite/core/custom_widgets/factory/text_field_factory.dart';
import 'package:pingvite/core/theme/app_button_theme.dart';
import 'package:pingvite/core/utils/size_extension.dart';

/// Header section with upload excel field and upload button
class BulkUploadHeader extends StatelessWidget {
  final VoidCallback onUploadFile;

  const BulkUploadHeader({super.key, required this.onUploadFile});

  @override
  Widget build(BuildContext context) {
    final buttonTheme = Theme.of(context).extension<AppButtonTheme>()!;

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 24.rpx),
      child: Column(
        children: [
          SizedBox(height: 16.rpx),

          // Upload Excel TextField (read-only)
          TextFieldFactory.custom(
            context: context,
            buttonTheme: buttonTheme,
            name: 'upload_excel',
            hintText: 'Upload Excel',
            prefixIcon: Icon(
              Icons.upload_file_outlined,
              size: 20.rpx,
              color: Colors.grey,
            ),
            enabled: false,
          ),

          SizedBox(height: 20.rpx),

          // Upload File Button
          SizedBox(
            width: double.infinity,
            child: AppButtonFactory.build(
              context: context,
              type: ButtonType.gradient,
              title: 'Upload File',
              onPressed: onUploadFile,
            ),
          ),

          SizedBox(height: 24.rpx),
        ],
      ),
    );
  }
}
