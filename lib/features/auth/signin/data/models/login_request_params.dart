class LoginRequestParams {
  final String? email;
  final String? mobile;
  final String password;

  LoginRequestParams({this.email, this.mobile, required this.password})
    : assert(
        email != null || mobile != null,
        'Either email or mobile is required',
      );

  Map<String, dynamic> toMapWithEmail() {
    return {'type': 'email', 'value': email, 'password': password};
  }

  Map<String, dynamic> toMapWithPhone() {
    return {'type': 'mobile', 'value': mobile, 'password': password};
  }
}
