<?php

namespace App\Http\Controllers\Api;

use App\Http\Controllers\Controller;
use Illuminate\Http\Request;
use Kreait\Laravel\Firebase\Facades\Firebase;
use Kreait\Firebase\Exception\AuthException;

class AuthController extends Controller
{
    /**
     * ==========================================
     * 1. تسجيل الدخول (Login) عبر Firebase
     * ==========================================
     */
    public function login(Request $request)
    {
        $request->validate([
            'email' => 'required|email',
            'password' => 'required',
        ]);

        try {
            $auth = Firebase::auth();
            
            // تسجيل الدخول باستخدام الإيميل وكلمة المرور في Firebase
            $signInResult = $auth->signInWithEmailAndPassword($request->email, $request->password);

            // جلب بيانات المستخدم من Firebase
            $userRecord = $auth->getUser($signInResult->firebaseUserId());

            // إرجاع التوكن وبيانات المستخدم لتطبيق Flutter
            return response()->json([
                'token' => $signInResult->idToken(),
                'user' => [
                    'name' => $userRecord->displayName ?? 'مستخدم مسار',
                    'email' => $userRecord->email,
                    'avatar_url' => $userRecord->photoUrl ?? '',
                ]
            ], 200);

        } catch (AuthException $e) {
            // خطأ في الإيميل أو الباسوورد
            return response()->json([
                'message' => 'البريد الإلكتروني أو كلمة المرور غير صحيحة.',
                'error' => $e->getMessage()
            ], 401);
        } catch (\Exception $e) {
            return response()->json([
                'message' => 'تعذر الاتصال بخادم المصادقة.',
            ], 500);
        }
    }

    /**
     * ==========================================
     * 2. إنشاء حساب جديد (Register) عبر Firebase
     * ==========================================
     */
    public function register(Request $request)
    {
        $request->validate([
            'first_name' => 'required|string',
            'last_name' => 'required|string',
            'email' => 'required|email',
            'password' => 'required|min:8',
            'phone' => 'required|string',
        ]);

        try {
            $auth = Firebase::auth();
            
            // تجهيز بيانات المستخدم الجديد
            $userProperties = [
                'email' => $request->email,
                'emailVerified' => false,
                'password' => $request->password,
                'displayName' => $request->first_name . ' ' . $request->last_name,
                // Firebase يتطلب أن يكون رقم الهاتف بصيغة E.164 (مثل +967777777777)
                'phoneNumber' => $request->phone, 
            ];

            // إنشاء المستخدم في Firebase
            $createdUser = $auth->createUser($userProperties);

            // تسجيل الدخول فوراً لإرجاع التوكن للتطبيق
            $signInResult = $auth->signInWithEmailAndPassword($request->email, $request->password);

            return response()->json([
                'token' => $signInResult->idToken(),
                'user' => [
                    'name' => $createdUser->displayName,
                    'email' => $createdUser->email,
                    'avatar_url' => '',
                ]
            ], 201);

        } catch (AuthException $e) {
            return response()->json([
                'message' => 'البريد الإلكتروني أو رقم الهاتف مستخدم مسبقاً.',
                'error' => $e->getMessage()
            ], 422);
        } catch (\Exception $e) {
            return response()->json([
                'message' => 'حدث خطأ أثناء إنشاء الحساب تأكد من صيغة رقم الهاتف (يجب أن يحوي مفتاح الدولة).',
                'error' => $e->getMessage()
            ], 500);
        }
    }

    /**
     * ==========================================
     * 3. إرسال رمز OTP (Phone Auth)
     * ==========================================
     */
    public function sendOtp(Request $request)
    {
        $request->validate([
            'phone' => 'required|string',
        ]);

        // ملاحظة: مصادقة الهاتف في Firebase تُنفذ غالباً من داخل تطبيق Flutter مباشرة 
        // لأسباب أمنية (reCAPTCHA). هذا المسار هنا كاستجابة وهمية (Mock) لكي لا يتعطل تطبيقك 
        // حتى تقوم بربط الـ Phone Auth في Flutter.
        
        return response()->json([
            'message' => 'تم استلام طلب الإرسال بنجاح (Mock Mode).'
        ], 200);
    }

    /**
     * ==========================================
     * 4. التحقق من رمز OTP (Verify Phone)
     * ==========================================
     */
    public function verifyOtp(Request $request)
    {
        $request->validate([
            'phone' => 'required|string',
            'code' => 'required|string',
        ]);

        // مسار وهمي للنجاح مؤقتاً
        return response()->json([
            'message' => 'تم التحقق بنجاح.'
        ], 200);
    }

    /**
     * ==========================================
     * 5. تجديد جلسة التوكن (Refresh Token) 
     * ==========================================
     */
    public function refresh(Request $request)
    {
        $request->validate([
            'refresh_token' => 'required|string',
        ]);

        try {
            $auth = Firebase::auth();
            $signInResult = $auth->signInWithRefreshToken($request->refresh_token);

            return response()->json([
                'id_token' => $signInResult->idToken(),
                'refresh_token' => $signInResult->refreshToken(),
                'expires_in' => $signInResult->ttl(),
            ]);
        } catch (AuthException $e) {
            return response()->json([
                'error' => 'Failed to refresh token',
                'message' => $e->getMessage()
            ], 401);
        } catch (\Exception $e) {
            return response()->json([
                'error' => 'Internal Server Error',
                'message' => $e->getMessage()
            ], 500);
        }
    }
    /**
     * ==========================================
     * 6. تغيير كلمة المرور (Change Password)
     * ==========================================
     */
    public function changePassword(Request $request)
    {
        // التحقق من المدخلات
        $request->validate([
            'current_password' => 'required',
            'new_password' => 'required|min:8',
        ]);

        try {
            $auth = Firebase::auth();
            
            // للحصول على المستخدم الحالي، نحتاج للإيميل (يأتي من التوكن عبر الـ Middleware)
            // أو يمكننا استخدام الإيميل إذا كان مخزناً في قاعدة البيانات المحلية.
            $userEmail = $request->user()->email; 

            // الخطوة 1: إعادة التحقق من كلمة المرور الحالية (لأمان عالي)
            // Firebase لا يسمح بتغيير الباسوورد إلا إذا قمت بعمل SignIn مؤخراً
            try {
                $auth->signInWithEmailAndPassword($userEmail, $request->current_password);
            } catch (\Exception $e) {
                return response()->json([
                    'success' => false,
                    'message' => 'كلمة المرور الحالية غير صحيحة.'
                ], 401);
            }

            // الخطوة 2: تحديث كلمة المرور في Firebase
            $userRecord = $auth->getUserByEmail($userEmail);
            $auth->updateUser($userRecord->uid, [
                'password' => $request->new_password
            ]);

            return response()->json([
                'success' => true,
                'message' => 'تم تغيير كلمة المرور بنجاح.'
            ], 200);

        } catch (AuthException $e) {
            return response()->json([
                'success' => false,
                'message' => 'حدث خطأ في نظام المصادقة، يرجى المحاولة لاحقاً.',
                'error' => $e->getMessage()
            ], 500);
        } catch (\Exception $e) {
            return response()->json([
                'success' => false,
                'message' => 'تعذر الاتصال بالسيرفر.',
                'error' => $e->getMessage()
            ], 500);
        }
    }
}