import 'package:equatable/equatable.dart';

/// Wrapper class to hold both message and user data from signup response
class SignupResult extends Equatable {
  final String message;
  final SignupResponseParams user;

  const SignupResult({
    required this.message,
    required this.user,
  });

  @override
  List<Object?> get props => [message, user];
}

class SignupResponseParams extends Equatable {
  final int id;
  final String firstName;
  final String? middleName;
  final String lastName;
  final String email;
  final String mobile;
  final String? profileImage;
  final bool isActive;
  final String userRole;
  final DateTime createdAt;
  final DateTime updatedAt;

  const SignupResponseParams({
    required this.id,
    required this.firstName,
    this.middleName,
    required this.lastName,
    required this.email,
    required this.mobile,
    this.profileImage,
    required this.isActive,
    required this.userRole,
    required this.createdAt,
    required this.updatedAt,
  });

  factory SignupResponseParams.fromJson(Map<String, dynamic> json) {
    return SignupResponseParams(
      id: json['id'] as int,
      firstName: json['first_name'] as String,
      middleName: json['middle_name'] as String?,
      lastName: json['last_name'] as String,
      email: json['email'] as String,
      mobile: json['mobile'] as String,
      profileImage: json['profile_image'] as String?,
      isActive: json['is_active'] as bool,
      userRole: json['user_role'] as String,
      createdAt: DateTime.parse(json['created_at'] as String),
      updatedAt: DateTime.parse(json['updated_at'] as String),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'first_name': firstName,
      'middle_name': middleName,
      'last_name': lastName,
      'email': email,
      'mobile': mobile,
      'profile_image': profileImage,
      'is_active': isActive,
      'user_role': userRole,
      'created_at': createdAt.toIso8601String(),
      'updated_at': updatedAt.toIso8601String(),
    };
  }

  @override
  List<Object?> get props => [
        id,
        firstName,
        middleName,
        lastName,
        email,
        mobile,
        profileImage,
        isActive,
        userRole,
        createdAt,
        updatedAt,
      ];
}
