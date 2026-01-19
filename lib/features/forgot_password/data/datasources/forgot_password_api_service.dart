import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:pingvite/core/network/api_urls.dart';
import 'package:pingvite/core/network/dio_client.dart';
import 'package:pingvite/features/auth/signin/data/models/login_request_params.dart';
import 'package:pingvite/features/forgot_password/data/models/forgot_password_response_params.dart';
import 'package:pingvite/service_locator_dependencies.dart';

abstract class ForgotPasswordApiService {
  Future<Either<dynamic, ForgotPasswordResponseParams>> resetPassword(
    LoginRequestParams params,
  );
}

class ForgotPasswordApiServiceImpl implements ForgotPasswordApiService {
  @override
  Future<Either<dynamic, ForgotPasswordResponseParams>> resetPassword(
    LoginRequestParams params,
  ) async {
    try {
      final data = params.email != null
          ? params.toMapWithEmail()
          : params.toMapWithPhone();

      final response = await sl<DioClient>().put(
        ApiUrls.forgotPassword,
        data: data,
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        final resetResponse = ForgotPasswordResponseParams.fromJson(
          response.data as Map<String, dynamic>,
        );
        return Right(resetResponse);
      } else {
        return Left(response.data['message'] ?? 'Password reset failed');
      }
    } on DioException catch (e) {
      if (e.type == DioExceptionType.connectionError ||
          e.type == DioExceptionType.connectionTimeout) {
        return Left('No internet connection!');
      }
      final errorMessage =
          e.response?.data['message'] ?? e.message ?? 'Password reset failed';
      return Left(errorMessage);
    } catch (e) {
      return Left(e.toString());
    }
  }
}
