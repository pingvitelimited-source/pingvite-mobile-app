class TransactionDetails {
  final String transactionId;
  final String eventTitle;
  final String eventLocation;
  final String eventDateTime;
  final List<TicketDetail> tickets;
  final int gst;
  final int total;

  TransactionDetails({
    required this.transactionId,
    required this.eventTitle,
    required this.eventLocation,
    required this.eventDateTime,
    required this.tickets,
    required this.gst,
    required this.total,
  });
}

class TicketDetail {
  final String ticketName;
  final String location;
  final String dateTime;
  final int quantity;
  final int price;

  TicketDetail({
    required this.ticketName,
    required this.location,
    required this.dateTime,
    required this.quantity,
    required this.price,
  });
}
