import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:pingvite/core/constants/constants.dart';
import 'package:pingvite/core/custom_widgets/app_texts.dart';
import 'package:pingvite/core/theme/app_colors.dart';
import 'package:pingvite/core/theme/app_text_theme.dart';
import 'package:pingvite/core/utils/size_extension.dart';
import 'package:pingvite/features/payment_success/domain/entities/transaction_details.dart';

class TicketDetailsCard extends StatelessWidget {
  final TransactionDetails transactionDetails;

  const TicketDetailsCard({super.key, required this.transactionDetails});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).extension<AppTextTheme>()!;

    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(16.rpx),
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
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
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
          Gap(20.gap),

          // Ticket List
          ...transactionDetails.tickets.map((ticket) {
            return Padding(
              padding: EdgeInsets.only(bottom: 16.rpx),
              child: _buildTicketItem(ticket, context),
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

          // GST
          _buildSummaryRow(
            label: Constants.gst,
            amount: transactionDetails.gst,
            isHighlighted: false,
            context: context,
          ),
          Gap(12.gap),

          // Total
          _buildSummaryRow(
            label: Constants.total,
            amount: transactionDetails.total,
            isHighlighted: true,
            context: context,
          ),
        ],
      ),
    );
  }

  Widget _buildTicketItem(TicketDetail ticket, BuildContext context) {
    final textTheme = Theme.of(context).extension<AppTextTheme>()!;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: AppTexts(
                text: ticket.ticketName,
                style: textTheme.body.copyWith(
                  fontWeight: FontWeight.w600,
                  color: Colors.black,
                ),
              ),
            ),
            AppTexts(
              text: '₹${ticket.price}',
              style: textTheme.body.copyWith(
                fontWeight: FontWeight.w600,
                color: AppColors.blue,
              ),
            ),
          ],
        ),
        Gap(6.gap),
        AppTexts(
          text: ticket.location,
          style: textTheme.accent.copyWith(color: Colors.black54),
        ),
        Gap(4.gap),
        AppTexts(
          text: ticket.dateTime,
          style: textTheme.accent.copyWith(color: Colors.black54),
        ),
        Gap(4.gap),
        AppTexts(
          text: 'Qty: ${ticket.quantity}',
          style: textTheme.accent.copyWith(color: Colors.black54),
        ),
      ],
    );
  }

  Widget _buildSummaryRow({
    required String label,
    required int amount,
    required bool isHighlighted,
    required BuildContext context,
  }) {
    final textTheme = Theme.of(context).extension<AppTextTheme>()!;

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        AppTexts(
          text: label,
          style: isHighlighted
              ? textTheme.subheading.copyWith(
                  fontWeight: FontWeight.w700,
                  color: AppColors.blue,
                )
              : textTheme.body.copyWith(
                  fontWeight: FontWeight.w500,
                  color: Colors.black87,
                ),
        ),
        AppTexts(
          text: '₹ $amount',
          style: isHighlighted
              ? textTheme.subheading.copyWith(
                  fontWeight: FontWeight.w700,
                  color: AppColors.blue,
                )
              : textTheme.body.copyWith(
                  fontWeight: FontWeight.w500,
                  color: Colors.black87,
                ),
        ),
      ],
    );
  }
}
