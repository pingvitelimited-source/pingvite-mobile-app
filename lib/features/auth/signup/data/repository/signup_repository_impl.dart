import 'package:dartz/dartz.dart';
import 'package:pingvite/features/auth/signup/data/models/signup_request_params.dart';
import 'package:pingvite/features/auth/signup/data/models/signup_response_params.dart';
import 'package:pingvite/features/auth/signup/data/source/signup_api_service.dart';
import 'package:pingvite/features/auth/signup/domain/repository/signup_repository.dart';
import 'package:pingvite/service_locator_dependencies.dart';

class SignupRepositoryImpl implements SignupRepository {
  @override
  Future<Either<dynamic, SignupResult>> signup(
    SignupRequestParams params,
  ) {
    return sl<SignupApiService>().signup(params);
  }
}
