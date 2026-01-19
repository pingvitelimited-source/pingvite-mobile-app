import 'package:pingvite/features/auth/signin/domain/entities/login_user.dart';

class LoginResponseParams {
  final String status;
  final String message;
  final String token;
  final String refreshToken;

  LoginResponseParams({
    required this.status,
    required this.message,
    required this.token,
    required this.refreshToken,
  });

  factory LoginResponseParams.fromJson(Map<String, dynamic> json) {
    return LoginResponseParams(
      status: json['status']?.toString() ?? '',
      message: json['message']?.toString() ?? '',
      token: json['token']?.toString() ?? '',
      refreshToken: json['refresh_token']?.toString() ?? '',
    );
  }

  LoginUser toEntity() {
    return LoginUser(
      accessToken: token,
      refreshToken: refreshToken,
      message: message,
    );
  }
}

/// Wrapper class to hold the login result with the server message
class LoginResult {
  final LoginUser user;
  final String message;

  LoginResult({required this.user, required this.message});
}
