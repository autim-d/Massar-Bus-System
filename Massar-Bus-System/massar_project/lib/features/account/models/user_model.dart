import 'dart:io' show Platform;

class UserModel {
  final String firstName;
  final String lastName;
  final String phoneNumber;
  final String profileImage;
  final String email;
  final String? nationality;
  final String? nationalId;
  final int unreadNotificationsCount; // عدد الإشعارات غير المقروءة

  UserModel({
    required this.firstName,
    required this.lastName,
    required this.phoneNumber,
    required this.profileImage,
    required this.email,
    this.nationality,
    this.nationalId,
    this.unreadNotificationsCount = 0,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    String avatarUrl = json['avatar_url'] ?? json['profile_image'] ?? '';
    
    // Handle full name from API and split it if first_name/last_name are missing
    String firstName = json['first_name'] ?? '';
    String lastName = json['last_name'] ?? '';
    
    if (firstName.isEmpty && json['name'] != null) {
      final nameParts = (json['name'] as String).split(' ');
      firstName = nameParts.first;
      if (nameParts.length > 1) {
        lastName = nameParts.sublist(1).join(' ');
      }
    }

    // fallback to email prefix if name is still empty
    if (firstName.isEmpty && json['email'] != null) {
      firstName = (json['email'] as String).split('@').first;
    }
    
    // معالجة مشكلة الـ localhost في محاكي الأندرويد والهاتف الحقيقي
    try {
      if (avatarUrl.isNotEmpty && Platform.isAndroid) {
        if (avatarUrl.contains('127.0.0.1')) {
          avatarUrl = avatarUrl.replaceAll('127.0.0.1', '10.0.0.109');
        } else if (avatarUrl.contains('localhost')) {
          avatarUrl = avatarUrl.replaceAll('localhost', '10.0.0.109');
        }
      }
    } catch (_) {}

    return UserModel(
      firstName: firstName,
      lastName: lastName,
      phoneNumber: json['phone_number'] ?? '',
      profileImage: avatarUrl,
      email: json['email'] ?? '',
      nationality: json['nationality'],
      nationalId: json['identity_number'] ?? json['national_id'],
      unreadNotificationsCount: json['unread_notifications_count'] ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'first_name': firstName,
      'last_name': lastName,
      'phone_number': phoneNumber,
      'avatar_url': profileImage,
      'email': email,
      'nationality': nationality,
      'identity_number': nationalId,
    };
  }

  UserModel copyWith({
    String? firstName,
    String? lastName,
    String? phoneNumber,
    String? profileImage,
    String? email,
    String? nationality,
    String? nationalId,
    int? unreadNotificationsCount,
  }) {
    return UserModel(
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      profileImage: profileImage ?? this.profileImage,
      email: email ?? this.email,
      nationality: nationality ?? this.nationality,
      nationalId: nationalId ?? this.nationalId,
      unreadNotificationsCount: unreadNotificationsCount ?? this.unreadNotificationsCount,
    );
  }
}
