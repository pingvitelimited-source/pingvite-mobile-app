import 'package:flutter/material.dart';
import 'package:pingvite/core/theme/app_card_theme.dart';
import 'package:pingvite/core/theme/app_colors.dart';
import 'package:pingvite/core/theme/app_text_theme.dart';
import 'package:pingvite/core/utils/sizeconfig.dart';
import 'package:pingvite/service_locator_dependencies.dart';

/// Reusable Tags Section widget for displaying tags with optional title
class TagsSection extends StatelessWidget {
  final String title;
  final List<String> tags;
  final ValueChanged<String>? onTagRemoved;
  final VoidCallback? onAddTag;
  final bool showTitle;

  const TagsSection({
    super.key,
    this.title = "Tags",
    required this.tags,
    this.onTagRemoved,
    this.onAddTag,
    this.showTitle = true,
  });

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).extension<AppTextTheme>()!;
    final cardTheme = Theme.of(context).extension<AppCardTheme>()!;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (showTitle) ...[
          Text(
            title,
            style: textTheme.body2.copyWith(
              fontWeight: FontWeight.w600,
              color: cardTheme.sectionLabelColor,
            ),
          ),
          SizedBox(height: sl<SizeConfig>().rpx(12)),
        ],
        _TagsContainer(
          tags: tags,
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
            .map(
              (tag) => TagChip(
                tag: tag,
                textTheme: textTheme,
                onRemove: onTagRemoved != null
                    ? () => onTagRemoved!(tag)
                    : null,
              ),
            )
            .toList(),
      ),
    );
  }
}

/// Reusable Tag Chip widget
class TagChip extends StatelessWidget {
  final String tag;
  final AppTextTheme textTheme;
  final VoidCallback? onRemove;

  const TagChip({
    super.key,
    required this.tag,
    required this.textTheme,
    this.onRemove,
  });

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
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            tag,
            style: textTheme.accent.copyWith(
              color: AppColors.white,
              fontWeight: FontWeight.w500,
            ),
          ),
          if (onRemove != null) ...[
            SizedBox(width: sl<SizeConfig>().rpx(4)),
            GestureDetector(
              onTap: onRemove,
              child: Icon(Icons.close, size: 14, color: AppColors.white),
            ),
          ],
        ],
      ),
    );
  }
}
