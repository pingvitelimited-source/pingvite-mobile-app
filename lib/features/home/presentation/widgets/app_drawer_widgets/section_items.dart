import 'package:flutter/material.dart';
import 'package:pingvite/core/custom_widgets/app_texts.dart';
import 'package:pingvite/core/theme/app_text_theme.dart';

class SectionItems extends StatelessWidget {
  final String item;
  const SectionItems({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).extension<AppTextTheme>()!;
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: AppTexts(text: item, style: textTheme.body),
    );
  }
}
