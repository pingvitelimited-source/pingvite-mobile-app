import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:pingvite/core/network/api_urls.dart';
import 'package:pingvite/core/network/dio_client.dart';
import 'package:pingvite/features/auth/signup/data/models/signup_request_params.dart';
import 'package:pingvite/features/auth/signup/data/models/signup_response_params.dart';
import 'package:pingvite/service_locator_dependencies.dart';

abstract class SignupApiService {
  Future<Either<dynamic, SignupResult>> signup(
    SignupRequestParams params,
  );
}

class SignupApiServiceImpl implements SignupApiService {
  @override
  Future<Either<dynamic, SignupResult>> signup(
    SignupRequestParams params,
  ) async {
    try {
      final response = await sl<DioClient>().post(
        ApiUrls.signup,
        data: params.toMap(),
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        final signupResponse = SignupResponseParams.fromJson(
          response.data['data'] as Map<String, dynamic>,
        );
        final message = response.data['message'] as String? ?? 'Success';
        return Right(SignupResult(message: message, user: signupResponse));
      } else {
        return Left(response.data['message'] ?? 'Signup failed');
      }
    } on DioException catch (e) {
      return Left(e);
    } catch (e) {
      return Left(e.toString());
    }
  }
}
