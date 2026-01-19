import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dio/dio.dart';

class ConnectivityInterceptor extends Interceptor {
  final Connectivity _connectivity;

  ConnectivityInterceptor(this._connectivity);

  @override
  Future<void> onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    final connectivityResult = await _connectivity.checkConnectivity();

    if (connectivityResult.first == ConnectivityResult.none) {
      handler.reject(
        DioException(
          requestOptions: options,
          error: 'No internet connection!',
          type: DioExceptionType.connectionError,
        ),
      );
    } else {
      super.onRequest(options, handler);
    }
  }
}
