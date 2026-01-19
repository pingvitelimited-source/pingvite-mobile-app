import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:pingvite/core/network/api_urls.dart';
import 'package:pingvite/core/utils/session_manager.dart';

class AuthInterceptor extends Interceptor {
  final Dio dio;
  final FlutterSecureStorage secureStorage;

  AuthInterceptor({required this.dio, required this.secureStorage});

  @override
  void onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    // Skip token for login/signup/refresh endpoints
    if (options.path.contains('/login') ||
        options.path.contains('/user') ||
        options.path.contains('/refresh-token')) {
      return handler.next(options);
    }

    // Add token to headers
    final token = await secureStorage.read(key: 'access_token');
    if (token != null) {
      options.headers['Authorization'] = token;
    }

    return handler.next(options);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) async {
    // Handle 401 Unauthorized - token expired
    if (err.response?.statusCode == 401) {
      // Try to refresh token
      final refreshed = await _refreshToken();

      if (refreshed) {
        // Retry the original request with new token
        try {
          final token = await secureStorage.read(key: 'access_token');
          final opts = Options(
            method: err.requestOptions.method,
            headers: {
              ...err.requestOptions.headers,
              'Authorization': token ?? '',
            },
          );

          final response = await dio.request(
            err.requestOptions.path,
            options: opts,
            data: err.requestOptions.data,
            queryParameters: err.requestOptions.queryParameters,
          );

          return handler.resolve(response);
        } catch (e) {
          return handler.next(err);
        }
      } else {
        // Refresh token also expired or invalid - logout user
        await SessionManager.clearSession();
        return handler.next(err);
      }
    }

    // Handle 422 Unprocessable Entity - validation error
    if (err.response?.statusCode == 422) {
      // Log validation errors for debugging
      final responseData = err.response?.data;
      if (responseData is Map) {
        // Extract validation error messages if available
        final errors =
            responseData['errors'] ??
            responseData['message'] ??
            'Validation failed';
        // Create a more descriptive error
        final newError = DioException(
          requestOptions: err.requestOptions,
          response: err.response,
          type: DioExceptionType.badResponse,
          error: 'Validation Error: $errors',
        );
        return handler.next(newError);
      }
    }

    return handler.next(err);
  }

  Future<bool> _refreshToken() async {
    try {
      final refreshToken = await secureStorage.read(key: 'refresh_token');

      if (refreshToken == null) {
        return false;
      }

      final response = await dio.post(
        ApiUrls.refreshToken,
        data: {'refresh_token': refreshToken},
      );

      if (response.statusCode == 200) {
        final newToken = response.data['token'];
        final newRefreshToken = response.data['refresh_token'];

        if (newToken != null && newRefreshToken != null) {
          await secureStorage.write(key: 'access_token', value: newToken);
          await secureStorage.write(
            key: 'refresh_token',
            value: newRefreshToken,
          );
          return true;
        }
      }

      return false;
    } catch (e) {
      return false;
    }
  }
}
