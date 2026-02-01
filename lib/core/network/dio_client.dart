import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:pingvite/core/network/auth_interceptor.dart';
import 'package:pingvite/core/network/connectivity_interceptor.dart';
import 'package:pingvite/core/network/logger_interceptor.dart';

class DioClient {
  late final Dio _dio;

  DioClient({FlutterSecureStorage? secureStorage})
    : _dio =
          Dio(
              BaseOptions(
                headers: {'Content-Type': 'application/json; charset=UTF-8'},
                responseType: ResponseType.json,
                sendTimeout: const Duration(minutes: 1),
                receiveTimeout: const Duration(minutes: 1),
              ),
            )
            ..interceptors.addAll([
              ConnectivityInterceptor(Connectivity()),
              LoggerInterceptor(),
              AuthInterceptor(
                dio: Dio(),
                secureStorage: secureStorage ?? const FlutterSecureStorage(),
              ),
            ]);

  // GET METHOD
  Future<Response> get(
    String url, {
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
    ProgressCallback? onReceiveProgress,
  }) async {
    try {
      final Response response = await _dio.get(
        url,
        queryParameters: queryParameters,
        options: options,
        cancelToken: cancelToken,
        onReceiveProgress: onReceiveProgress,
      );
      return response;
    } on DioException catch (e) {
      if (e.response?.statusCode == 500) {
        throw 'Internal server error';
      } else {
        throw 'Something went wrong! Please try again later.';
      }
    }
  }

  // POST METHOD
  Future<Response> post(
    String url, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    ProgressCallback? onSendProgress,
    ProgressCallback? onReceiveProgress,
  }) async {
    try {
      final Response response = await _dio.post(
        url,
        data: data,
        queryParameters: queryParameters,
        options: options,
        onSendProgress: onSendProgress,
        onReceiveProgress: onReceiveProgress,
      );
      return response;
    } on DioException catch (e) {
      if (e.response?.statusCode == 500) {
        throw 'Internal server error';
      } else {
        throw 'Something went wrong! Please try again later.';
      }
    }
  }

  // PUT METHOD
  Future<Response> put(
    String url, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
    ProgressCallback? onSendProgress,
    ProgressCallback? onReceiveProgress,
  }) async {
    try {
      final Response response = await _dio.put(
        url,
        data: data,
        queryParameters: queryParameters,
        options: options,
        cancelToken: cancelToken,
        onSendProgress: onSendProgress,
        onReceiveProgress: onReceiveProgress,
      );
      return response;
    } on DioException catch (e) {
      if (e.response?.statusCode == 500) {
        throw 'Internal server error';
      } else {
        throw 'Something went wrong! Please try again later.';
      }
    }
  }

  // DELETE METHOD
  Future<Response> delete(
    String url, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
  }) async {
    try {
      final Response response = await _dio.delete(
        url,
        data: data,
        queryParameters: queryParameters,
        options: options,
        cancelToken: cancelToken,
      );
      return response;
    } on DioException catch (e) {
      if (e.response?.statusCode == 500) {
        throw 'Internal server error';
      } else {
        throw 'Something went wrong! Please try again later.';
      }
    }
  }
}
