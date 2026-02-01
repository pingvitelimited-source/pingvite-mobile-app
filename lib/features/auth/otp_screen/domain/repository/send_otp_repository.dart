import 'package:dartz/dartz.dart';
import 'package:pingvite/features/auth/otp_screen/domain/entites/send_otp_response_entity.dart';

abstract class SendOtpRepository {
  Future<Either<dynamic, SendOtpResponseEntity>> sendOtp(String email);
}
