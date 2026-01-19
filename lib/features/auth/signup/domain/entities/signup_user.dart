import 'package:equatable/equatable.dart';

class SignupUser extends Equatable {
  final String firstName;
  final String? middleName;
  final String lastName;
  final String email;
  final String mobile;
  final String password;
  final String userRole;

  const SignupUser({
    required this.firstName,
    this.middleName,
    required this.lastName,
    required this.email,
    required this.mobile,
    required this.password,
    this.userRole = '1',
  });

  @override
  List<Object?> get props => [
    firstName,
    middleName,
    lastName,
    email,
    mobile,
    password,
    userRole,
  ];
}
