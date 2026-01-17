import 'package:equatable/equatable.dart';

abstract class CreateContactState extends Equatable {
  const CreateContactState();

  @override
  List<Object?> get props => [];
}

class CreateContactInitial extends CreateContactState {}

class CreateContactLoading extends CreateContactState {}

class CreateContactSuccess extends CreateContactState {
  final String message;

  const CreateContactSuccess({required this.message});

  @override
  List<Object?> get props => [message];
}

class CreateContactFailure extends CreateContactState {
  final String error;

  const CreateContactFailure({required this.error});

  @override
  List<Object?> get props => [error];
}
