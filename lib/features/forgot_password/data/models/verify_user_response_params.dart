import 'package:pingvite/features/forgot_password/domain/entities/verify_user.dart';

class VerifyUserResponseParams {
  final int status;
  final String message;
  final bool userExist;

  VerifyUserResponseParams({
    required this.status,
    required this.message,
    required this.userExist,
  });

  factory VerifyUserResponseParams.fromJson(Map<String, dynamic> json) {
    return VerifyUserResponseParams(
      status: json['status'] as int? ?? 0,
      message: json['message']?.toString() ?? '',
      userExist: json['userExist'] as bool? ?? false,
    );
  }

  VerifyUser toEntity() {
    return VerifyUser(status: status, message: message, userExist: userExist);
  }
}
