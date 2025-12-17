class EventCardData {
  final String image;
  final String title;
  final String? dateTime;
  final String? venue;
  final String? price;

  const EventCardData({
    required this.image,
    required this.title,
    this.dateTime,
    this.venue,
    this.price,
  });
}
