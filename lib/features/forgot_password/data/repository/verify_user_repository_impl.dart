import 'package:dartz/dartz.dart';
import 'package:pingvite/features/forgot_password/data/datasources/verify_user_api_service.dart';
import 'package:pingvite/features/forgot_password/data/models/verify_user_request_params.dart';
import 'package:pingvite/features/forgot_password/domain/entities/verify_user.dart';
import 'package:pingvite/features/forgot_password/domain/repository/verify_user_repository.dart';
import 'package:pingvite/service_locator_dependencies.dart';

class VerifyUserRepositoryImpl implements VerifyUserRepository {
  @override
  Future<Either<dynamic, VerifyUser>> verifyUser({
    required String type,
    required String value,
  }) async {
    final params = VerifyUserRequestParams(type: type, value: value);
    final result = await sl<VerifyUserApiService>().verifyUser(params);

    return result.fold(
      (error) => Left(error),
      (response) => Right(response.toEntity()),
    );
  }
}
