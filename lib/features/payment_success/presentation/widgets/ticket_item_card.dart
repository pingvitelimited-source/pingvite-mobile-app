import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:pingvite/core/custom_widgets/app_texts.dart';
import 'package:pingvite/core/theme/app_colors.dart';
import 'package:pingvite/core/theme/app_text_theme.dart';
import 'package:pingvite/core/utils/size_extension.dart';
import 'package:pingvite/features/payment_success/domain/entities/transaction_details.dart';
import 'package:pingvite/core/custom_widgets/dotted_border_container.dart';

class TicketItemCard extends StatelessWidget {
  final TicketDetail ticket;

  const TicketItemCard({super.key, required this.ticket});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).extension<AppTextTheme>()!;

    return DottedBorderContainer(
      borderColor: AppColors.blue,
      strokeWidth: 1.2,
      dashLength: 7.0,
      dashGap: 4.0,
      borderRadius: 12.rpx,
      backgroundColor: Colors.white,
      padding: EdgeInsets.all(16.rpx),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Ticket Name and Price
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

          // Location
          AppTexts(
            text: ticket.location,
            style: textTheme.accent.copyWith(color: Colors.black54),
          ),
          Gap(4.gap),

          // Date Time
          AppTexts(
            text: ticket.dateTime,
            style: textTheme.accent.copyWith(color: Colors.black54),
          ),
          Gap(4.gap),

          // Quantity
          AppTexts(
            text: 'Qty: ${ticket.quantity}',
            style: textTheme.accent.copyWith(color: Colors.black54),
          ),
        ],
      ),
    );
  }
}
