import 'package:pingvite/features/auth/signin/domain/entities/login_user.dart';

abstract class SigninState {}

class SigninInitial extends SigninState {}

class SigninLoading extends SigninState {}

class SigninSuccess extends SigninState {
  final LoginUser user;
  final String message;

  SigninSuccess({
    required this.user,
    required this.message,
  });
}

class SigninFailure extends SigninState {
  final String message;

  SigninFailure(this.message);
}
