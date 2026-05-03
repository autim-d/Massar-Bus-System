import 'dart:io';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:massar_project/features/account/models/user_model.dart';
import 'auth_event.dart';
import 'auth_state.dart';
import 'package:massar_project/repositories/auth_repository.dart';
// import 'dart:io';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthRepository _authRepository;

  AuthBloc({required AuthRepository authRepository})
      : _authRepository = authRepository,
        super(const AuthAuthenticated(
          name: 'أحمد محمد',
          email: 'ahmed.mohamed@email.com',
          avatarUrl: 'assets/images/adnan.jpg',
          user: null,
          suggestedStations: null,
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
        final userData = result['user'];
        final userModel = UserModel.fromJson(userData);
        emit(AuthAuthenticated(
          name: '${userModel.firstName} ${userModel.lastName}',
          email: userModel.email,
          avatarUrl: userModel.profileImage,
          user: userModel,
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
          user: userModel,
        ));
        emit(ProfileUpdateSuccess(userModel));
      } catch (e) {
        emit(AuthError(e.toString()));
      }
    });

    on<GoogleSignInRequested>((event, emit) async {
      emit(const AuthLoading());
      try {
        final result = await _authRepository.signInWithGoogle();
        if (result['success'] && result['user'] != null) {
          final userData = result['user'];
          final userModel = UserModel.fromJson(userData);
          emit(AuthAuthenticated(
            name: '${userModel.firstName} ${userModel.lastName}',
            email: userModel.email,
            avatarUrl: userModel.profileImage,
            user: userModel,
          ));
        } else {
          emit(AuthError(result['message'] ?? 'فشل تسجيل الدخول عبر جوجل'));
        }
      } catch (e) {
        emit(AuthError('خطأ غير متوقع: ${e.toString()}'));
      }
    });


    on<SendOtpRequested>((event, emit) async {
      emit(const AuthLoading());
      try {
        final success = await _authRepository.sendOtp(event.phone);
        if (success) {
          emit(OtpSentSuccess(event.phone));
        } else {
          emit(const AuthError('فشل إرسال رمز التحقق'));
        }
      } catch (e) {
        emit(AuthError(e.toString()));
      }
    });

    on<GetUserDataEvent>((event, emit) async {
      try {
        final result = await _authRepository.getDashboardData();
        if (result['success'] && result['user'] != null) {
          final userData = result['user'];
          final userModel = UserModel.fromJson(userData);
          emit(AuthAuthenticated(
            name: '${userModel.firstName} ${userModel.lastName}',
            email: userModel.email,
            avatarUrl: userModel.profileImage,
            user: userModel,
          ));
        }
      } catch (e) {
        // Silent fail or emit error if needed
      }
    });

    on<ChangePasswordRequested>((event, emit) async {
      emit(const AuthLoading());
      try {
        final result = await _authRepository.changePassword(
          currentPassword: event.currentPassword,
          newPassword: event.newPassword,
        );
        if (result['success'] == true) {
          emit(const PasswordChangeSuccess());
        } else {
          emit(AuthError(result['message'] ?? 'فشل تغيير كلمة المرور'));
        }
      } catch (e) {
        emit(AuthError(e.toString()));
      }
    });

  }
}


