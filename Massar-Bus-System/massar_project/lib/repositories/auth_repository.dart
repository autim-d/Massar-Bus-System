import 'dart:io';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:massar_project/features/account/models/user_model.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:google_sign_in/google_sign_in.dart';

// إنشاء مزود (Provider) للـ Repository
final authRepositoryProvider = Provider<AuthRepository>((ref) {
  return AuthRepository(Supabase.instance.client);
});

class AuthRepository {
  final SupabaseClient _supabase;

  AuthRepository(this._supabase);

  // ==========================================
  // 1. دالة تسجيل الدخول (Login)
  // ==========================================
  Future<Map<String, dynamic>> login(String email, String password) async {
    try {
      final response = await _supabase.auth.signInWithPassword(
        email: email,
        password: password,
      );
      
      final userData = await getDashboardData();
      return {'success': true, 'token': response.session?.accessToken, 'user': userData['user']};
    } on AuthException catch (e) {
      return {
        'success': false,
        'message': e.message,
      };
    } catch (e) {
      return {
        'success': false,
        'message': 'تعذر الاتصال بالخادم، يرجى المحاولة لاحقاً.',
      };
    }
  }

  // ==========================================
  // 2. دالة تحديث الملف الشخصي (Update Profile)
  // ==========================================
  Future<UserModel> updateProfile(UserModel user) async {
    try {
      final userId = _supabase.auth.currentUser?.id;
      if (userId == null) throw Exception('User not logged in');

      // Update auth email if it changed
      if (user.email != _supabase.auth.currentUser?.email) {
        await _supabase.auth.updateUser(UserAttributes(email: user.email));
      }

      // Update public.users table
      final res = await _supabase.from('users').update({
        'first_name': user.firstName,
        'last_name': user.lastName,
        'email': user.email,
        'nationality': user.nationality,
        'identity_number': user.nationalId,
        'phone_number': user.phoneNumber,
      }).eq('id', userId).select().single();

      return UserModel.fromJson(res);
    } on PostgrestException catch (e) {
      throw Exception('فشل تحديث البيانات في السيرفر: ${e.message}');
    } on AuthException catch (e) {
      throw Exception('فشل تحديث البريد: ${e.message}');
    } catch (e) {
      throw Exception('خطأ في الاتصال أثناء تحديث البيانات: $e');
    }
  }

  // ==========================================
  // 3. دالة تغيير كلمة المرور
  // ==========================================
  Future<Map<String, dynamic>> changePassword({
    required String currentPassword,
    required String newPassword,
  }) async {
    try {
      // In Supabase, if the user is logged in, they can just update the password.
      // Re-authentication to check currentPassword would require signInWithPassword.
      final email = _supabase.auth.currentUser?.email;
      if (email != null) {
        await _supabase.auth.signInWithPassword(email: email, password: currentPassword);
      }

      await _supabase.auth.updateUser(UserAttributes(password: newPassword));
      return {
        'success': true,
        'message': 'تم تغيير كلمة المرور بنجاح',
      };
    } on AuthException catch (e) {
      return {
        'success': false,
        'message': e.message,
      };
    } catch (e) {
      return {
        'success': false,
        'message': 'تعذر الاتصال بالسيرفر',
      };
    }
  }

  // ==========================================
  // 4. دالة طلب إرسال رمز التحقق (Send OTP)
  // ==========================================
  Future<bool> sendOtp(String phone) async {
    try {
      await _supabase.auth.signInWithOtp(phone: phone);
      return true;
    } catch (e) {
      print('خطأ في طلب إرسال الرمز: $e');
      return false;
    }
  }

  // ==========================================
  // 5. دالة التحقق من الرمز (Verify OTP)
  // ==========================================
  Future<bool> verifyOtp(String phone, String code) async {
    try {
      final res = await _supabase.auth.verifyOTP(type: OtpType.sms, phone: phone, token: code);
      return res.user != null;
    } catch (e) {
      print('خطأ في التحقق من الرمز: $e');
      return false;
    }
  }

  // ==========================================
  // 6. دالة تجديد الجلسة (Refresh Token)
  // ==========================================
  Future<bool> refreshToken(String currentRefreshToken) async {
    // Supabase handles session refresh automatically, but we can verify the session exists
    return _supabase.auth.currentSession != null;
  }

  // ==========================================
  // 7. دالة إنشاء حساب جديد (Register)
  // ==========================================
  Future<Map<String, dynamic>> register({
    required String firstName,
    required String lastName,
    required String email,
    required String phone,
    required String gender,
    required String password,
  }) async {
    try {
      // 1. Create account in Supabase Auth
      final res = await _supabase.auth.signUp(
        email: email,
        password: password,
      );

      final user = res.user;
      Map<String, dynamic> userData = {
        'first_name': firstName,
        'last_name': lastName,
        'email': email,
        'phone_number': phone,
      };

      if (user != null) {
        // 2. Sync to public.users table
        final dbRes = await _supabase.from('users').insert({
          'id': user.id,
          'first_name': firstName,
          'last_name': lastName,
          'email': email,
          'phone_number': phone,
        }).select().single();
        
        userData = dbRes;
      }

      return {'success': true, 'token': res.session?.accessToken, 'user': userData};
    } on AuthException catch (e) {
      return {
        'success': false,
        'message': e.message,
      };
    } on PostgrestException catch (e) {
      return {
        'success': false,
        'message': 'فشل إدخال البيانات في قاعدة البيانات: ${e.message}',
      };
    } catch (e) {
      return {
        'success': false,
        'message': 'تعذر الاتصال بالخادم، يرجى المحاولة لاحقاً.',
      };
    }
  }

  // ==========================================
  // 8. دالة جلب بيانات الداشبورد (Dashboard Data)
  // ==========================================
  Future<Map<String, dynamic>> getDashboardData() async {
    try {
      final userId = _supabase.auth.currentUser?.id;
      if (userId == null) {
        return {'success': false, 'message': 'غير مسجل الدخول'};
      }

      final userRecord = await _supabase.from('users').select().eq('id', userId).single();
      
      // TODO: Fetch activeTicket from bookings if needed
      final activeTicket = null; 

      return {'success': true, 'user': userRecord, 'activeTicket': activeTicket};
    } catch (e) {
      return {'success': false, 'message': 'خطأ في الاتصال بالخادم'};
    }
  }

  // ==========================================
  // 9. تسجيل الخروج (Logout)
  // ==========================================
  Future<void> logout() async {
    await _supabase.auth.signOut();
  }

  // ==========================================
  // 10. رفع الصورة الشخصية (Upload Avatar)
  // ==========================================
  Future<UserModel> uploadProfileImage(File imageFile) async {
    try {
      final userId = _supabase.auth.currentUser?.id;
      if (userId == null) throw Exception('User not logged in');

      final fileExtension = imageFile.path.split('.').last;
      final fileName = '$userId-${DateTime.now().millisecondsSinceEpoch}.$fileExtension';
      
      await _supabase.storage.from('avatars').upload(fileName, imageFile);
      final imageUrl = _supabase.storage.from('avatars').getPublicUrl(fileName);

      final res = await _supabase.from('users').update({
        'avatar_url': imageUrl,
      }).eq('id', userId).select().single();

      return UserModel.fromJson(res);
    } on StorageException catch (e) {
      throw Exception('فشل رفع الصورة: ${e.message}');
    } catch (e) {
      throw Exception('خطأ في الاتصال أثناء رفع الصورة: $e');
    }
  }

  // ==========================================
  // 11. تسجيل الدخول عبر جوجل (Google Sign-In)
  // ==========================================
  Future<Map<String, dynamic>> signInWithGoogle() async {
    try {
      // ✅ استخدام تسجيل الدخول المباشر عبر Supabase OAuth
      // هذا سيفتح نافذة متصفح داخل التطبيق (In-App Browser) 
      // وهو أكثر استقراراً ولا يتطلب إعدادات SHA-1 معقدة
      final bool res = await _supabase.auth.signInWithOAuth(
        OAuthProvider.google,
        redirectTo: 'io.supabase.massar://login-callback',
      );

      if (res) {
        // ننتظر قليلاً للتأكد من تحديث الجلسة
        await Future.delayed(const Duration(seconds: 1));
        
        final userData = await getDashboardData();
        
        // إذا لم نجد بيانات في الجدول، نستخدم البيانات من الجلسة الحالية
        final currentUser = _supabase.auth.currentUser;
        final user = userData['success'] ? userData['user'] : {
          'first_name': currentUser?.userMetadata?['full_name']?.split(' ').first ?? 'User',
          'last_name': currentUser?.userMetadata?['full_name']?.split(' ').last ?? '',
          'email': currentUser?.email,
          'avatar_url': currentUser?.userMetadata?['avatar_url'],
        };

        return {'success': true, 'user': user};
      } else {
        return {'success': false, 'message': 'تعذر فتح صفحة تسجيل الدخول'};
      }
    } on AuthException catch (e) {
      return {'success': false, 'message': e.message};
    } catch (e) {
      return {'success': false, 'message': e.toString()};
    }
  }




}
