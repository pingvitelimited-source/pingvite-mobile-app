import 'package:dartz/dartz.dart';
import 'package:pingvite/core/utils/usecase.dart';
import 'package:pingvite/features/auth/otp_screen/domain/entites/send_otp_response_entity.dart';
import 'package:pingvite/service_locator_dependencies.dart';

import '../repository/send_otp_repository.dart';

class SendOtpUsecase extends UseCase<SendOtpResponseEntity, String> {
  @override
  Future<Either<dynamic, SendOtpResponseEntity>> call({String? params}) async {
    return await sl<SendOtpRepository>().sendOtp(params!);
  }
}
