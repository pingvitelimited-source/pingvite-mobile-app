import 'package:flutter/material.dart';
import 'package:pingvite/core/custom_widgets/app_texts.dart';
import 'package:pingvite/core/theme/app_text_theme.dart';
import 'package:pingvite/core/utils/theme_helper.dart';

class SectionTitle extends StatelessWidget {
  final String title;
  final bool isEnabled;

  const SectionTitle({super.key, required this.title, this.isEnabled = true});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).extension<AppTextTheme>()!;
    final color = isEnabled
        ? ThemeHelper.primaryTextColor(context)
        : ThemeHelper.secondaryTextColor(context).withValues(alpha: 0.6);

    return Padding(
      padding: const EdgeInsets.only(top: 20, bottom: 8),
      child: AppTexts(
        text: title,
        style: textTheme.bold.copyWith(color: color),
      ),
    );
  }
}
