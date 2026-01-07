import 'package:dartz/dartz.dart';
import 'package:pingvite/features/auth/signup/data/models/signup_request_params.dart';
import 'package:pingvite/features/auth/signup/data/models/signup_response_params.dart';

abstract class SignupRepository {
  Future<Either<dynamic, SignupResult>> signup(
    SignupRequestParams params,
  );
}
