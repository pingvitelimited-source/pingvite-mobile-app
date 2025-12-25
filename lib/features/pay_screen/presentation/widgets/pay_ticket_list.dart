import 'package:flutter/material.dart';
import 'package:pingvite/features/booking_selection_screen/data/ticket_data.dart';
import 'package:pingvite/features/pay_screen/presentation/widgets/pay_ticket_card.dart';

class PayTicketList extends StatelessWidget {
  final List<TicketData> tickets;

  const PayTicketList({super.key, required this.tickets});

  @override
  Widget build(BuildContext context) {
    final selectedTickets = tickets.where((t) => t.quantity > 0).toList();

    return Column(
      children: selectedTickets.map((t) => PayTicketCard(ticket: t)).toList(),
    );
  }
}
