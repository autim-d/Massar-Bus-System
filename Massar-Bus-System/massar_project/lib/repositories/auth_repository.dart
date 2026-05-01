import 'dart:convert';
import 'dart:io'; // تم استيراد الملف للتعامل مع File
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;
import 'package:massar_project/core/services/http_service.dart';
import 'package:massar_project/features/account/models/user_model.dart';
import 'dart:io' show Platform;
import 'package:firebase_auth/firebase_auth.dart';

// إنشاء مزود (Provider) للـ Repository
final authRepositoryProvider = Provider<AuthRepository>((ref) {
  final httpService = ref.watch(httpServiceProvider);
  return AuthRepository(httpService);
});

class AuthRepository {
  final HttpService _httpService;

  AuthRepository(this._httpService);

  final String _baseUrl = Platform.isAndroid
      ? 'http://10.0.0.109:8000/api'
      : 'http://127.0.0.1:8000/api';

  // ==========================================
  // 1. دالة تسجيل الدخول (Login)
  // ==========================================
  Future<Map<String, dynamic>> login(String email, String password) async {
    try {
      final userCredential = await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      // جلب بيانات المستخدم الإضافية من Laravel
      final profileResponse = await _httpService.get('$_baseUrl/user/profile');
      if (profileResponse.statusCode == 200) {
        final profileData = jsonDecode(profileResponse.body);
        return {'success': true, 'token': await userCredential.user?.getIdToken(), 'user': profileData['user']};
      } else {
        return {'success': true, 'token': await userCredential.user?.getIdToken(), 'user': {
          'email': userCredential.user?.email,
          'first_name': userCredential.user?.displayName ?? 'مستخدم',
        }};
      }
    } on FirebaseAuthException catch (e) {
      return {
        'success': false,
        'message': e.message ?? 'البريد الإلكتروني أو كلمة المرور غير صحيحة.',
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
      // 1. تحديث البريد الإلكتروني في Firebase إذا تغير
      final fbUser = FirebaseAuth.instance.currentUser;
      if (fbUser != null && fbUser.email != user.email) {
        try {
          await fbUser.verifyBeforeUpdateEmail(user.email);
        } catch (e) {
          // إذا فشل التحديث (مثلاً يحتاج تسجيل دخول حديث)، نلقي استثناءً واضحاً
          if (e.toString().contains('requires-recent-login')) {
            throw Exception('لتغيير البريد الإلكتروني، يجب إعادة تسجيل الدخول أولاً لدواعي أمنية.');
          }
          throw Exception('فشل تحديث البريد في Firebase: $e');
        }
      }

      // 2. تحديث البيانات في Laravel
      final response = await _httpService.put(
        '$_baseUrl/user/profile',
        body: {
          'first_name': user.firstName,
          'last_name': user.lastName,
          'email': user.email,
          'nationality': user.nationality,
          'identity_number': user.nationalId,
          'phone_number': user.phoneNumber,
        },
      );

      final Map<String, dynamic> data = jsonDecode(response.body);

      if (response.statusCode == 200) {
        return UserModel.fromJson(data['user'] ?? data);
      } else {
        throw Exception(data['message'] ?? 'فشل تحديث البيانات في السيرفر');
      }
    } catch (e) {
      if (e is Exception) rethrow;
      throw Exception('خطأ في الاتصال أثناء تحديث البيانات: $e');
    }
  }

  // ==========================================
  Future<Map<String, dynamic>> changePassword({
    required String currentPassword,
    required String newPassword,
  }) async {
    try {
      final response = await _httpService.post(
        '$_baseUrl/auth/change-password',
        body: {
          'current_password': currentPassword,
          'new_password': newPassword,
        },
      );

      // تأكد أن الاستجابة ليست فارغة قبل التحليل
      if (response.body.isEmpty) {
        return {'success': false, 'message': 'استجابة فارغة من السيرفر'};
      }

      final Map<String, dynamic> data = jsonDecode(response.body);

      if (response.statusCode == 200) {
        return {
          'success': true,
          'message': data['message'] ?? 'تم تغيير كلمة المرور بنجاح',
        };
      } else {
        // هنا سيعطيك الرسالة القادمة من Laravel (مثل: كلمة المرور القديمة خطأ)
        return {
          'success': false,
          'message': data['message'] ?? 'فشل الطلب: ${response.statusCode}',
        };
      }
    } catch (e) {
      // طباعة الخطأ في الـ Console تساعدك جداً في معرفة السبب الحقيقي
      print("Error in changePassword: $e");
      return {
        'success': false,
        'message': 'تعذر الاتصال بالسيرفر، تأكد من تشغيل Laravel',
      };
    }
  }

  // ==========================================
  // 5. دالة طلب إرسال رمز التحقق (Send OTP)
  // ==========================================
  Future<bool> sendOtp(String phone) async {
    try {
      final response = await _httpService.post(
        '$_baseUrl/auth/send-otp',
        body: {'phone': phone},
      );

      return response.statusCode == 200;
    } catch (e) {
      print('خطأ في طلب إرسال الرمز: $e');
      return false;
    }
  }

  // ==========================================
  // 6. دالة التحقق من الرمز (Verify OTP)
  // ==========================================
  Future<bool> verifyOtp(String phone, String code) async {
    try {
      final response = await _httpService.post(
        '$_baseUrl/auth/verify-otp',
        body: {'phone': phone, 'code': code},
      );

      return response.statusCode == 200;
    } catch (e) {
      print('خطأ في التحقق من الرمز: $e');
      return false;
    }
  }

  // ==========================================
  // 7. دالة تجديد الجلسة (Refresh Token)
  // ==========================================
  Future<bool> refreshToken(String currentRefreshToken) async {
    try {
      final response = await _httpService.post(
        '$_baseUrl/auth/refresh',
        body: {'refresh_token': currentRefreshToken},
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> data = jsonDecode(response.body);
        print('تم تجديد الجلسة بنجاح: ${data['id_token']}');
        return true;
      }
      return false;
    } catch (e) {
      print('خطأ في الاتصال أثناء تجديد الجلسة: $e');
      return false;
    }
  }

  // ==========================================
  // 8. دالة إنشاء حساب جديد (Register)
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
      // 1. إنشاء الحساب في Firebase
      final userCredential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      await userCredential.user?.updateDisplayName('$firstName $lastName');

      // 2. مزامنة البيانات مع Laravel
      final profileResponse = await _httpService.put(
        '$_baseUrl/user/profile',
        body: {
          'first_name': firstName,
          'last_name': lastName,
          'email': email,
          'phone_number': phone,
        },
      );

      Map<String, dynamic> userData = {
          'first_name': firstName,
          'last_name': lastName,
          'email': email,
          'phone_number': phone,
      };

      if (profileResponse.statusCode == 200) {
          final profileData = jsonDecode(profileResponse.body);
          userData = profileData['user'] ?? userData;
      }

      return {'success': true, 'token': await userCredential.user?.getIdToken(), 'user': userData};
    } on FirebaseAuthException catch (e) {
      return {
        'success': false,
        'message': e.message ?? 'فشل إنشاء الحساب.',
      };
    } catch (e) {
      return {
        'success': false,
        'message': 'تعذر الاتصال بالخادم، يرجى المحاولة لاحقاً.',
      };
    }
  }

  // ==========================================
  // 9. دالة جلب بيانات الداشبورد (Dashboard Data)
  // ==========================================
  Future<Map<String, dynamic>> getDashboardData() async {
    try {
      final response = await _httpService.get('$_baseUrl/home/dashboard');
      final Map<String, dynamic> data = jsonDecode(response.body);

      if (response.statusCode == 200) {
        return {'success': true, 'user': data['user'], 'activeTicket': data['activeTicket']};
      } else {
        return {'success': false, 'message': data['message'] ?? 'فشل تحميل بيانات الصفحة الرئيسية'};
      }
    } catch (e) {
      return {'success': false, 'message': 'خطأ في الاتصال بالخادم'};
    }
  }

  // ==========================================
  // 10. تسجيل الخروج (Logout)
  // ==========================================
  Future<void> logout() async {
    await FirebaseAuth.instance.signOut();
  }
  // ==========================================
  // 11. رفع الصورة الشخصية (Upload Avatar)
  // ==========================================
  Future<UserModel> uploadProfileImage(File imageFile) async {
    try {
      final response = await _httpService.multipart(
        '$_baseUrl/user/update-avatar',
        filePath: imageFile.path,
        fieldName: 'avatar',
      );

      final Map<String, dynamic> data = jsonDecode(response.body);

      if (response.statusCode == 200 && data['success'] == true) {
        return UserModel.fromJson(data['user']);
      } else {
        throw Exception(data['message'] ?? 'فشل رفع الصورة');
      }
    } catch (e) {
      throw Exception('خطأ في الاتصال أثناء رفع الصورة: $e');
    }
  }
}
