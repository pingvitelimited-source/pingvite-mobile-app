import 'package:dartz/dartz.dart';
import 'package:pingvite/features/bottom_tabs/contacts_screen/contact_screen_main/domain/entities/contact_entity.dart';

abstract class ContactListRepository {
  Future<Either<dynamic, List<Contact>>> getContactList(int userId);
}
