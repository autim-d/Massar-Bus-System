import 'dart:io';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:massar_project/features/account/models/user_model.dart';
import 'package:massar_project/repositories/auth_repository.dart';
import 'auth_event.dart';
import 'auth_state.dart';

/// [AuthBloc] هو المسؤول عن إدارة حالة المصادقة والملف الشخصي للمستخدم.
/// يقوم بالربط بين واجهات المستخدم (UI) ومستودع البيانات (AuthRepository).
class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthRepository authRepository;

  AuthBloc({required this.authRepository}) : super(const AuthInitial()) {
    // تسجيل جميع معالجي الأحداث
    on<LoginSubmitted>(_onLoginSubmitted);
    on<GuestLoginRequested>(_onGuestLoginRequested);
    on<SendOtpRequested>(_onSendOtpRequested);
    on<RegisterSubmitted>(_onRegisterSubmitted);
    on<UpdateProfileSubmitted>(_onUpdateProfileSubmitted);
    on<ChangePasswordRequested>(_onChangePasswordRequested);
    on<UpdateAvatarRequested>(_onUpdateAvatarRequested);
    on<GetUserDataEvent>(_onGetUserData);
    on<LogoutRequested>(_onLogoutRequested);
    on<GoogleLoginRequested>(_onGoogleLoginRequested);
  }

  // ===========================================================================
  // 1. معالجة حدث جلب بيانات المستخدم (Dashboard Data)
  // ===========================================================================
  Future<void> _onGetUserData(
    GetUserDataEvent event,
    Emitter<AuthState> emit,
  ) async {
    // ملاحظة: لا نستخدم AuthLoading هنا لتجنب ظهور مؤشر تحميل يقطع تجربة المستخدم في الهوم
    try {
      final result = await authRepository.getDashboardData();

      if (result['success'] == true && result['user'] != null) {
        final user = UserModel.fromJson(result['user']);
        final activeTicket = result['activeTicket'];
        final suggestedStations = result['suggestedStations'];
        // تحديث الحالة ببيانات المستخدم الجديدة (الاسم، الإشعارات، والتذكرة النشطة)
        emit(AuthAuthenticated.fromModel(
          user, 
          activeTicket: activeTicket,
          suggestedStations: suggestedStations,
        ));
      }
    } catch (e) {
      // في حال الفشل نكتفي بالبقاء على الحالة الحالية بصمت
    }
  }

  // ===========================================================================
  // 2. معالجة حدث تحديث الصورة الشخصية (Update Avatar)
  // ===========================================================================
  Future<void> _onUpdateAvatarRequested(
    UpdateAvatarRequested event,
    Emitter<AuthState> emit,
  ) async {
    final previousState = state;
    emit(const AuthLoading());
    try {
      final updatedUser = await authRepository.uploadProfileImage(
        File(event.imagePath),
      );

      // إرسال حالة النجاح المؤقتة
      emit(ProfileUpdateSuccess(user: updatedUser));

      // تحديث الحالة الدائمة للمصادقة بالبيانات الجديدة
      emit(AuthAuthenticated.fromModel(updatedUser));
    } catch (e) {
      emit(AuthError(message: e.toString().replaceAll('Exception: ', '')));
      // في حال الخطأ، نعود للحالة السابقة حتى لا تختفي بيانات المستخدم وتظهر شاشة تسجيل الدخول
      if (previousState is AuthAuthenticated) {
        emit(previousState);
      } else if (previousState is ProfileUpdateSuccess) {
        emit(AuthAuthenticated.fromModel(previousState.user));
      }
    }
  }

  // ===========================================================================
  // 3. معالجة حدث تغيير كلمة المرور (Change Password)
  // ===========================================================================
  Future<void> _onChangePasswordRequested(
    ChangePasswordRequested event,
    Emitter<AuthState> emit,
  ) async {
    emit(const AuthLoading());

    try {
      final result = await authRepository.changePassword(
        currentPassword: event.currentPassword,
        newPassword: event.newPassword,
      );

      if (result['success'] == true) {
        // عند النجاح نُشعر المستخدم بالنجاح (ويمكن إعادة توجيهه لشاشة تسجيل الدخول)
        emit(const PasswordChangeSuccess());
      } else {
        emit(AuthError(message: result['message'] ?? 'فشل تغيير كلمة المرور.'));
      }
    } catch (e) {
      emit(AuthError(message: e.toString().replaceAll('Exception: ', '')));
    }
  }

  // ===========================================================================
  // 4. معالجة حدث تحديث بيانات الملف الشخصي (Update Profile)
  // ===========================================================================
  Future<void> _onUpdateProfileSubmitted(
    UpdateProfileSubmitted event,
    Emitter<AuthState> emit,
  ) async {
    final previousState = state;
    emit(const AuthLoading());

    try {
      final updatedUser = await authRepository.updateProfile(event.user);

      // نرسل حالة النجاح للمستمعين (لإغلاق الـ Dialog مثلاً)
      emit(ProfileUpdateSuccess(user: updatedUser));
      
      // نحدّث الحالة العامة للمصادقة لتعكس البيانات الجديدة في كامل التطبيق
      emit(AuthAuthenticated.fromModel(updatedUser));
    } catch (e) {
      emit(AuthError(message: e.toString().replaceAll('Exception: ', '')));
      // في حال الخطأ، نعيد المستخدم لحالته السابقة إذا كان لدينا بيانات قديمة
      if (previousState is AuthAuthenticated) {
        emit(previousState);
      } else if (previousState is ProfileUpdateSuccess) {
        emit(AuthAuthenticated.fromModel(previousState.user));
      }
    }
  }

  // ===========================================================================
  // 5. معالجة حدث تسجيل الدخول التقليدي (Login)
  // ===========================================================================
  Future<void> _onLoginSubmitted(
    LoginSubmitted event,
    Emitter<AuthState> emit,
  ) async {
    emit(const AuthLoading());

    try {
      final result = await authRepository.login(event.email, event.password);

      if (result['success'] == true && result['user'] != null) {
        final user = UserModel.fromJson(result['user']);
        emit(AuthAuthenticated.fromModel(user));
      } else {
        emit(
          AuthError(
            message: result['message'] ?? 'فشل تسجيل الدخول، تأكد من البيانات.',
          ),
        );
      }
    } catch (e) {
      emit(const AuthError(message: 'تعذر الاتصال بخادم المصادقة.'));
    }
  }

  // ===========================================================================
  // 6. معالجة حدث إنشاء حساب جديد (Register)
  // ===========================================================================
  Future<void> _onRegisterSubmitted(
    RegisterSubmitted event,
    Emitter<AuthState> emit,
  ) async {
    emit(const AuthLoading());

    try {
      final result = await authRepository.register(
        firstName: event.firstName,
        lastName: event.lastName,
        email: event.email,
        phone: event.phone,
        gender: event.gender,
        password: event.password,
      );

      if (result['success'] == true && result['user'] != null) {
        final user = UserModel.fromJson(result['user']);
        emit(AuthAuthenticated.fromModel(user));
      } else {
        emit(AuthError(message: result['message'] ?? 'فشل إنشاء الحساب.'));
      }
    } catch (e) {
      emit(AuthError(message: e.toString()));
    }
  }

  // ===========================================================================
  // 7. معالجة حدث طلب OTP (Phone Login)
  // ===========================================================================
  Future<void> _onSendOtpRequested(
    SendOtpRequested event,
    Emitter<AuthState> emit,
  ) async {
    emit(const AuthLoading());

    final success = await authRepository.sendOtp(event.phone);

    if (success) {
      emit(OtpSentSuccess(phone: event.phone));
    } else {
      emit(const AuthError(message: 'فشل إرسال الرمز، يرجى المحاولة لاحقاً.'));
    }
  }

  // ===========================================================================
  // 8. معالجة حدث الدخول كزائر (Guest)
  // ===========================================================================
  Future<void> _onGuestLoginRequested(
    GuestLoginRequested event,
    Emitter<AuthState> emit,
  ) async {
    emit(const AuthLoading());
    await Future.delayed(const Duration(milliseconds: 300));
    emit(const AuthGuest());
  }

  // ===========================================================================
  // 9. معالجة حدث تسجيل الخروج (Logout)
  // ===========================================================================
  Future<void> _onLogoutRequested(
    LogoutRequested event,
    Emitter<AuthState> emit,
  ) async {
    try {
      await authRepository.logout();
      emit(const AuthInitial());
    } catch (e) {
      emit(AuthError(message: e.toString()));
    }
  }

  // ===========================================================================
  // 10. معالجة حدث تسجيل الدخول عبر جوجل
  // ===========================================================================
  Future<void> _onGoogleLoginRequested(
    GoogleLoginRequested event,
    Emitter<AuthState> emit,
  ) async {
    emit(const AuthLoading());
    try {
      final result = await authRepository.loginWithGoogle();
      if (result['success'] == true && result['user'] != null) {
        final user = UserModel.fromJson(result['user']);
        emit(AuthAuthenticated.fromModel(user));
      } else {
        emit(AuthError(message: result['message'] ?? 'فشل تسجيل الدخول باستخدام جوجل.'));
      }
    } catch (e) {
      emit(const AuthError(message: 'تعذر تسجيل الدخول عبر جوجل.'));
    }
  }
}

