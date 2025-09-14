import 'package:flutter/material.dart';
import 'package:pingvite/core/constants/constants.dart';
import 'package:pingvite/core/custom_widgets/app_images.dart';
import 'package:pingvite/core/custom_widgets/app_texts.dart';
import 'package:pingvite/core/theme/app_text_theme.dart';
import 'package:pingvite/core/utils/sizeconfig.dart';
import 'package:pingvite/service_locator_dependencies.dart';

class UploadPromptView extends StatelessWidget {
  final AppTextTheme textTheme;
  final VoidCallback onTap;

  const UploadPromptView({
    super.key,
    required this.textTheme,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        spacing: sl<SizeConfig>().rpx(5),
        children: [
          AppImages.svgIcon(context, Constants.imageUpload, 32, 32),
          AppTexts(
            text: Constants.uploadImage,
            style: textTheme.accent.copyWith(fontWeight: FontWeight.w400),
          ),
        ],
      ),
    );
  }
}
