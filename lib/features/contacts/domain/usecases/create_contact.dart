import 'package:dartz/dartz.dart';
import 'package:pingvite/features/contacts/domain/entities/contact.dart';
import 'package:pingvite/features/contacts/domain/repository/contact_repository.dart';

class CreateContactUseCase {
  final ContactRepository repository;

  CreateContactUseCase(this.repository);

  Future<Either<dynamic, String>> call({
    required Contact contact,
    String? base64Image,
    String? imageExtension,
  }) async {
    return await repository.createContact(
      contact: contact,
      base64Image: base64Image,
      imageExtension: imageExtension,
    );
  }
}
