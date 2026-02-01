import 'package:dartz/dartz.dart';
import 'package:pingvite/features/auth/otp_screen/data/model/verify_otp_request_params.dart';
import 'package:pingvite/features/auth/otp_screen/data/source/verify_otp_api_service.dart';
import 'package:pingvite/features/auth/otp_screen/domain/entites/verify_otp_response_entity.dart';
import 'package:pingvite/features/auth/otp_screen/domain/repository/verify_otp_repository.dart';
import 'package:pingvite/service_locator_dependencies.dart';

class VerifyOtpRepositoryImpl implements VerifyOtpRepository {
  @override
  Future<Either<dynamic, VerifyOtpResponseEntity>> verifyOtp({
    required String otpType,
    required String otp,
    required String email,
  }) async {
    final params = VerifyOtpRequestParams(
      otpType: otpType,
      otp: otp,
      email: email,
    );

    final result = await sl<VerifyOtpApiService>().verifyOtp(params);

    return result.fold(
      (error) => Left(error),
      (response) => Right(response),
    );
  }
}
