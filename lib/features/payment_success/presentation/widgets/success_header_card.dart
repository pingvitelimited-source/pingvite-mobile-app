import 'package:flutter/material.dart';
import 'package:pingvite/core/custom_widgets/app_images.dart';
import 'package:gap/gap.dart';
import 'package:pingvite/core/constants/constants.dart';
import 'package:pingvite/core/custom_widgets/app_rich_text.dart';
import 'package:pingvite/core/custom_widgets/app_texts.dart';
import 'package:pingvite/core/theme/app_colors.dart';
import 'package:pingvite/core/theme/app_text_theme.dart';
import 'package:pingvite/core/utils/size_extension.dart';

class SuccessHeaderCard extends StatelessWidget {
  final String transactionId;

  const SuccessHeaderCard({super.key, required this.transactionId});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).extension<AppTextTheme>()!;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Payment Successful Title
        AppTexts(text: Constants.paymentSuccessful, style: textTheme.bold),
        Gap(16.gap),

        // Success Card
        Container(
          width: double.infinity,
          padding: EdgeInsets.symmetric(vertical: 24.rpx, horizontal: 16.rpx),
          decoration: BoxDecoration(
            color: AppColors.white,
            borderRadius: BorderRadius.circular(16.rpx),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.08),
                blurRadius: 12,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Column(
            children: [
              // Success Icon
              AppImages.pngIcon(context, Constants.verifyIcon, 40, 40),
              Gap(16.gap),

              // Success Message
              AppTexts(
                text: Constants.transactionSuccessful,
                style: textTheme.subheading.copyWith(
                  fontWeight: FontWeight.w600,
                  color: Colors.black,
                ),
              ),
              Gap(8.gap),

              // Transaction ID
              AppRichText(
                spans: [
                  TextSpanItem(
                    text: '${Constants.transactionId}: ',
                    style: textTheme.body.copyWith(color: Colors.black87),
                  ),
                  TextSpanItem(
                    text: transactionId,
                    style: textTheme.body.copyWith(
                      color: AppColors.blue,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}
