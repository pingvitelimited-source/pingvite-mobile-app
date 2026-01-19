class ForgotPasswordResponseParams {
  final int status;
  final String message;

  ForgotPasswordResponseParams({required this.status, required this.message});

  factory ForgotPasswordResponseParams.fromJson(Map<String, dynamic> json) {
    return ForgotPasswordResponseParams(
      status: json['status'] as int? ?? 0,
      message: json['message']?.toString() ?? '',
    );
  }
}
