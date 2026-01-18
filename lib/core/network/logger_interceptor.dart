import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:logger/logger.dart';

class LoggerInterceptor extends Interceptor {
  final Logger logger = Logger(
    printer: PrettyPrinter(methodCount: 0, colors: true, printEmojis: true),
  );

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    if (!kReleaseMode) {
      final options = err.requestOptions;
      final requestPath = '${options.baseUrl}${options.path}';
      logger.e('${options.method} request ==> $requestPath');

      // Enhanced logging for 422 validation errors
      if (err.response?.statusCode == 422) {
        logger.e('Validation Error (422): Request validation failed');
        logger.d('Request data: ${options.data}');
        logger.d('Response data: ${err.response?.data}');

        // Try to extract specific validation errors
        if (err.response?.data is Map) {
          final data = err.response?.data as Map;
          if (data.containsKey('errors')) {
            logger.e('Validation errors: ${data['errors']}');
          }
          if (data.containsKey('message')) {
            logger.e('Error message: ${data['message']}');
          }
        }
      } else {
        logger.d(
          'Error type: ${err.error} \n '
          'Error message: ${err.message}',
        );
      }
    }
    handler.next(err);
  }

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    if (!kReleaseMode) {
      final requestPath = '${options.baseUrl}${options.path}';
      logger.i('${options.method} request ==> $requestPath');
      logger.d('Request data: ${options.data}');
    }
    handler.next(options);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    if (!kReleaseMode) {
      logger.d(
        'STATUSCODE: ${response.statusCode} \n'
        'STATUSMESSAGE: ${response.statusMessage} \n'
        'Data: ${response.data}',
      );
    }
    handler.next(response);
  }
}
