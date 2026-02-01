import 'package:pingvite/features/auth/otp_screen/domain/entites/send_otp_response_entity.dart';

class SendOtpResponseModel extends SendOtpResponseEntity {
  SendOtpResponseModel({required super.message, required super.code});

  factory SendOtpResponseModel.fromMap(Map<String, dynamic> map) {
    return SendOtpResponseModel(
      message: map['message'] as String,
      code: map['code'] as int,
    );
  }
}
