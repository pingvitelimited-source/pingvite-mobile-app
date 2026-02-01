import 'package:dartz/dartz.dart';
import 'package:pingvite/core/utils/usecase.dart';
import 'package:pingvite/features/bottom_tabs/contacts_screen/contact_screen_main/domain/entities/contact_entity.dart';
import 'package:pingvite/features/bottom_tabs/contacts_screen/contact_screen_main/domain/repositories/contact_list_repository.dart';
import 'package:pingvite/service_locator_dependencies.dart';

class GetContactListUseCase implements UseCase<List<Contact>, int> {
  @override
  Future<Either<dynamic, List<Contact>>> call({int? params}) async {
    return await sl<ContactListRepository>().getContactList(params ?? 0);
  }
}
