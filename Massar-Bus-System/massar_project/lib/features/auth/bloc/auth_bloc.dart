import 'package:flutter_bloc/flutter_bloc.dart';
import 'auth_event.dart';
import 'auth_state.dart';
import 'package:massar_project/repositories/auth_repository.dart';
import 'dart:io';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthRepository _authRepository;

  AuthBloc({required AuthRepository authRepository})
      : _authRepository = authRepository,
        super(const AuthAuthenticated(
          name: 'أحمد محمد',
          email: 'ahmed.mohamed@email.com',
          avatarUrl: 'assets/images/adnan.jpg',
        )) {
    on<LogoutRequested>((event, emit) async {
      await _authRepository.logout();
      emit(const AuthUnauthenticated());
    });

    on<GuestLoginRequested>((event, emit) async {
      emit(const AuthGuest());
    });

    on<LoginSubmitted>((event, emit) async {
      emit(const AuthLoading());
      final result = await _authRepository.login(event.email, event.password);
      if (result['success']) {
        final user = result['user'];
        emit(AuthAuthenticated(
          name: '${user['first_name']} ${user['last_name']}',
          email: user['email'],
          avatarUrl: user['avatar_url'] ?? 'assets/images/adnan.jpg',
        ));
      } else {
        emit(AuthError(result['message']));
      }
    });

    on<UpdateAvatarRequested>((event, emit) async {
      emit(const AuthLoading());
      try {
        final userModel = await _authRepository.uploadProfileImage(File(event.imagePath));
        emit(AuthAuthenticated(
          name: '${userModel.firstName} ${userModel.lastName}',
          email: userModel.email,
          avatarUrl: userModel.profileImage,
        ));
        emit(const ProfileUpdateSuccess());
      } catch (e) {
        emit(AuthError(e.toString()));
      }
    });

    on<GoogleSignInRequested>((event, emit) async {
      emit(const AuthLoading());
      try {
        final result = await _authRepository.signInWithGoogle();
        if (result['success'] && result['user'] != null) {
          final user = result['user'];
          final bool isComplete = result['isProfileComplete'] ?? false;

          if (!isComplete) {
            // New user or missing info -> show profile completion flow
            emit(AuthProfileIncomplete(user));
          } else {
            // Full user -> home
            // Safe extraction with fallbacks
            final String firstName = user['first_name'] ?? 'User';
            final String lastName = user['last_name'] ?? '';
            final String fullName = lastName.isEmpty ? firstName : '$firstName $lastName';

            emit(AuthAuthenticated(
              name: fullName,
              email: user['email'] ?? '',
              avatarUrl: user['avatar_url'] ?? 'assets/images/adnan.jpg',
            ));
          }

        } else {
          emit(AuthError(result['message'] ?? 'فشل تسجيل الدخول عبر جوجل'));
        }
      } catch (e) {
        emit(AuthError('خطأ غير متوقع: ${e.toString()}'));
      }
    });

    on<ProfileUpdated>((event, emit) async {
      emit(const AuthLoading());
      try {
        final result = await _authRepository.completeProfile(
          gender: event.gender,
          phone: event.phone,
          locationPermission: event.locationPermission,
        );

        if (result['success']) {
          final dashboard = await _authRepository.getDashboardData();
          if (dashboard['success']) {
            final user = dashboard['user'];
            final String firstName = user?['first_name'] ?? 'User';
            final String lastName = user?['last_name'] ?? '';
            final String fullName = lastName.isEmpty ? firstName : '$firstName $lastName';

            emit(AuthAuthenticated(
              name: fullName,
              email: user?['email'] ?? '',
              avatarUrl: user?['avatar_url'] ?? 'assets/images/adnan.jpg',
            ));
          }
        } else {
          emit(AuthError(result['message'] ?? 'فشل تحديث البيانات'));
        }
      } catch (e) {
        emit(AuthError('خطأ غير متوقع: ${e.toString()}'));
      }
    });




  }
}


