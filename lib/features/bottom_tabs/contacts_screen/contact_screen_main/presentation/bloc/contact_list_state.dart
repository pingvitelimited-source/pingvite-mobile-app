part of 'contact_list_bloc.dart';

abstract class ContactListState extends Equatable {
  const ContactListState();

  @override
  List<Object?> get props => [];
}

class ContactListInitial extends ContactListState {
  const ContactListInitial();
}

class ContactListLoading extends ContactListState {
  const ContactListLoading();
}

class ContactListSuccess extends ContactListState {
  final List<Contact> contacts;

  const ContactListSuccess({required this.contacts});

  @override
  List<Object?> get props => [contacts];
}

class ContactListFailure extends ContactListState {
  final String message;

  const ContactListFailure({required this.message});

  @override
  List<Object?> get props => [message];
}
