import 'package:dartz/dartz.dart';
import 'package:pingvite/features/forgot_password/domain/entities/verify_user.dart';

abstract class VerifyUserRepository {
  Future<Either<dynamic, VerifyUser>> verifyUser({
    required String type,
    required String value,
  });
}
