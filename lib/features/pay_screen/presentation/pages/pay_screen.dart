import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:pingvite/core/constants/constants.dart';
import 'package:pingvite/core/custom_widgets/factory/app_button_factory.dart';
import 'package:pingvite/core/theme/app_colors.dart';
import 'package:pingvite/core/utils/event_title.dart';
import 'package:pingvite/core/utils/size_extension.dart';
import 'package:pingvite/features/dashboard/presentation/widgets/custom_appbar.dart';
import 'package:pingvite/features/pay_screen/domain/pay_screen_args.dart';
import 'package:pingvite/features/pay_screen/presentation/widgets/pay_summary_row.dart';
import 'package:pingvite/features/pay_screen/presentation/widgets/pay_ticket_list.dart';

class PayScreen extends StatelessWidget {
  final PayScreenArgs args;
  const PayScreen({super.key, required this.args});

  int get subtotal {
    int sum = 0;
    for (final t in args.tickets) {
      sum += t.basePrice * t.quantity;
    }
    return sum;
  }

  int get tax => (subtotal * 0.18).round();
  int get total => subtotal + tax;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.homebackground,
      appBar: const CustomAppBar.withBackButton(),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 16.rpx, horizontal: 8.rpx),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const EventTitle(Constants.confirmDetails),
              Gap(24.gap),
              Container(
                padding: EdgeInsets.all(16.rpx),
                decoration: BoxDecoration(
                  color: AppColors.white,
                  borderRadius: BorderRadius.circular(16.rpx),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    EventTitle(args.event?.title ?? ''),
                    Gap(16.gap),
                    PayTicketList(tickets: args.tickets),
                    Gap(12.gap),
                    Divider(color: AppColors.blue, thickness: 2),
                    Gap(16.gap),
                    PaySummaryRow(label: Constants.taxes, amount: tax),
                    Gap(12.gap),
                    PaySummaryRow(
                      label: Constants.total,
                      amount: total,
                      isHighlighted: true,
                    ),
                  ],
                ),
              ),
              Gap(32.gap),
              Center(
                child: AppButtonFactory.build(
                  context: context,
                  type: ButtonType.gradient,
                  title: Constants.pay,
                  width: 200.rpx,
                  onPressed: () {},
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
