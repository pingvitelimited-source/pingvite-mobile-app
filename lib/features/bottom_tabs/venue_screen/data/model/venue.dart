class Venue {
  final String name;
  final String location;
  final String address;
  final String capacity;
  final String image;
  final bool isDraft;

  Venue({
    required this.name,
    required this.location,
    required this.address,
    required this.capacity,
    required this.image,
    this.isDraft = false,
  });
}
