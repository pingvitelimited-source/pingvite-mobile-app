import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pingvite/core/error/failure.dart';
import 'package:pingvite/features/forgot_password/domain/usecases/reset_password_usecase.dart';
import 'package:pingvite/service_locator_dependencies.dart';

part 'reset_password_event.dart';
part 'reset_password_state.dart';

class ResetPasswordBloc extends Bloc<ResetPasswordEvent, ResetPasswordState> {
  ResetPasswordBloc() : super(ResetPasswordInitial()) {
    on<ResetPasswordSubmitted>(_onResetPasswordSubmitted);
    on<ResetPasswordReset>(_onResetPasswordReset);
  }

  Future<void> _onResetPasswordSubmitted(
    ResetPasswordSubmitted event,
    Emitter<ResetPasswordState> emit,
  ) async {
    emit(ResetPasswordLoading());

    final result = await sl<ResetPasswordUseCase>().call(
      params: ResetPasswordParams(
        type: event.type,
        value: event.value,
        password: event.password,
      ),
    );

    result.fold(
      (failure) => emit(ResetPasswordFailure(failure)),
      (message) => emit(ResetPasswordSuccess(message: message)),
    );
  }

  void _onResetPasswordReset(
    ResetPasswordReset event,
    Emitter<ResetPasswordState> emit,
  ) {
    emit(ResetPasswordInitial());
  }
}
