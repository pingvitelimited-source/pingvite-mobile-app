import 'package:dartz/dartz.dart';
import 'package:pingvite/core/utils/usecase.dart';
import 'package:pingvite/features/forgot_password/domain/repository/forgot_password_repository.dart';
import 'package:pingvite/service_locator_dependencies.dart';

class ResetPasswordUseCase implements UseCase<String, ResetPasswordParams> {
  @override
  Future<Either<dynamic, String>> call({ResetPasswordParams? params}) async {
    return await sl<ForgotPasswordRepository>().resetPassword(
      type: params!.type,
      value: params.value,
      password: params.password,
    );
  }
}

class ResetPasswordParams {
  final String type;
  final String value;
  final String password;

  ResetPasswordParams({
    required this.type,
    required this.value,
    required this.password,
  });
}
