import 'package:flutter/material.dart';
import 'package:pingvite/core/constants/constants.dart';
import 'package:pingvite/core/custom_widgets/app_texts.dart';
import 'package:pingvite/core/theme/app_colors.dart';
import 'package:pingvite/core/theme/app_text_theme.dart';
import 'package:pingvite/core/utils/size_extension.dart';

class PaySummaryRow extends StatelessWidget {
  final String label;
  final int amount;
  final bool isHighlighted;

  const PaySummaryRow({
    super.key,
    required this.label,
    required this.amount,
    this.isHighlighted = false,
  });

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).extension<AppTextTheme>()!;
    final color = isHighlighted ? AppColors.blue : AppColors.black100;

    return Padding(
      padding: EdgeInsets.only(left: 30.rpx),
      child: Row(
        children: [
          Expanded(
            flex: 3,
            child: AppTexts(
              text: label,
              style: textTheme.semiBold.copyWith(color: color),
            ),
          ),
          Expanded(
            flex: 1,
            child: AppTexts(
              text: Constants.rupeeSymbol,
              style: textTheme.semiBold.copyWith(color: color),
              textAlign: TextAlign.center,
            ),
          ),
          Expanded(
            flex: 1,
            child: AppTexts(
              text: amount.toString(),
              style: textTheme.semiBold.copyWith(color: color),
              textAlign: TextAlign.end,
            ),
          ),
        ],
      ),
    );
  }
}
