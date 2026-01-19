part of 'verify_user_bloc.dart';

abstract class VerifyUserEvent {}

class VerifyUserSubmitted extends VerifyUserEvent {
  final String type;
  final String value;

  VerifyUserSubmitted({required this.type, required this.value});
}

class VerifyUserReset extends VerifyUserEvent {}
