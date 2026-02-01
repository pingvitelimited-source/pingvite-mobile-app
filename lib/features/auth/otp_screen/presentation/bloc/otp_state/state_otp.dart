part of '../otp_bloc/otp_bloc.dart';

@immutable
sealed class OtpState {}

final class SendOtpInitial extends OtpState {}

final class SendOtpLoading extends OtpState {}

final class SendOtpSuccess extends OtpState {
  final SendOtpResponseEntity data;
  SendOtpSuccess(this.data);
}

final class SendOtpFailure extends OtpState {
  final String message;
  SendOtpFailure(this.message);
}

final class VerifyOtpLoading extends OtpState {}

final class VerifyOtpSuccess extends OtpState {
  final VerifyOtpResponseEntity data;
  VerifyOtpSuccess(this.data);
}

final class VerifyOtpFailure extends OtpState {
  final String message;
  VerifyOtpFailure(this.message);
}
