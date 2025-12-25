class TicketData {
  final String title;
  final String venue;
  final String dateTime;
  final int basePrice;
  int quantity;

  TicketData({
    required this.title,
    required this.venue,
    required this.dateTime,
    required this.basePrice,
    this.quantity = 0,
  });

  int get totalPrice => basePrice * quantity;
}
