import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:pingvite/core/constants/constants.dart';
import 'package:pingvite/core/custom_widgets/app_texts.dart';
import 'package:pingvite/core/custom_widgets/factory/app_button_factory.dart';
import 'package:pingvite/core/theme/app_colors.dart';
import 'package:pingvite/core/theme/app_text_theme.dart';
import 'package:pingvite/core/utils/size_extension.dart';

class InfoDetails extends StatefulWidget {
  const InfoDetails({super.key});

  @override
  State<InfoDetails> createState() => _InfoDetailsState();
}

class _InfoDetailsState extends State<InfoDetails> {
  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).extension<AppTextTheme>()!;
    return Padding(
      padding: EdgeInsets.only(left: 20.rpx, right: 20.rpx),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AppTexts(
            text: Constants.description,
            style: textTheme.body.copyWith(
              color: AppColors.lightPrimaryText,
              fontWeight: FontWeight.bold,
            ),
          ),
          Gap(15.gap),
          AppTexts(
            text: Constants.sampleText,
            style: textTheme.accent.copyWith(color: AppColors.lightPrimaryText),
          ),
          Gap(15.gap),
          AppTexts(
            text: Constants.agenda,
            style: textTheme.body.copyWith(
              color: AppColors.lightPrimaryText,
              fontWeight: FontWeight.bold,
            ),
          ),
          Gap(15.gap),
          AppTexts(
            text: Constants.sampltext,
            style: textTheme.accent.copyWith(color: AppColors.lightPrimaryText),
          ),
          Gap(25.gap),
          AppTexts(
            text: Constants.tickets,
            style: textTheme.body.copyWith(
              color: AppColors.lightPrimaryText,
              fontWeight: FontWeight.bold,
            ),
          ),
          Gap(15.gap),
          AppTexts(
            text: "₹100 to  ₹10,000",
            style: textTheme.accent.copyWith(color: AppColors.lightPrimaryText),
          ),
          Gap(30.gap),
          Center(
            child: AppButtonFactory.build(
              context: context,
              type: ButtonType.gradient,
              title: Constants.bookTicket,
              onPressed: () {},
            ),
          ),
          Gap(50.gap),
        ],
      ),
    );
  }
}
