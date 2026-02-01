import 'package:dartz/dartz.dart';
import 'package:pingvite/core/utils/usecase.dart';
import 'package:pingvite/features/auth/otp_screen/domain/entites/verify_otp_response_entity.dart';
import 'package:pingvite/features/auth/otp_screen/domain/repository/verify_otp_repository.dart';
import 'package:pingvite/service_locator_dependencies.dart';

class VerifyOtpUsecase
    implements UseCase<VerifyOtpResponseEntity, VerifyOtpParams> {
  @override
  Future<Either<dynamic, VerifyOtpResponseEntity>> call({
    VerifyOtpParams? params,
  }) async {
    return await sl<VerifyOtpRepository>().verifyOtp(
      otpType: params!.otpType,
      otp: params.otp,
      email: params.email,
    );
  }
}

class VerifyOtpParams {
  final String otpType;
  final String otp;
  final String email;

  VerifyOtpParams({
    required this.otpType,
    required this.otp,
    required this.email,
  });
}
