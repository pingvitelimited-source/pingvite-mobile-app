class ContactListData {
  final String name;
  final String createdDate;
  final int contactCount;
  final List<String> tags;

  const ContactListData({
    required this.name,
    required this.createdDate,
    required this.contactCount,
    required this.tags,
  });

  String get firstLetter => name.isNotEmpty ? name[0].toUpperCase() : '';
}
