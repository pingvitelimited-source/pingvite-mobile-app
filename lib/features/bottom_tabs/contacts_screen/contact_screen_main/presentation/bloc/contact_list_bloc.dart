import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:pingvite/features/bottom_tabs/contacts_screen/contact_screen_main/domain/entities/contact_entity.dart';
import 'package:pingvite/features/bottom_tabs/contacts_screen/contact_screen_main/domain/usecases/get_contact_list_usecase.dart';
import 'package:pingvite/service_locator_dependencies.dart';

part 'contact_list_event.dart';
part 'contact_list_state.dart';

class ContactListBloc extends Bloc<ContactListEvent, ContactListState> {
  ContactListBloc() : super(const ContactListInitial()) {
    on<FetchContactListEvent>(_onFetchContactList);
    on<RefreshContactListEvent>(_onRefreshContactList);
  }

  Future<void> _onFetchContactList(
    FetchContactListEvent event,
    Emitter<ContactListState> emit,
  ) async {
    emit(const ContactListLoading());

    final result = await sl<GetContactListUseCase>().call(params: event.userId);

    result.fold(
      (failure) => emit(ContactListFailure(message: failure.toString())),
      (contacts) => emit(ContactListSuccess(contacts: contacts)),
    );
  }

  Future<void> _onRefreshContactList(
    RefreshContactListEvent event,
    Emitter<ContactListState> emit,
  ) async {
    emit(const ContactListLoading());

    final result = await sl<GetContactListUseCase>().call(params: event.userId);

    result.fold(
      (failure) => emit(ContactListFailure(message: failure.toString())),
      (contacts) => emit(ContactListSuccess(contacts: contacts)),
    );
  }
}
