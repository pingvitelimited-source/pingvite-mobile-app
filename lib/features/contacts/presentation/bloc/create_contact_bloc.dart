import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pingvite/features/contacts/domain/usecases/create_contact.dart';
import 'package:pingvite/features/contacts/presentation/bloc/create_contact_event.dart';
import 'package:pingvite/features/contacts/presentation/bloc/create_contact_state.dart';

class CreateContactBloc extends Bloc<CreateContactEvent, CreateContactState> {
  final CreateContactUseCase createContactUseCase;

  CreateContactBloc({required this.createContactUseCase})
    : super(CreateContactInitial()) {
    on<CreateContactSubmitted>(_onCreateContactSubmitted);
  }

  Future<void> _onCreateContactSubmitted(
    CreateContactSubmitted event,
    Emitter<CreateContactState> emit,
  ) async {
    emit(CreateContactLoading());

    final result = await createContactUseCase(
      contact: event.contact,
      base64Image: event.base64Image,
      imageExtension: event.imageExtension,
    );

    result.fold(
      (error) => emit(CreateContactFailure(error: error.toString())),
      (message) => emit(CreateContactSuccess(message: message)),
    );
  }
}
