import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:pingvite/core/network/api_urls.dart';
import 'package:pingvite/core/network/dio_client.dart';
import 'package:pingvite/features/forgot_password/data/models/verify_user_request_params.dart';
import 'package:pingvite/features/forgot_password/data/models/verify_user_response_params.dart';
import 'package:pingvite/service_locator_dependencies.dart';

abstract class VerifyUserApiService {
  Future<Either<dynamic, VerifyUserResponseParams>> verifyUser(
    VerifyUserRequestParams params,
  );
}

class VerifyUserApiServiceImpl implements VerifyUserApiService {
  @override
  Future<Either<dynamic, VerifyUserResponseParams>> verifyUser(
    VerifyUserRequestParams params,
  ) async {
    try {
      final response = await sl<DioClient>().post(
        ApiUrls.verifyUser,
        data: params.toMap(),
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        final verifyUserResponse = VerifyUserResponseParams.fromJson(
          response.data as Map<String, dynamic>,
        );
        return Right(verifyUserResponse);
      } else {
        return Left(response.data['message'] ?? 'User verification failed');
      }
    } on DioException catch (e) {
      if (e.type == DioExceptionType.connectionError ||
          e.type == DioExceptionType.connectionTimeout) {
        return Left('No internet connection!');
      }
      final errorMessage =
          e.response?.data['message'] ?? e.message ?? 'Verification failed';
      return Left(errorMessage);
    } catch (e) {
      return Left(e.toString());
    }
  }
}
