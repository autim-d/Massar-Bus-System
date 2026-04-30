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
    
    // معالجة مشكلة الـ localhost في محاكي الأندرويد والهاتف الحقيقي
    // إذا كانت الصورة محفوظة في السيرفر المحلي (127.0.0.1)، فالموبايل يحتاج للـ IP المحلي (10.0.0.109) للوصول إليها
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
      firstName: json['first_name'] ?? '',
      lastName: json['last_name'] ?? '',
      phoneNumber: json['phone_number'] ?? '',
      profileImage: avatarUrl,
      email: json['email'] ?? '',
      nationality: json['nationality'],
      // Laravel يرسل identity_number، نقبل أيضاً national_id كقيمة احتياطية
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
