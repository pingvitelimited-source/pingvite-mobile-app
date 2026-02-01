import 'package:dartz/dartz.dart';
import 'package:pingvite/features/bottom_tabs/contacts_screen/contact_screen_main/data/datasources/contact_list_api_service.dart';
import 'package:pingvite/features/bottom_tabs/contacts_screen/contact_screen_main/domain/entities/contact_entity.dart';
import 'package:pingvite/features/bottom_tabs/contacts_screen/contact_screen_main/domain/repositories/contact_list_repository.dart';

class ContactListRepositoryImpl implements ContactListRepository {
  final ContactListApiService apiService;

  ContactListRepositoryImpl({required this.apiService});

  @override
  Future<Either<dynamic, List<Contact>>> getContactList(int userId) async {
    final result = await apiService.getContactList(userId);

    return result.fold(
      (error) => Left(error),
      (contacts) => Right(contacts.cast<Contact>()),
    );
  }
}
