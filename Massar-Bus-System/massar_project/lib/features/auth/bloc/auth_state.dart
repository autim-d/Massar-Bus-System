import 'package:equatable/equatable.dart';

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

  const AuthAuthenticated({
    required this.name,
    required this.email,
    required this.avatarUrl,
  });

  @override
  List<Object?> get props => [name, email, avatarUrl];
}

class AuthUnauthenticated extends AuthState {
  const AuthUnauthenticated();
}

class AuthGuest extends AuthState {
  const AuthGuest();
}
