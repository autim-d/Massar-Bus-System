<?php

use Illuminate\Http\Request;
use Illuminate\Support\Facades\Route;
use App\Http\Controllers\Api\AuthController;
use App\Http\Controllers\Api\StationController;
use App\Http\Controllers\Api\TripController;
use App\Http\Controllers\Api\BookingController;
use App\Http\Controllers\Api\PaymentController;
use App\Http\Controllers\Api\UserController;
use App\Http\Controllers\Api\NotificationController;

// ─── 1. مسارات المصادقة (Auth Routes) ───────────────────────────────────────
Route::post('/auth/login', [AuthController::class, 'login']);
Route::post('/auth/register', [AuthController::class, 'register']);
Route::post('/auth/send-otp', [AuthController::class, 'sendOtp']);
Route::post('/auth/verify-otp', [AuthController::class, 'verifyOtp']);
Route::post('/auth/refresh', [AuthController::class, 'refresh']);

// ─── 2. مسارات عامة (Public Routes) ──────────────────────────────────────────
Route::get('/stations', [StationController::class, 'index']);
Route::get('/trips/search', [TripController::class, 'search']); // مسار نتائج البحث (BusResultsScreen)

// ─── 3. مسارات محمية (Protected Routes) ──────────────────────────────────────
Route::middleware('firebase.auth')->group(function () {
    
    // بيانات الصفحة الرئيسية (الاسم، الإشعارات، والتذكرة النشطة)
    // هذا المسار هو الذي سيعطي البيانات لـ HomeScreen
    Route::get('/home/dashboard', [UserController::class, 'getDashboardData']);

    // Notifications
    Route::get('notifications', [NotificationController::class, 'index']);
    Route::post('notifications/{id}/read', [NotificationController::class, 'markAsRead']);
    Route::post('notifications/read-all', [NotificationController::class, 'markAllAsRead']);
    Route::delete('notifications/{id}', [NotificationController::class, 'destroy']);

    // الملف الشخصي
    Route::get('/user/profile', [UserController::class, 'profile']);
    Route::put('/user/profile', [UserController::class, 'update']);
    Route::post('/user/update-avatar', [UserController::class, 'updateAvatar']);

    // الحجوزات
    Route::get('/bookings', [BookingController::class, 'index']);
    Route::post('/bookings', [BookingController::class, 'store']);
    
    // تغيير كلمة المرور
    Route::post('/auth/change-password', [AuthController::class, 'changePassword']);

    // مسار التذكرة النشطة المنفصل (إذا كنت تستخدم Provider مستقل لها)
    Route::get('/user/active-ticket', [BookingController::class, 'getActiveTicket']);

    // المدفوعات
    Route::post('/payments/intent', [PaymentController::class, 'createIntent']);
    Route::post('/payments/confirm', [PaymentController::class, 'confirm']);
});