import 'package:flutter/material.dart';
import 'package:pingvite/core/custom_widgets/app_texts.dart';
import 'package:pingvite/core/theme/app_text_theme.dart';

class SectionItems extends StatelessWidget {
  final String item;
  final VoidCallback? onTap;

  const SectionItems({super.key, required this.item, this.onTap});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).extension<AppTextTheme>()!;
    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8),
        child: AppTexts(text: item, style: textTheme.body),
      ),
    );
  }
}
