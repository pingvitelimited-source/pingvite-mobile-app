import 'package:dartz/dartz.dart';
import 'package:pingvite/features/auth/signin/domain/entities/login_user.dart';

abstract class LoginRepository {
  Future<Either<dynamic, LoginUser>> loginWithEmail({
    required String email,
    required String password,
  });

  Future<Either<dynamic, LoginUser>> loginWithPhone({
    required String mobile,
    required String password,
  });
}
