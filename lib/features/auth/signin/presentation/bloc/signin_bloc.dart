import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pingvite/features/auth/signin/domain/usecases/user_login_with_email.dart';
import 'package:pingvite/features/auth/signin/domain/usecases/user_login_with_phone.dart';
import 'package:pingvite/features/auth/signin/presentation/bloc/signin_event.dart';
import 'package:pingvite/features/auth/signin/presentation/bloc/signin_state.dart';

class SigninBloc extends Bloc<SigninEvent, SigninState> {
  final UserLoginWithEmail _userLoginWithEmail;
  final UserLoginWithPhone _userLoginWithPhone;

  SigninBloc(this._userLoginWithEmail, this._userLoginWithPhone)
      : super(SigninInitial()) {
    on<SigninWithEmailEvent>(_onSigninWithEmail);
    on<SigninWithPhoneEvent>(_onSigninWithPhone);
  }

  Future<void> _onSigninWithEmail(
    SigninWithEmailEvent event,
    Emitter<SigninState> emit,
  ) async {
    emit(SigninLoading());

    final result = await _userLoginWithEmail(
      params: LoginWithEmailParams(
        email: event.email,
        password: event.password,
      ),
    );

    result.fold(
      (error) => emit(SigninFailure(error.toString())),
      (user) => emit(SigninSuccess(user: user, message: user.message)),
    );
  }

  Future<void> _onSigninWithPhone(
    SigninWithPhoneEvent event,
    Emitter<SigninState> emit,
  ) async {
    emit(SigninLoading());

    final result = await _userLoginWithPhone(
      params: LoginWithPhoneParams(
        mobile: event.mobile,
        password: event.password,
      ),
    );

    result.fold(
      (error) => emit(SigninFailure(error.toString())),
      (user) => emit(SigninSuccess(user: user, message: user.message)),
    );
  }
}
