import 'package:pingvite/features/auth/signup/domain/entities/signup_user.dart';

class SignupRequestParams extends SignupUser {
  const SignupRequestParams({
    required super.firstName,
    super.middleName,
    required super.lastName,
    required super.email,
    required super.mobile,
    required super.password,
    super.userRole,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'first_name': firstName,
      'middle_name': middleName ?? '',
      'last_name': lastName,
      'email': email,
      'mobile': mobile,
      'password': password,
      'user_role': userRole,
    };
  }
}
