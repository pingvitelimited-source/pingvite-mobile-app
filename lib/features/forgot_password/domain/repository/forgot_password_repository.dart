import 'package:dartz/dartz.dart';

abstract class ForgotPasswordRepository {
  Future<Either<dynamic, String>> resetPassword({
    required String type,
    required String value,
    required String password,
  });
}
