import 'package:dartz/dartz.dart';
import 'package:pingvite/core/utils/usecase.dart';
import 'package:pingvite/features/auth/signin/domain/entities/login_user.dart';
import 'package:pingvite/features/auth/signin/domain/repository/login_repository.dart';

class UserLoginWithEmail implements UseCase<LoginUser, LoginWithEmailParams> {
  final LoginRepository repository;

  UserLoginWithEmail(this.repository);

  @override
  Future<Either<dynamic, LoginUser>> call({LoginWithEmailParams? params}) async {
    return await repository.loginWithEmail(
      email: params!.email,
      password: params.password,
    );
  }
}

class LoginWithEmailParams {
  final String email;
  final String password;

  LoginWithEmailParams({
    required this.email,
    required this.password,
  });
}
