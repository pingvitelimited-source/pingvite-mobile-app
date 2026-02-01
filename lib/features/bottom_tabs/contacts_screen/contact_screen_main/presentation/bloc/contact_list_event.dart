part of 'contact_list_bloc.dart';

abstract class ContactListEvent extends Equatable {
  const ContactListEvent();

  @override
  List<Object?> get props => [];
}

class FetchContactListEvent extends ContactListEvent {
  final int userId;

  const FetchContactListEvent({required this.userId});

  @override
  List<Object?> get props => [userId];
}

class RefreshContactListEvent extends ContactListEvent {
  final int userId;

  const RefreshContactListEvent({required this.userId});

  @override
  List<Object?> get props => [userId];
}
