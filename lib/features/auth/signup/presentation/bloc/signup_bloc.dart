import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pingvite/core/error/failure.dart';
import 'package:pingvite/features/auth/signup/data/models/signup_request_params.dart';
import 'package:pingvite/features/auth/signup/data/models/signup_response_params.dart';
import 'package:pingvite/features/auth/signup/domain/usecases/user_signup.dart';
import 'package:pingvite/service_locator_dependencies.dart';

part 'signup_event.dart';
part 'signup_state.dart';

class SignupBloc extends Bloc<SignupEvent, SignupState> {
  SignupBloc({required UserSignup userSignup}) : super(SignupInitial()) {
    on<SignupSubmitted>(_onSignupSubmitted);
    on<SignupReset>(_onSignupReset);
  }

  Future<void> _onSignupSubmitted(
    SignupSubmitted event,
    Emitter<SignupState> emit,
  ) async {
    emit(SignupLoading());

    final result = await sl<UserSignup>().call(
      params: SignupRequestParams(
        firstName: event.firstName,
        middleName: event.middleName,
        lastName: event.lastName,
        email: event.email,
        mobile: event.mobile,
        password: event.password,
      ),
    );

    result.fold(
      (failure) => emit(SignupFailure(failure)),
      (signupResult) => emit(
        SignupSuccess(message: signupResult.message, user: signupResult.user),
      ),
    );
  }

  void _onSignupReset(SignupReset event, Emitter<SignupState> emit) {
    emit(SignupInitial());
  }
}
