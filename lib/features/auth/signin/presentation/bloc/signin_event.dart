abstract class SigninEvent {}

class SigninWithEmailEvent extends SigninEvent {
  final String email;
  final String password;

  SigninWithEmailEvent({
    required this.email,
    required this.password,
  });
}

class SigninWithPhoneEvent extends SigninEvent {
  final String mobile;
  final String password;

  SigninWithPhoneEvent({
    required this.mobile,
    required this.password,
  });
}
