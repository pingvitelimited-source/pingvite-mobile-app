part of 'reset_password_bloc.dart';

abstract class ResetPasswordEvent {}

class ResetPasswordSubmitted extends ResetPasswordEvent {
  final String type;
  final String value;
  final String password;

  ResetPasswordSubmitted({
    required this.type,
    required this.value,
    required this.password,
  });
}

class ResetPasswordReset extends ResetPasswordEvent {}
