import 'package:pingvite/core/network/api_urls.dart';
import 'package:pingvite/core/network/dio_client.dart';
import 'package:pingvite/features/contacts/data/models/contact_model.dart';

abstract class ContactRemoteDataSource {
  Future<String> createContact({
    required ContactModel contact,
    String? base64Image,
    String? imageExtension,
  });
}

class ContactRemoteDataSourceImpl implements ContactRemoteDataSource {
  final DioClient dioClient;

  ContactRemoteDataSourceImpl({required this.dioClient});

  @override
  Future<String> createContact({
    required ContactModel contact,
    String? base64Image,
    String? imageExtension,
  }) async {
    try {
      final response = await dioClient.post(
        ApiUrls.contact,
        data: contact.toJson(
          base64Image: base64Image,
          imageExtension: imageExtension,
        ),
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        // API returns {"status": 200, "message": "Contact Created Successfully"}
        return response.data['message'] ?? 'Contact created successfully';
      } else {
        throw Exception('Failed to create contact: ${response.statusCode}');
      }
    } catch (e) {
      rethrow;
    }
  }
}
