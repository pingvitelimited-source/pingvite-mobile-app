import 'package:pingvite/features/bottom_tabs/contacts_screen/contact_screen_main/domain/entities/contact_entity.dart';

class ContactResponseModel extends Contact {
  const ContactResponseModel({
    required super.id,
    required super.contactName,
    required super.email,
    required super.mobile,
    super.media,
  });

  factory ContactResponseModel.fromJson(Map<String, dynamic> json) {
    return ContactResponseModel(
      id: json['id'] as int? ?? 0,
      contactName: json['contact_name'] as String? ?? '',
      email: json['email'] as String? ?? '',
      mobile: json['mobile'] as String? ?? '',
      media: json['media'] != null
          ? List<String>.from(json['media'] as List)
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'contact_name': contactName,
      'email': email,
      'mobile': mobile,
      'media': media,
    };
  }
}
