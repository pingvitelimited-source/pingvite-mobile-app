import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:pingvite/core/custom_widgets/app_texts.dart';
import 'package:pingvite/core/theme/app_card_theme.dart';
import 'package:pingvite/core/theme/app_colors.dart';
import 'package:pingvite/core/theme/app_text_theme.dart';
import 'package:pingvite/core/utils/sizeconfig.dart';
import 'package:pingvite/service_locator_dependencies.dart';

class EventTagsSection extends StatelessWidget {
  final List<String> selectedTags;
  final ValueChanged<String>? onTagRemoved;

  const EventTagsSection({
    super.key,
    required this.selectedTags,
    this.onTagRemoved,
  });

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).extension<AppTextTheme>()!;
    final cardTheme = Theme.of(context).extension<AppCardTheme>()!;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AppTexts(
          text: "Tags",
          style: textTheme.body2.copyWith(
            fontWeight: FontWeight.w600,
            color: cardTheme.sectionLabelColor,
          ),
        ),
        Gap(sl<SizeConfig>().rpx(12)),
        _TagsContainer(
          tags: selectedTags,
          textTheme: textTheme,
          onTagRemoved: onTagRemoved,
        ),
      ],
    );
  }
}

class _TagsContainer extends StatelessWidget {
  final List<String> tags;
  final AppTextTheme textTheme;
  final ValueChanged<String>? onTagRemoved;

  const _TagsContainer({
    required this.tags,
    required this.textTheme,
    this.onTagRemoved,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(sl<SizeConfig>().rpx(16)),
      decoration: BoxDecoration(
        border: Border.all(color: AppColors.grey.withValues(alpha: 0.3)),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Wrap(
        spacing: 8,
        runSpacing: 8,
        children: tags
            .map((tag) => _TagChip(tag: tag, textTheme: textTheme))
            .toList(),
      ),
    );
  }
}

class _TagChip extends StatelessWidget {
  final String tag;
  final AppTextTheme textTheme;

  const _TagChip({required this.tag, required this.textTheme});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: sl<SizeConfig>().rpx(12),
        vertical: sl<SizeConfig>().rpx(6),
      ),
      decoration: BoxDecoration(
        color: AppColors.blue,
        borderRadius: BorderRadius.circular(16),
      ),
      child: AppTexts(
        text: tag,
        style: textTheme.accent.copyWith(
          color: AppColors.white,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }
}
