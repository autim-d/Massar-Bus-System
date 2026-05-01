import 'package:equatable/equatable.dart';
import 'package:massar_project/features/account/models/user_model.dart';

abstract class AuthState extends Equatable {
  const AuthState();

  @override
  List<Object?> get props => [];
}

class AuthInitial extends AuthState {
  const AuthInitial();
}

class AuthLoading extends AuthState {
  const AuthLoading();
}

// حالة النجاح في تسجيل الدخول (معدلة لاستقبال الـ Model مع الحفاظ على الحقول القديمة)
// حالة النجاح في تسجيل الدخول (تعديل ذكي يمنع الخطأ ويحافظ على الحقول القديمة)
class AuthAuthenticated extends AuthState {
  final String name;
  final String email;
  final String avatarUrl;
  final UserModel? user;
  final Map<String, dynamic>? activeTicket;
  final List<dynamic>? suggestedStations;

  const AuthAuthenticated({
    this.name = '',
    this.email = '',
    this.avatarUrl = '',
    this.user,
    this.activeTicket,
    this.suggestedStations,
  });

  factory AuthAuthenticated.fromModel(
    UserModel user, {
    Map<String, dynamic>? activeTicket,
    List<dynamic>? suggestedStations,
  }) {
    String fullName = '${user.firstName} ${user.lastName}'.trim();
    if (fullName.isEmpty) {
      fullName = user.email.split('@').first;
    }
    
    return AuthAuthenticated(
      name: fullName,
      email: user.email,
      avatarUrl: user.profileImage,
      user: user,
      activeTicket: activeTicket,
      suggestedStations: suggestedStations,
    );
  }

  @override
  List<Object?> get props =>
      [name, email, avatarUrl, user, activeTicket, suggestedStations];
}

// --- الحالة التي كانت ناقصة وتسببت في الخطأ ---
class ProfileUpdateSuccess extends AuthState {
  final UserModel user;

  const ProfileUpdateSuccess({required this.user});

  @override
  List<Object?> get props => [user];
}

class AuthGuest extends AuthState {
  const AuthGuest();
}

class OtpSentSuccess extends AuthState {
  final String phone;
  const OtpSentSuccess({required this.phone});

  @override
  List<Object?> get props => [phone];
}

class AuthError extends AuthState {
  final String message;
  const AuthError({required this.message});

  @override
  List<Object?> get props => [message];
}

class PasswordChangeSuccess extends AuthState {
  const PasswordChangeSuccess();
}
