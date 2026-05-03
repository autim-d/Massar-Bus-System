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

      final userRecord = await _supabase.from('users').select().eq('id', userId).maybeSingle();
      
      return {'success': true, 'user': userRecord};
    } catch (e) {
      return {'success': false, 'message': 'خطأ في الاتصال بالخادم'};
    }
  }

  // ==========================================
  // 9. التحقق من اكتمال الملف الشخصي
  // ==========================================
  bool isProfileComplete(Map<String, dynamic>? user) {
    if (user == null) return false;
    return user['gender'] != null && 
           user['phone_number'] != null && 
           user['location_permission'] == true;
  }

  // ==========================================
  // 10. تحديث الملف الشخصي بالبيانات الناقصة
  // ==========================================
  Future<Map<String, dynamic>> completeProfile({
    required String gender,
    required String phone,
    required bool locationPermission,
  }) async {
    try {
      final userId = _supabase.auth.currentUser?.id;
      final userEmail = _supabase.auth.currentUser?.email;
      final userMetadata = _supabase.auth.currentUser?.userMetadata;
      
      if (userId == null) throw Exception('User not logged in');

      // Extract metadata from Google
      final String? firstName = userMetadata?['full_name']?.split(' ').first;
      final String? lastName = userMetadata?['full_name']?.split(' ').skip(1).join(' ');
      final String? avatarUrl = userMetadata?['avatar_url'] ?? userMetadata?['picture'];

      print('DEBUG: Syncing user to public.users table...');
      print('DEBUG: Avatar URL found: $avatarUrl');

      final data = {
        'id': userId,
        'gender': gender,
        'phone_number': phone,
        'location_permission': locationPermission,
        'email': userEmail,
        'first_name': firstName,
        'last_name': lastName,
        'avatar_url': avatarUrl, // Save the image URL!
      };

      final response = await _supabase.from('users').upsert(data).select().single();
      print('DEBUG: Upsert success: $response');

      return {'success': true};
    } catch (e) {
      print('DEBUG: CRITICAL ERROR during upsert: $e');
      return {'success': false, 'message': e.toString()};
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
      // 1. Google Web Client ID من لوحة تحكم Supabase
      const webClientId = '632794604210-jjving8bqbci91vuud90u2225l5kipvi.apps.googleusercontent.com';

      // 2. تهيئة تسجيل الدخول عبر جوجل
      final GoogleSignIn googleSignIn = GoogleSignIn(
        serverClientId: webClientId,
      );
      
      // Force account picker by signing out first
      await googleSignIn.signOut();
      
      final googleUser = await googleSignIn.signIn();
      if (googleUser == null) return {'success': false, 'message': 'تم إلغاء تسجيل الدخول'};

      final googleAuth = await googleUser.authentication;
      final accessToken = googleAuth.accessToken;
      final idToken = googleAuth.idToken;

      if (idToken == null) {
        throw Exception('ID Token not found');
      }

      // 3. تمرير التوكن إلى Supabase
      final AuthResponse res = await _supabase.auth.signInWithIdToken(
        provider: OAuthProvider.google,
        idToken: idToken,
        accessToken: accessToken,
      );

      // 4. جلب بيانات المستخدم أو استخدام البيانات الوصفية كخيار بديل
      final userData = await getDashboardData();
      final isComplete = isProfileComplete(userData['user']);
      
      final user = userData['success'] && userData['user'] != null ? userData['user'] : {
        'first_name': res.user!.userMetadata?['full_name']?.split(' ').first ?? 'User',
        'last_name': res.user!.userMetadata?['full_name']?.split(' ').last ?? '',
        'email': res.user!.email,
        'avatar_url': res.user!.userMetadata?['avatar_url'],
      };

      return {
        'success': true, 
        'user': user, 
        'isProfileComplete': isComplete
      };
      
    } on AuthException catch (e) {
      return {'success': false, 'message': e.message};
    } catch (e) {
      return {'success': false, 'message': e.toString()};
    }
  }





}
