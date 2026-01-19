class ApiUrls {
  static const String baseUrl =
      'https://kjfphsq4hw.ap-south-1.awsapprunner.com';

  // Auth
  static const String signup = '$baseUrl/user';
  static const String login = '$baseUrl/login';
  static const String refreshToken = '$baseUrl/refresh-token';
  static const String verifyUser = '$baseUrl/verify-user';
  static const String forgotPassword = '$baseUrl/forgot-password';

  // Contacts
  static const String contact = '$baseUrl/contact';
}
