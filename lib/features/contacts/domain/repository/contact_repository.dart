import 'package:dartz/dartz.dart';
import 'package:pingvite/features/contacts/domain/entities/contact.dart';

abstract class ContactRepository {
  Future<Either<dynamic, String>> createContact({
    required Contact contact,
    String? base64Image,
    String? imageExtension,
  });
}
