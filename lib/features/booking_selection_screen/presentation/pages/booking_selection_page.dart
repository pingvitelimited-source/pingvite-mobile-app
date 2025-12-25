import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:pingvite/core/constants/constants.dart';
import 'package:pingvite/core/custom_widgets/factory/app_button_factory.dart';
import 'package:pingvite/core/data/event_card_data.dart';
import 'package:pingvite/core/routes.dart';
import 'package:pingvite/features/pay_screen/domain/pay_screen_args.dart';
import 'package:pingvite/core/theme/app_colors.dart';
import 'package:pingvite/core/utils/event_header_info.dart';
import 'package:pingvite/core/utils/size_extension.dart';
import 'package:pingvite/features/dashboard/presentation/widgets/custom_appbar.dart';
import 'package:pingvite/features/booking_selection_screen/data/ticket_data.dart';
import 'package:pingvite/features/booking_selection_screen/presentation/widgets/ticket_card.dart';

class BookingSelectionPage extends StatefulWidget {
  final EventCardData? data;
  const BookingSelectionPage({super.key, required this.data});

  @override
  State<BookingSelectionPage> createState() => _BookingSelectionPageState();
}

class _BookingSelectionPageState extends State<BookingSelectionPage> {
  // Dummy ticket data - this will come from server in real implementation
  late List<TicketData> tickets;

  @override
  void initState() {
    super.initState();
    tickets = [
      TicketData(
        title: 'Visitor Day Pass',
        venue: widget.data?.venue ?? 'Jio World Convention Center',
        dateTime: widget.data?.dateTime ?? '02 OCT, 02:00 PM',
        basePrice: 100,
        quantity: 2,
      ),
      TicketData(
        title: 'Delegate Day Pass',
        venue: widget.data?.venue ?? 'Jio World Convention Center',
        dateTime: widget.data?.dateTime ?? '02 OCT, 02:00 PM',
        basePrice: 500,
        quantity: 1,
      ),
      TicketData(
        title: 'All Access VIP Pass',
        venue: widget.data?.venue ?? 'Jio World Convention Center',
        dateTime: widget.data?.dateTime ?? '02 OCT, 02:00 PM',
        basePrice: 1000,
        quantity: 0,
      ),
    ];
  }

  void _incrementQuantity(int index) {
    setState(() {
      tickets[index].quantity++;
    });
  }

  void _decrementQuantity(int index) {
    setState(() {
      if (tickets[index].quantity > 0) {
        tickets[index].quantity--;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.homebackground,
      appBar: CustomAppBar.withBackButton(),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 16.rpx, horizontal: 4.rpx),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              EventHeaderInfo(data: widget.data),
              Gap(10.gap),
              ...List.generate(
                tickets.length,
                (index) => TicketCard(
                  ticketData: tickets[index],
                  onIncrement: () => _incrementQuantity(index),
                  onDecrement: () => _decrementQuantity(index),
                ),
              ),
              Gap(30.gap),
              Center(
                child: AppButtonFactory.build(
                  context: context,
                  type: ButtonType.gradient,
                  title: Constants.pay,
                  width: 200.rpx,
                  onPressed: () {
                    final selected = tickets
                        .where((t) => t.quantity > 0)
                        .toList();
                    Navigator.pushNamed(
                      context,
                      AppRoutes.pay,
                      arguments: PayScreenArgs(
                        event: widget.data,
                        tickets: selected,
                      ),
                    );
                  },
                ),
              ),
              Gap(50.gap),
            ],
          ),
        ),
      ),
    );
  }
}
