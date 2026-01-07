import 'package:dartz/dartz.dart';
import 'package:pingvite/core/utils/usecase.dart';
import 'package:pingvite/features/auth/signup/data/models/signup_request_params.dart';
import 'package:pingvite/features/auth/signup/data/models/signup_response_params.dart';
import 'package:pingvite/features/auth/signup/domain/repository/signup_repository.dart';
import 'package:pingvite/service_locator_dependencies.dart';

class UserSignup implements UseCase<SignupResult, SignupRequestParams> {
  @override
  Future<Either<dynamic, SignupResult>> call({
    SignupRequestParams? params,
  }) async {
    return sl<SignupRepository>().signup(params!);
  }
}
