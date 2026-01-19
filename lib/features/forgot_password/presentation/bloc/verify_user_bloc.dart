import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pingvite/core/error/failure.dart';
import 'package:pingvite/features/forgot_password/domain/usecases/verify_user_usecase.dart';
import 'package:pingvite/service_locator_dependencies.dart';

part 'verify_user_event.dart';
part 'verify_user_state.dart';

class VerifyUserBloc extends Bloc<VerifyUserEvent, VerifyUserState> {
  VerifyUserBloc() : super(VerifyUserInitial()) {
    on<VerifyUserSubmitted>(_onVerifyUserSubmitted);
    on<VerifyUserReset>(_onVerifyUserReset);
  }

  Future<void> _onVerifyUserSubmitted(
    VerifyUserSubmitted event,
    Emitter<VerifyUserState> emit,
  ) async {
    emit(VerifyUserLoading());

    final result = await sl<VerifyUserUseCase>().call(
      params: VerifyUserParams(type: event.type, value: event.value),
    );

    result.fold(
      (failure) => emit(VerifyUserFailure(failure)),
      (verifyUser) => emit(
        VerifyUserSuccess(
          message: verifyUser.message,
          userExist: verifyUser.userExist,
        ),
      ),
    );
  }

  void _onVerifyUserReset(
    VerifyUserReset event,
    Emitter<VerifyUserState> emit,
  ) {
    emit(VerifyUserInitial());
  }
}
