import 'package:dartz/dartz.dart';
import 'package:pingvite/features/contacts/data/datasources/contact_remote_datasource.dart';
import 'package:pingvite/features/contacts/data/models/contact_model.dart';
import 'package:pingvite/features/contacts/domain/entities/contact.dart';
import 'package:pingvite/features/contacts/domain/repository/contact_repository.dart';

class ContactRepositoryImpl implements ContactRepository {
  final ContactRemoteDataSource remoteDataSource;

  ContactRepositoryImpl({required this.remoteDataSource});

  @override
  Future<Either<dynamic, String>> createContact({
    required Contact contact,
    String? base64Image,
    String? imageExtension,
  }) async {
    try {
      final contactModel = ContactModel(
        id: contact.id,
        contactName: contact.contactName,
        email: contact.email,
        mobile: contact.mobile,
        contactType: contact.contactType,
        imagePath: contact.imagePath,
      );

      final message = await remoteDataSource.createContact(
        contact: contactModel,
        base64Image: base64Image,
        imageExtension: imageExtension,
      );

      return Right(message);
    } catch (e) {
      return Left(e.toString());
    }
  }
}
