import 'package:equatable/equatable.dart';

class Contact extends Equatable {
  final int id;
  final String contactName;
  final String email;
  final String mobile;
  final List<String>? media;

  const Contact({
    required this.id,
    required this.contactName,
    required this.email,
    required this.mobile,
    this.media,
  });

  @override
  List<Object?> get props => [id, contactName, email, mobile, media];
}
