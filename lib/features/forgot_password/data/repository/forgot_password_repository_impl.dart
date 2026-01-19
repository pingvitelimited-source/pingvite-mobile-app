import 'package:dartz/dartz.dart';
import 'package:pingvite/features/auth/signin/data/models/login_request_params.dart';
import 'package:pingvite/features/forgot_password/data/datasources/forgot_password_api_service.dart';
import 'package:pingvite/features/forgot_password/domain/repository/forgot_password_repository.dart';
import 'package:pingvite/service_locator_dependencies.dart';

class ForgotPasswordRepositoryImpl implements ForgotPasswordRepository {
  @override
  Future<Either<dynamic, String>> resetPassword({
    required String type,
    required String value,
    required String password,
  }) async {
    final params = type == 'email'
        ? LoginRequestParams(email: value, password: password)
        : LoginRequestParams(mobile: value, password: password);

    final result = await sl<ForgotPasswordApiService>().resetPassword(params);

    return result.fold(
      (error) => Left(error),
      (response) => Right(response.message),
    );
  }
}
