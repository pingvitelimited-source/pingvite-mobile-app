import 'package:pingvite/features/contacts/domain/entities/contact.dart';

class ContactModel extends Contact {
  const ContactModel({
    super.id,
    required super.contactName,
    required super.email,
    required super.mobile,
    required super.contactType,
    super.imagePath,
  });

  Map<String, dynamic> toJson({String? base64Image, String? imageExtension}) {
    final Map<String, dynamic> data = {
      'contact_type': contactType,
      'contact_name': contactName,
      'email': email,
      'mobile': mobile,
      'media': [],
    };

    if (base64Image != null && imageExtension != null) {
      data['media'] = [
        {
          'file_type': 'contact',
          'file_location': 'gallery',
          'file': base64Image,
          'file_extension': imageExtension,
        },
      ];
    }

    return data;
  }

  factory ContactModel.fromJson(Map<String, dynamic> json) {
    return ContactModel(
      id: json['id']?.toString(),
      contactName: json['contact_name'] ?? '',
      email: json['email'] ?? '',
      mobile: json['mobile'] ?? '',
      contactType: json['contact_type'] ?? 1,
      imagePath: json['image_path'],
    );
  }
}
