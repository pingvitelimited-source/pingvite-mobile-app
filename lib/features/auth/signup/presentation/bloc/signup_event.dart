part of 'signup_bloc.dart';

sealed class SignupEvent {}

final class SignupSubmitted extends SignupEvent {
  final String firstName;
  final String? middleName;
  final String lastName;
  final String email;
  final String mobile;
  final String password;

  SignupSubmitted({
    required this.firstName,
    this.middleName,
    required this.lastName,
    required this.email,
    required this.mobile,
    required this.password,
  });
}

final class SignupReset extends SignupEvent {}
