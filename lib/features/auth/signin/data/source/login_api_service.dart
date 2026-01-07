import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:pingvite/core/network/api_urls.dart';
import 'package:pingvite/core/network/dio_client.dart';
import 'package:pingvite/features/auth/signin/data/models/login_request_params.dart';
import 'package:pingvite/features/auth/signin/data/models/login_response_params.dart';

abstract class LoginApiService {
  Future<Either<dynamic, LoginResponseParams>> loginWithEmail(LoginRequestParams params);
  Future<Either<dynamic, LoginResponseParams>> loginWithPhone(LoginRequestParams params);
}

class LoginApiServiceImpl implements LoginApiService {
  final DioClient _dioClient;

  LoginApiServiceImpl(this._dioClient);

  @override
  Future<Either<dynamic, LoginResponseParams>> loginWithEmail(
      LoginRequestParams params) async {
    try {
      final response = await _dioClient.post(
        ApiUrls.login,
        data: params.toMapWithEmail(),
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        final loginResponse = LoginResponseParams.fromJson(
          response.data as Map<String, dynamic>,
        );
        return Right(loginResponse);
      } else {
        return Left(response.data['message'] ?? 'Login failed');
      }
    } on DioException catch (e) {
      final errorMessage = e.response?.data['message'] ?? e.message ?? 'Login failed';
      return Left(errorMessage);
    } catch (e) {
      return Left(e.toString());
    }
  }

  @override
  Future<Either<dynamic, LoginResponseParams>> loginWithPhone(
      LoginRequestParams params) async {
    try {
      final response = await _dioClient.post(
        ApiUrls.login,
        data: params.toMapWithPhone(),
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        final loginResponse = LoginResponseParams.fromJson(
          response.data as Map<String, dynamic>,
        );
        return Right(loginResponse);
      } else {
        return Left(response.data['message'] ?? 'Login failed');
      }
    } on DioException catch (e) {
      final errorMessage = e.response?.data['message'] ?? e.message ?? 'Login failed';
      return Left(errorMessage);
    } catch (e) {
      return Left(e.toString());
    }
  }
}
