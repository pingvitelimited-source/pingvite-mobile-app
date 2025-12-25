import 'package:pingvite/core/data/event_card_data.dart';
import 'package:pingvite/features/booking_selection_screen/data/ticket_data.dart';

class PayScreenArgs {
  final EventCardData? event;
  final List<TicketData> tickets;

  const PayScreenArgs({required this.event, required this.tickets});
}
