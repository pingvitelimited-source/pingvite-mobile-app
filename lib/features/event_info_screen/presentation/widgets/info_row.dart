import 'package:flutter/material.dart';
import 'package:pingvite/core/custom_widgets/app_images.dart';
import 'package:pingvite/core/custom_widgets/app_texts.dart';
import 'package:pingvite/core/theme/app_colors.dart';
import 'package:pingvite/core/theme/app_text_theme.dart';

class InfoRow extends StatelessWidget {
  final String leading;
  final String text;
  final Color? textColor;
  final FontWeight? fontWeight;

  const InfoRow({
    super.key,
    required this.leading,
    required this.text,
    this.textColor,
    this.fontWeight,
  });

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).extension<AppTextTheme>()!;
    return Padding(
      padding: const EdgeInsets.only(left: 14.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          AppImages.svgIcon(context, leading, 24, 24),
          const SizedBox(width: 12),
          Expanded(
            child: AppTexts(
              text: text,
              style: textTheme.body.copyWith(
                color: textColor ?? AppColors.lightPrimaryText,
                fontWeight: fontWeight,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
