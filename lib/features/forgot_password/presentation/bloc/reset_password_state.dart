part of 'reset_password_bloc.dart';

sealed class ResetPasswordState {}

final class ResetPasswordInitial extends ResetPasswordState {}

final class ResetPasswordLoading extends ResetPasswordState {}

final class ResetPasswordSuccess extends ResetPasswordState {
  final String message;

  ResetPasswordSuccess({required this.message});
}

final class ResetPasswordFailure extends ResetPasswordState {
  final String message;

  ResetPasswordFailure(dynamic failure)
    : message = switch (failure) {
        DioException dio =>
          dio.type == DioExceptionType.connectionError ||
                  dio.type == DioExceptionType.connectionTimeout
              ? "No internet connection!"
              : (dio.response?.data?['message'] as String?) ??
                    dio.message ??
                    "Something went wrong!",
        Failure f => f.message,
        String s => s,
        _ => "An unknown error occurred.",
      };
}
