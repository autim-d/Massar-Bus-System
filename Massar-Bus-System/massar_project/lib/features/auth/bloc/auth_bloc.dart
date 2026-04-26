import 'package:flutter_bloc/flutter_bloc.dart';
import 'auth_event.dart';
import 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc() : super(const AuthAuthenticated(
    name: 'أحمد محمد',
    email: 'ahmed.mohamed@email.com',
    avatarUrl: 'assets/images/adnan.jpg', // Using existing asset as fallback
  )) {
    on<LogoutRequested>((event, emit) async {
      // Simulate logout process
      await Future.delayed(const Duration(milliseconds: 500));
      emit(const AuthUnauthenticated());
    });

    on<GuestLoginRequested>((event, emit) async {
      emit(const AuthGuest());
    });

    on<LoginSubmitted>((event, emit) async {
      // Simulate login process
      await Future.delayed(const Duration(milliseconds: 800));
      emit(const AuthAuthenticated(
        name: 'أحمد محمد',
        email: 'ahmed.mohamed@email.com',
        avatarUrl: 'assets/images/adnan.jpg',
      ));
    });
  }
}
