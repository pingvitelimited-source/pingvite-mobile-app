import 'package:dartz/dartz.dart';
import 'package:pingvite/features/auth/otp_screen/domain/entites/verify_otp_response_entity.dart';

abstract class VerifyOtpRepository {
  Future<Either<dynamic, VerifyOtpResponseEntity>> verifyOtp({
    required String otpType,
    required String otp,
    required String email,
  });
}
