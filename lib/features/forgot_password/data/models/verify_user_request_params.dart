class VerifyUserRequestParams {
  final String type;
  final String value;

  VerifyUserRequestParams({required this.type, required this.value});

  Map<String, dynamic> toMap() {
    return {'type': type, 'value': value};
  }
}
