import 'package:equatable/equatable.dart';
import 'package:massar_project/features/account/models/user_model.dart';

abstract class AuthEvent extends Equatable {
  const AuthEvent();

  @override
  List<Object?> get props => [];
}

// ─── حدث تحديث بيانات الحساب (تعديل البيانات النصية) ──────────────────────────
class UpdateProfileSubmitted extends AuthEvent {
  final UserModel user;

  const UpdateProfileSubmitted({required this.user});

  @override
  List<Object> get props => [user];
}

// ─── أحداث المصادقة الأساسية ──────────────────────────────────────────────────

class LogoutRequested extends AuthEvent {
  const LogoutRequested();
}

class GuestLoginRequested extends AuthEvent {
  const GuestLoginRequested();
}

class LoginSubmitted extends AuthEvent {
  final String email;
  final String password;

  const LoginSubmitted({required this.email, required this.password});

  @override
  List<Object> get props => [email, password];
}

class SendOtpRequested extends AuthEvent {
  final String phone;
  const SendOtpRequested({required this.phone});

  @override
  List<Object> get props => [phone];
}

class RegisterSubmitted extends AuthEvent {
  final String firstName;
  final String lastName;
  final String email;
  final String phone;
  final String gender;
  final String password;

  const RegisterSubmitted({
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.phone,
    required this.gender,
    required this.password,
  });

  @override
  List<Object> get props => [
    firstName,
    lastName,
    email,
    phone,
    gender,
    password,
  ];
}

// ─── أحداث مضافة للربط مع الباك أند (Laravel) ───────────────────────────────

/// حدث تغيير كلمة المرور من صفحة الإعدادات
class ChangePasswordRequested extends AuthEvent {
  final String currentPassword;
  final String newPassword;

  const ChangePasswordRequested({
    required this.currentPassword,
    required this.newPassword,
  });

  @override
  List<Object> get props => [currentPassword, newPassword];
}

/// حدث تحديث الصورة الشخصية (Avatar)
class UpdateAvatarRequested extends AuthEvent {
  final String imagePath;

  const UpdateAvatarRequested({required this.imagePath});

  @override
  List<Object> get props => [imagePath];
}

/// حدث جلب بيانات المستخدم المحدثة (الاسم والإشعارات) للصفحة الرئيسية
class GetUserDataEvent extends AuthEvent {
  const GetUserDataEvent();
}
