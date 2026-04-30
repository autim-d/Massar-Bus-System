<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Foundation\Auth\User as Authenticatable;
use Illuminate\Notifications\Notifiable;
use Illuminate\Database\Eloquent\SoftDeletes;

class User extends Authenticatable
{
    use HasFactory, Notifiable, SoftDeletes;

    protected $fillable = [
        'firebase_uid',
        'first_name',
        'last_name',
        'email',
        'phone_number',
        'identity_number',
        'nationality',
        'avatar_url',
    ];

    // 1. علاقة الحجوزات (موجودة لديك وهي صحيحة)
    public function bookings()
    {
        return $this->hasMany(Booking::class);
    }

    // 2. إضافة دالة لجلب عدد الإشعارات غير المقروءة
    // هذه الدالة ستغذي حقل unreadNotificationsCount في Flutter
    public function getUnreadNotificationsCountAttribute()
    {
        return $this->unreadNotifications()->count();
    }

    // 3. (اختياري) دالة لدمج الاسم الأول والأخير إذا احتجتها
    public function getFullNameAttribute()
    {
        return "{$this->first_name} {$this->last_name}";
    }
}