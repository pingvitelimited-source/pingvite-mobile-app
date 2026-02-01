import 'package:pingvite/features/auth/otp_screen/domain/entites/verify_otp_response_entity.dart';

class VerifyOtpResponseModel extends VerifyOtpResponseEntity {
  VerifyOtpResponseModel({required super.message, required super.code});

  factory VerifyOtpResponseModel.fromMap(Map<String, dynamic> map) {
    return VerifyOtpResponseModel(
      message: map['message'] as String? ?? 'OTP verified',
      code: map['code'] as int? ?? 200,
    );
  }
}
