import 'package:dartz/dartz.dart';

abstract class UseCase<SuccessType, Params> {
  Future<Either<dynamic, SuccessType>> call({Params? params});
}

class NoParams {}
