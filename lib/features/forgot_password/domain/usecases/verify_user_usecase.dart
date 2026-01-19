import 'package:dartz/dartz.dart';
import 'package:pingvite/core/utils/usecase.dart';
import 'package:pingvite/features/forgot_password/domain/entities/verify_user.dart';
import 'package:pingvite/features/forgot_password/domain/repository/verify_user_repository.dart';
import 'package:pingvite/service_locator_dependencies.dart';

class VerifyUserUseCase implements UseCase<VerifyUser, VerifyUserParams> {
  @override
  Future<Either<dynamic, VerifyUser>> call({VerifyUserParams? params}) async {
    return await sl<VerifyUserRepository>().verifyUser(
      type: params!.type,
      value: params.value,
    );
  }
}

class VerifyUserParams {
  final String type;
  final String value;

  VerifyUserParams({required this.type, required this.value});
}
