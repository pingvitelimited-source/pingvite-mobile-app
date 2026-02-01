import 'package:dartz/dartz.dart';
import 'package:pingvite/features/auth/otp_screen/domain/entites/send_otp_response_entity.dart';
import 'package:pingvite/service_locator_dependencies.dart';

import '../../domain/repository/send_otp_repository.dart';
import '../source/send_otp_api_service.dart';

class SendOtpRepositoryImpl extends SendOtpRepository {
  @override
  Future<Either<dynamic, SendOtpResponseEntity>> sendOtp(String email) {
    return sl<SendOtpApiService>().sendOtp(email);
  }
}
