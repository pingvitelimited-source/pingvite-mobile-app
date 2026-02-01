import 'package:flutter/material.dart';
import 'package:pingvite/core/custom_widgets/app_texts.dart';
import 'package:pingvite/core/theme/app_text_theme.dart';
import 'package:pingvite/core/utils/theme_helper.dart';

class SectionItems extends StatelessWidget {
  final String item;
  final VoidCallback? onTap;
  final bool isEnabled;
  final bool isActive;

  const SectionItems({
    super.key,
    required this.item,
    this.onTap,
    this.isEnabled = true,
    this.isActive = false,
  });

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).extension<AppTextTheme>()!;
    final textColor = isEnabled
        ? ThemeHelper.primaryTextColor(context)
        : ThemeHelper.secondaryTextColor(context).withValues(alpha: 0.6);

    return GestureDetector(
      onTap: isEnabled ? onTap : null,
      behavior: HitTestBehavior.opaque,
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 6),
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
        decoration: BoxDecoration(
          color: isActive
              ? ThemeHelper.accentTextColor(context).withValues(alpha: 0.1)
              : Colors.transparent,
          borderRadius: BorderRadius.circular(8),
        ),
        child: AppTexts(
          text: item,
          style: textTheme.body.copyWith(
            color: textColor,
            fontWeight: isActive ? FontWeight.w600 : FontWeight.w400,
          ),
        ),
      ),
    );
  }
}
