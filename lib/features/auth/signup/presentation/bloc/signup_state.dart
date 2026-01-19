part of 'signup_bloc.dart';

sealed class SignupState {}

final class SignupInitial extends SignupState {}

final class SignupLoading extends SignupState {}

final class SignupSuccess extends SignupState {
  final String message;
  final SignupResponseParams user;

  SignupSuccess({required this.message, required this.user});
}

final class SignupFailure extends SignupState {
  final String message;

  SignupFailure(dynamic failure)
    : message = switch (failure) {
        DioException dio =>
          dio.type == DioExceptionType.connectionError
              ? "No internet connection!"
              : (dio.response?.data?['message'] as String?) ??
                    dio.message ??
                    "Something went wrong!",
        Failure f => f.message,
        String s => s,
        _ => "An unknown error occurred.",
      };
}
