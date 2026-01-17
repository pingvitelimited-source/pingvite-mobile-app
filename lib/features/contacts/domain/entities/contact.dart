import 'package:equatable/equatable.dart';

class Contact extends Equatable {
  final String? id;
  final String contactName;
  final String email;
  final String mobile;
  final int contactType;
  final String? imagePath;

  const Contact({
    this.id,
    required this.contactName,
    required this.email,
    required this.mobile,
    required this.contactType,
    this.imagePath,
  });

  @override
  List<Object?> get props => [
    id,
    contactName,
    email,
    mobile,
    contactType,
    imagePath,
  ];
}
