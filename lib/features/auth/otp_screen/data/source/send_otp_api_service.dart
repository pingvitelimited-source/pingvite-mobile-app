import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:pingvite/core/network/api_urls.dart';
import 'package:pingvite/core/network/dio_client.dart';
import 'package:pingvite/features/auth/otp_screen/data/model/send_otp_response_model.dart';
import 'package:pingvite/features/auth/otp_screen/domain/entites/send_otp_response_entity.dart';
import 'package:pingvite/service_locator_dependencies.dart';

abstract class SendOtpApiService {
  Future<Either<dynamic, SendOtpResponseEntity>> sendOtp(String email);
}

class SendOtpApiServiceImpl extends SendOtpApiService {
  @override
  Future<Either<dynamic, SendOtpResponseEntity>> sendOtp(String email) async {
    try {
      final response = await sl<DioClient>().get(
        ApiUrls.sendRegisterOtp(email),
      );

      final data = SendOtpResponseModel.fromMap(response.data);
      return Right(data);
    } on DioException catch (e) {
      return Left(e.message);
    }
  }
}
