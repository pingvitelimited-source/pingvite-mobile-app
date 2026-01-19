import 'package:dartz/dartz.dart';
import 'package:pingvite/core/services/secure_storage_service.dart';
import 'package:pingvite/features/auth/signin/data/models/login_request_params.dart';
import 'package:pingvite/features/auth/signin/data/source/login_api_service.dart';
import 'package:pingvite/features/auth/signin/domain/entities/login_user.dart';
import 'package:pingvite/features/auth/signin/domain/repository/login_repository.dart';

class LoginRepositoryImpl implements LoginRepository {
  final LoginApiService _loginApiService;
  final SecureStorageService _secureStorageService;

  LoginRepositoryImpl(this._loginApiService, this._secureStorageService);

  @override
  Future<Either<dynamic, LoginUser>> loginWithEmail({
    required String email,
    required String password,
  }) async {
    final params = LoginRequestParams(email: email, password: password);
    final result = await _loginApiService.loginWithEmail(params);

    return result.fold((error) => Left(error), (response) async {
      // Save tokens to secure storage
      await _secureStorageService.saveTokens(
        accessToken: response.token,
        refreshToken: response.refreshToken,
      );
      return Right(response.toEntity());
    });
  }

  @override
  Future<Either<dynamic, LoginUser>> loginWithPhone({
    required String mobile,
    required String password,
  }) async {
    final params = LoginRequestParams(mobile: mobile, password: password);
    final result = await _loginApiService.loginWithPhone(params);

    return result.fold((error) => Left(error), (response) async {
      // Save tokens to secure storage
      await _secureStorageService.saveTokens(
        accessToken: response.token,
        refreshToken: response.refreshToken,
      );
      return Right(response.toEntity());
    });
  }
}
