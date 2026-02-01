import 'dart:convert';

class JwtTokenDecoder {
  /// Decodes JWT token and returns the payload as a map
  static Map<String, dynamic> decodeToken(String token) {
    try {
      // Remove 'Bearer ' prefix if present
      final cleanToken = token.replaceFirst('Bearer ', '');

      // Split token into parts
      final parts = cleanToken.split('.');

      if (parts.length != 3) {
        throw Exception('Invalid token format');
      }

      // Decode the payload (second part)
      final payload = parts[1];

      // Add padding if necessary
      String normalized = payload;
      final remainder = normalized.length % 4;
      if (remainder > 0) {
        normalized += '=' * (4 - remainder);
      }

      // Decode from base64
      final decoded = utf8.decode(base64Url.decode(normalized));

      // Parse JSON
      return jsonDecode(decoded) as Map<String, dynamic>;
    } catch (e) {
      throw Exception('Failed to decode token: $e');
    }
  }

  /// Get user ID from token
  static int? getUserId(String token) {
    try {
      final payload = decodeToken(token);
      return payload['id'] as int?;
    } catch (e) {
      return null;
    }
  }

  /// Get first name from token
  static String? getFirstName(String token) {
    try {
      final payload = decodeToken(token);
      return payload['first_name'] as String?;
    } catch (e) {
      return null;
    }
  }

  /// Get last name from token
  static String? getLastName(String token) {
    try {
      final payload = decodeToken(token);
      return payload['last_name'] as String?;
    } catch (e) {
      return null;
    }
  }

  /// Get email from token
  static String? getEmail(String token) {
    try {
      final payload = decodeToken(token);
      return payload['email'] as String?;
    } catch (e) {
      return null;
    }
  }

  /// Get full decoded payload
  static Map<String, dynamic>? getPayload(String token) {
    try {
      return decodeToken(token);
    } catch (e) {
      return null;
    }
  }
}
