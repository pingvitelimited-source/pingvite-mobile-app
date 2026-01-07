import 'package:dartz/dartz.dart';
import 'package:pingvite/core/utils/usecase.dart';
import 'package:pingvite/features/auth/signin/domain/entities/login_user.dart';
import 'package:pingvite/features/auth/signin/domain/repository/login_repository.dart';

class UserLoginWithPhone implements UseCase<LoginUser, LoginWithPhoneParams> {
  final LoginRepository repository;

  UserLoginWithPhone(this.repository);

  @override
  Future<Either<dynamic, LoginUser>> call({LoginWithPhoneParams? params}) async {
    return await repository.loginWithPhone(
      mobile: params!.mobile,
      password: params.password,
    );
  }
}

class LoginWithPhoneParams {
  final String mobile;
  final String password;

  LoginWithPhoneParams({
    required this.mobile,
    required this.password,
  });
}
