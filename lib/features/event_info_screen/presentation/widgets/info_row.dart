import 'package:flutter/material.dart';
import 'package:pingvite/core/custom_widgets/app_images.dart';
import 'package:pingvite/core/custom_widgets/app_texts.dart';
import 'package:pingvite/core/theme/app_colors.dart';
import 'package:pingvite/core/theme/app_text_theme.dart';

class InfoRow extends StatelessWidget {
  final String leading;
  final String text;
  final Color? textColor;
  final Color? iconColor;
  final bool useOriginalIconColor;
  final FontWeight? fontWeight;

  const InfoRow({
    super.key,
    required this.leading,
    required this.text,
    this.textColor,
    this.iconColor,
    this.useOriginalIconColor = false,
    this.fontWeight,
  });

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).extension<AppTextTheme>()!;
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    final defaultTextColor = isDarkMode
        ? AppColors.darkPrimaryText
        : AppColors.lightPrimaryText;

    // If useOriginalIconColor is true, don't apply any color tint
    final effectiveIconColor = useOriginalIconColor
        ? null
        : (iconColor ?? defaultTextColor);

    return Padding(
      padding: const EdgeInsets.only(left: 14.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          AppImages.svgIcon(
            context,
            leading,
            24,
            24,
            effectiveIconColor,
            !useOriginalIconColor, // applyThemeColor = false when using original colors
          ),
          const SizedBox(width: 12),
          Expanded(
            child: AppTexts(
              text: text,
              style: textTheme.body.copyWith(
                color: textColor ?? defaultTextColor,
                fontWeight: fontWeight,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
