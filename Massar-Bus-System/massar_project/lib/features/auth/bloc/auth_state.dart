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

class AuthAuthenticated extends AuthState {
  final String name;
  final String email;
  final String avatarUrl;
  final UserModel? user;
  final List<dynamic>? suggestedStations;

  const AuthAuthenticated({
    required this.name,
    required this.email,
    required this.avatarUrl,
    this.user,
    this.suggestedStations,
  });

  @override
  List<Object?> get props => [name, email, avatarUrl, user, suggestedStations];
}

class AuthUnauthenticated extends AuthState {
  const AuthUnauthenticated();
}

class AuthGuest extends AuthState {
  const AuthGuest();
}

class AuthLoading extends AuthState {
  const AuthLoading();
}

class AuthError extends AuthState {
  final String message;
  const AuthError(this.message);

  @override
  List<Object?> get props => [message];
}

class ProfileUpdateSuccess extends AuthState {
  final UserModel user;
  const ProfileUpdateSuccess(this.user);

  @override
  List<Object?> get props => [user];
}

class OtpSentSuccess extends AuthState {
  final String phone;
  const OtpSentSuccess(this.phone);

  @override
  List<Object?> get props => [phone];
}

class PasswordChangeSuccess extends AuthState {
  const PasswordChangeSuccess();
}

