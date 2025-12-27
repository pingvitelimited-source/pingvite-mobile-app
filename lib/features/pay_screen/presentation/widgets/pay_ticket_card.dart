import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:pingvite/core/constants/constants.dart';
import 'package:pingvite/core/custom_widgets/app_texts.dart';
import 'package:pingvite/core/custom_widgets/dotted_border_container.dart';
import 'package:pingvite/core/theme/app_colors.dart';
import 'package:pingvite/core/theme/app_text_theme.dart';
import 'package:pingvite/core/utils/size_extension.dart';
import 'package:pingvite/features/booking_selection_screen/data/ticket_data.dart';

class PayTicketCard extends StatelessWidget {
  final TicketData ticket;

  const PayTicketCard({super.key, required this.ticket});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).extension<AppTextTheme>()!;

    return DottedBorderContainer(
      margin: EdgeInsets.only(bottom: 16.rpx),
      padding: EdgeInsets.all(16.rpx),
      borderColor: AppColors.black100.withValues(alpha: 0.3),
      borderRadius: 16.rpx,
      dashLength: 6,
      dashGap: 4,
      backgroundColor: AppColors.white,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AppTexts(
                  text: ticket.title,
                  style: textTheme.bold.copyWith(color: AppColors.black100),
                ),
                Gap(8.gap),
                AppTexts(
                  text: ticket.venue,
                  style: textTheme.body.copyWith(
                    color: AppColors.lightPrimaryText,
                  ),
                ),
                Gap(4.gap),
                AppTexts(
                  text: ticket.dateTime,
                  style: textTheme.body.copyWith(
                    color: AppColors.lightPrimaryText,
                  ),
                ),
                Gap(4.gap),
                AppTexts(
                  text: '${Constants.qty}: ${ticket.quantity}',
                  style: textTheme.body.copyWith(
                    color: AppColors.lightPrimaryText,
                  ),
                ),
              ],
            ),
          ),
          AppTexts(
            text:
                '${Constants.rupeeSymbol}${ticket.basePrice * ticket.quantity}',
            style: textTheme.body2.copyWith(color: AppColors.blue),
          ),
        ],
      ),
    );
  }
}
