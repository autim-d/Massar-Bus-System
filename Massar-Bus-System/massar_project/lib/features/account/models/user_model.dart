class UserModel {
  final String firstName;
  final String lastName;
  final String phoneNumber;
  final String profileImage;
  final String email;
  final String nationality;
  final String nationalId;
  final int unreadNotificationsCount;

  UserModel({
    required this.firstName,
    required this.lastName,
    required this.phoneNumber,
    required this.profileImage,
    required this.email,
    this.nationality = '',
    this.nationalId = '',
    this.unreadNotificationsCount = 0,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      firstName: json['first_name'] ?? '',
      lastName: json['last_name'] ?? '',
      phoneNumber: json['phone_number'] ?? '',
      profileImage: json['profile_image'] ?? 'assets/images/adnan.jpg',
      email: json['email'] ?? '',
      nationality: json['nationality'] ?? '',
      nationalId: json['identity_number'] ?? '',
      unreadNotificationsCount: json['unread_notifications_count'] ?? 0,
    );
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

