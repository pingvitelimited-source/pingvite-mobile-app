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
  static String getContactList(int userId) => '$baseUrl/contact-list/$userId';

  // Location
  static const String countries = '$baseUrl/countries';
  static String getStateList(String countryCode) =>
      '$baseUrl/state-list/$countryCode';
  static String getCityList(String stateId) => '$baseUrl/cities/$stateId';

  // OTP
  static String sendRegisterOtp(String email) =>
      '$baseUrl/send-otp/register/$email';
  static const String verifyOtp = '$baseUrl/verify-otp';
}
