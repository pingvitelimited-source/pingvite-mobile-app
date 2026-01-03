import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:pingvite/core/custom_widgets/app_texts.dart';
import 'package:pingvite/core/theme/app_colors.dart';
import 'package:pingvite/core/theme/app_text_theme.dart';
import 'package:pingvite/core/utils/size_extension.dart';
import 'package:pingvite/features/booking_selection_screen/data/ticket_data.dart';
import 'package:pingvite/features/booking_selection_screen/presentation/widgets/quantity_selector.dart';
import 'package:pingvite/features/booking_selection_screen/presentation/widgets/ticket_card_title.dart';
import 'package:pingvite/features/event_info_screen/presentation/widgets/info_row.dart';
import 'package:pingvite/core/constants/constants.dart';

class TicketCard extends StatelessWidget {
  final TicketData ticketData;
  final VoidCallback onIncrement;
  final VoidCallback onDecrement;

  const TicketCard({
    super.key,
    required this.ticketData,
    required this.onIncrement,
    required this.onDecrement,
  });

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).extension<AppTextTheme>()!;
    return Container(
      margin: EdgeInsets.only(bottom: 16.rpx, left: 8.rpx, right: 8.rpx),
      padding: EdgeInsets.all(16.rpx),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(16.rpx),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(child: TicketCardTitle(ticketData.title)),
              QuantitySelector(
                quantity: ticketData.quantity,
                onIncrement: onIncrement,
                onDecrement: onDecrement,
              ),
            ],
          ),
          Gap(15.gap),
          InfoRow(
            leading: Constants.locationIcon,
            text: ticketData.venue,
            textColor: AppColors.lightPrimaryText,
            iconColor: AppColors.lightPrimaryText,
          ),
          Gap(12.gap),
          InfoRow(
            leading: Constants.noteText,
            text: ticketData.dateTime,
            textColor: AppColors.lightPrimaryText,
            iconColor: AppColors.lightPrimaryText,
          ),
          Gap(12.gap),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 14.0),
                    child: Icon(
                      Icons.confirmation_number_outlined,
                      size: 24,
                      color: AppColors.lightPrimaryText,
                    ),
                  ),
                  const SizedBox(width: 12),
                  AppTexts(
                    text: '₹${ticketData.basePrice}',
                    style: textTheme.body.copyWith(
                      color: AppColors.lightPrimaryText,
                    ),
                  ),
                ],
              ),
              if (ticketData.quantity > 0)
                AppTexts(
                  text: '₹${ticketData.totalPrice}',
                  style: textTheme.bold.copyWith(color: AppColors.blue),
                ),
            ],
          ),
        ],
      ),
    );
  }
}
