<?php

namespace App\Models;

// use Illuminate\Contracts\Auth\MustVerifyEmail;
use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Foundation\Auth\User as Authenticatable;
use Illuminate\Notifications\Notifiable;

class User extends Authenticatable
{
    use HasFactory, Notifiable, \Illuminate\Database\Eloquent\SoftDeletes;

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

    public function bookings()
    {
        return $this->hasMany(Booking::class);
    }
}
