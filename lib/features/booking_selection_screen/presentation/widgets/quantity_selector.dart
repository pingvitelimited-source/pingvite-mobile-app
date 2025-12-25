import 'package:flutter/material.dart';
import 'package:pingvite/core/custom_widgets/app_texts.dart';
import 'package:pingvite/core/theme/app_colors.dart';
import 'package:pingvite/core/theme/app_text_theme.dart';
import 'package:pingvite/core/utils/size_extension.dart';

class QuantitySelector extends StatelessWidget {
  final int quantity;
  final VoidCallback onIncrement;
  final VoidCallback onDecrement;

  const QuantitySelector({
    super.key,
    required this.quantity,
    required this.onIncrement,
    required this.onDecrement,
  });

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).extension<AppTextTheme>()!;
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: AppColors.black100, width: 1),
        borderRadius: BorderRadius.circular(20.rpx),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          InkWell(
            onTap: quantity > 0 ? onDecrement : null,
            child: Padding(
              padding: EdgeInsets.symmetric(
                horizontal: 12.rpx,
                vertical: 8.rpx,
              ),
              child: Icon(
                Icons.remove,
                size: 18.rpx,
                color: quantity > 0
                    ? AppColors.black100
                    : AppColors.black100.withValues(alpha: 0.3),
              ),
            ),
          ),
          Container(
            constraints: BoxConstraints(minWidth: 30.rpx),
            alignment: Alignment.center,
            child: AppTexts(
              text: quantity.toString().padLeft(2, '0'),
              style: textTheme.body.copyWith(
                fontSize: 16.rpx,
                fontWeight: FontWeight.w600,
                color: AppColors.black100,
              ),
            ),
          ),
          InkWell(
            onTap: onIncrement,
            child: Padding(
              padding: EdgeInsets.symmetric(
                horizontal: 12.rpx,
                vertical: 8.rpx,
              ),
              child: Icon(Icons.add, size: 18.rpx, color: AppColors.black100),
            ),
          ),
        ],
      ),
    );
  }
}
