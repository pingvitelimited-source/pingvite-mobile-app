class VerifyOtpRequestParams {
  final String otpType;
  final String otp;
  final String email;

  VerifyOtpRequestParams({
    required this.otpType,
    required this.otp,
    required this.email,
  });

  Map<String, dynamic> toMap() {
    return {
      'otp_type': otpType,
      'otp': otp,
      'email': email,
    };
  }
}
