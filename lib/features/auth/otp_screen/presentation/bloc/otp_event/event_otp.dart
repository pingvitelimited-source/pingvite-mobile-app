part of otp_bloc;

@immutable
sealed class EventOtp {}

final class SendOtpRequested extends EventOtp {
  final String email;

  SendOtpRequested({required this.email});
}

final class VerifyOtpRequested extends EventOtp {
  final String otpType;
  final String otp;
  final String email;

  VerifyOtpRequested({
    required this.otpType,
    required this.otp,
    required this.email,
  });
}

final class OtpReset extends EventOtp {}
