import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:pingvite/core/network/api_urls.dart';
import 'package:pingvite/core/network/dio_client.dart';
import 'package:pingvite/features/bottom_tabs/contacts_screen/contact_screen_main/data/models/contact_response_model.dart';
import 'package:pingvite/service_locator_dependencies.dart';

abstract class ContactListApiService {
  Future<Either<dynamic, List<ContactResponseModel>>> getContactList(
    int userId,
  );
}

class ContactListApiServiceImpl implements ContactListApiService {
  @override
  Future<Either<dynamic, List<ContactResponseModel>>> getContactList(
    int userId,
  ) async {
    try {
      final response = await sl<DioClient>().get(
        ApiUrls.getContactList(userId),
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        final contactsList = (response.data as List)
            .map(
              (contact) => ContactResponseModel.fromJson(
                contact as Map<String, dynamic>,
              ),
            )
            .toList();
        return Right(contactsList);
      } else {
        return Left(response.data['message'] ?? 'Failed to fetch contacts');
      }
    } on DioException catch (e) {
      if (e.type == DioExceptionType.connectionError ||
          e.type == DioExceptionType.connectionTimeout) {
        return Left('No internet connection!');
      }
      final errorMessage =
          e.response?.data['message'] ??
          e.message ??
          'Failed to fetch contacts';
      return Left(errorMessage);
    } catch (e) {
      return Left(e.toString());
    }
  }
}
