import 'package:equatable/equatable.dart';
import 'package:pingvite/features/contacts/domain/entities/contact.dart';

abstract class CreateContactEvent extends Equatable {
  const CreateContactEvent();

  @override
  List<Object?> get props => [];
}

class CreateContactSubmitted extends CreateContactEvent {
  final Contact contact;
  final String? base64Image;
  final String? imageExtension;

  const CreateContactSubmitted({
    required this.contact,
    this.base64Image,
    this.imageExtension,
  });

  @override
  List<Object?> get props => [contact, base64Image, imageExtension];
}
