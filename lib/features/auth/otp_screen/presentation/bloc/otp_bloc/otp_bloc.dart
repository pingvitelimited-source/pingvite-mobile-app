library otp_bloc;

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:pingvite/features/auth/otp_screen/domain/entites/send_otp_response_entity.dart';
import 'package:pingvite/features/auth/otp_screen/domain/entites/verify_otp_response_entity.dart';
import 'package:pingvite/features/auth/otp_screen/domain/usecase/send_otp_usecase.dart';
import 'package:pingvite/features/auth/otp_screen/domain/usecase/verify_otp_usecase.dart';

part '../otp_event/event_otp.dart';
part '../otp_state/state_otp.dart';

class SendOtpBloc extends Bloc<EventOtp, OtpState> {
  final SendOtpUsecase _sendOtpUsecase;
  final VerifyOtpUsecase _verifyOtpUsecase;

  SendOtpBloc({
    required SendOtpUsecase sendOtpUsecase,
    required VerifyOtpUsecase verifyOtpUsecase,
  })  : _sendOtpUsecase = sendOtpUsecase,
        _verifyOtpUsecase = verifyOtpUsecase,
        super(SendOtpInitial()) {
    on<SendOtpRequested>(_onSendOtpRequested);
    on<VerifyOtpRequested>(_onVerifyOtpRequested);
    on<OtpReset>(_onOtpReset);
  }

  Future<void> _onSendOtpRequested(
    SendOtpRequested event,
    Emitter<OtpState> emit,
  ) async {
    emit(SendOtpLoading());

    final res = await _sendOtpUsecase.call(params: event.email);

    res.fold(
      (l) => emit(SendOtpFailure(l.toString())),
      (r) => emit(SendOtpSuccess(r)),
    );
  }

  Future<void> _onVerifyOtpRequested(
    VerifyOtpRequested event,
    Emitter<OtpState> emit,
  ) async {
    emit(VerifyOtpLoading());

    final res = await _verifyOtpUsecase.call(
      params: VerifyOtpParams(
        otpType: event.otpType,
        otp: event.otp,
        email: event.email,
      ),
    );

    res.fold(
      (l) => emit(VerifyOtpFailure(l.toString())),
      (r) => emit(VerifyOtpSuccess(r)),
    );
  }

  void _onOtpReset(OtpReset event, Emitter<OtpState> emit) {
    emit(SendOtpInitial());
  }
}
