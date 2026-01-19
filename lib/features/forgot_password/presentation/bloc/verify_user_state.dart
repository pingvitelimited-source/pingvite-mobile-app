part of 'verify_user_bloc.dart';

sealed class VerifyUserState {}

final class VerifyUserInitial extends VerifyUserState {}

final class VerifyUserLoading extends VerifyUserState {}

final class VerifyUserSuccess extends VerifyUserState {
  final String message;
  final bool userExist;

  VerifyUserSuccess({required this.message, required this.userExist});
}

final class VerifyUserFailure extends VerifyUserState {
  final String message;

  VerifyUserFailure(dynamic failure)
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
