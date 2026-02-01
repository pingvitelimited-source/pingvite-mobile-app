import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:pingvite/core/network/api_urls.dart';
import 'package:pingvite/core/network/dio_client.dart';
import 'package:pingvite/features/auth/otp_screen/data/model/verify_otp_request_params.dart';
import 'package:pingvite/features/auth/otp_screen/data/model/verify_otp_response_model.dart';
import 'package:pingvite/service_locator_dependencies.dart';

abstract class VerifyOtpApiService {
  Future<Either<dynamic, VerifyOtpResponseModel>> verifyOtp(
    VerifyOtpRequestParams params,
  );
}

class VerifyOtpApiServiceImpl implements VerifyOtpApiService {
  @override
  Future<Either<dynamic, VerifyOtpResponseModel>> verifyOtp(
    VerifyOtpRequestParams params,
  ) async {
    try {
      final response = await sl<DioClient>().post(
        ApiUrls.verifyOtp,
        data: params.toMap(),
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        final data = VerifyOtpResponseModel.fromMap(
          response.data as Map<String, dynamic>,
        );
        return Right(data);
      }

      return Left(response.data['message'] ?? 'OTP verification failed');
    } on DioException catch (e) {
      if (e.type == DioExceptionType.connectionError ||
          e.type == DioExceptionType.connectionTimeout) {
        return Left('No internet connection!');
      }
      final errorMessage =
          e.response?.data['message'] ?? e.message ?? 'OTP verification failed';
      return Left(errorMessage);
    } catch (e) {
      return Left(e.toString());
    }
  }
}
