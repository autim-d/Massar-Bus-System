import 'package:equatable/equatable.dart';

abstract class AuthEvent extends Equatable {
  const AuthEvent();

  @override
  List<Object> get props => [];
}

class LogoutRequested extends AuthEvent {
  const LogoutRequested();
}

class GuestLoginRequested extends AuthEvent {
  const GuestLoginRequested();
}

class LoginSubmitted extends AuthEvent {
  final String email;
  final String password;

  const LoginSubmitted({
    required this.email,
    required this.password,
  });

  @override
  List<Object> get props => [email, password];
}

class UpdateAvatarRequested extends AuthEvent {
  final String imagePath;

  const UpdateAvatarRequested({required this.imagePath});

  @override
  List<Object> get props => [imagePath];
}

class GoogleSignInRequested extends AuthEvent {
  const GoogleSignInRequested();
}

class ProfileUpdated extends AuthEvent {
  final String gender;
  final String phone;
  final bool locationPermission;

  const ProfileUpdated({
    required this.gender,
    required this.phone,
    required this.locationPermission,
  });

  @override
  List<Object> get props => [gender, phone, locationPermission];
}



