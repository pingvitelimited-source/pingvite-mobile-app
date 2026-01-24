import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:pingvite/core/constants/constants.dart';
import 'package:pingvite/core/custom_widgets/app_texts.dart';
import 'package:pingvite/core/custom_widgets/factory/app_button_factory.dart';
import 'package:pingvite/core/theme/app_colors.dart';
import 'package:pingvite/core/theme/app_text_theme.dart';
import 'package:pingvite/core/utils/size_extension.dart';
import 'package:pingvite/core/utils/theme_helper.dart';
import 'package:pingvite/features/dashboard/presentation/widgets/custom_appbar.dart';
import 'package:pingvite/features/payment_success/domain/entities/transaction_details.dart';
import 'package:pingvite/features/payment_success/presentation/widgets/success_header_card.dart';
import 'package:pingvite/features/payment_success/presentation/widgets/ticket_item_card.dart';

class PaymentSuccessScreen extends StatelessWidget {
  final TransactionDetails transactionDetails;

  const PaymentSuccessScreen({super.key, required this.transactionDetails});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).extension<AppTextTheme>()!;

    return Scaffold(
      backgroundColor: ThemeHelper.backgroundColor(context),
      appBar: const CustomAppBar.withBackButton(),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 16.rpx, horizontal: 16.rpx),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Success Header
              SuccessHeaderCard(
                transactionId: transactionDetails.transactionId,
              ),
              Gap(24.gap),

              // Event Title with Underline
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  AppTexts(
                    text: transactionDetails.eventTitle,
                    style: textTheme.subheading.copyWith(
                      fontWeight: FontWeight.w700,
                      color: Colors.black,
                    ),
                  ),
                  Gap(4.gap),
                  Container(
                    width: 100.rpx,
                    height: 2,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          AppColors.blue,
                          AppColors.blue.withValues(alpha: 0.3),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              Gap(16.gap),

              // Ticket Items
              ...transactionDetails.tickets.map((ticket) {
                return Padding(
                  padding: EdgeInsets.only(bottom: 16.rpx),
                  child: TicketItemCard(ticket: ticket),
                );
              }),

              // Divider
              Container(
                height: 1,
                width: double.infinity,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      AppColors.blue.withValues(alpha: 0.3),
                      AppColors.blue,
                      AppColors.blue.withValues(alpha: 0.3),
                    ],
                  ),
                ),
              ),
              Gap(16.gap),

              // GST Row
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  AppTexts(
                    text: Constants.gst,
                    style: textTheme.body.copyWith(
                      fontWeight: FontWeight.w500,
                      color: Colors.black87,
                    ),
                  ),
                  AppTexts(
                    text: '₹ ${transactionDetails.gst}',
                    style: textTheme.body.copyWith(
                      fontWeight: FontWeight.w500,
                      color: Colors.black87,
                    ),
                  ),
                ],
              ),
              Gap(12.gap),

              // Total Row
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  AppTexts(
                    text: Constants.total,
                    style: textTheme.subheading.copyWith(
                      fontWeight: FontWeight.w700,
                      color: AppColors.blue,
                    ),
                  ),
                  AppTexts(
                    text: '₹ ${transactionDetails.total}',
                    style: textTheme.subheading.copyWith(
                      fontWeight: FontWeight.w700,
                      color: AppColors.blue,
                    ),
                  ),
                ],
              ),
              Gap(32.gap),

              // Home Button
              Center(
                child: AppButtonFactory.build(
                  context: context,
                  type: ButtonType.simple,
                  title: Constants.homeButton,
                  width: 200.rpx,
                  backgroundColor: AppColors.blue,
                  textColor: AppColors.white,
                  borderColor: AppColors.blue,
                  onPressed: () {
                    Navigator.of(context).popUntil((route) => route.isFirst);
                  },
                ),
              ),
              Gap(24.gap),
            ],
          ),
        ),
      ),
    );
  }
}
