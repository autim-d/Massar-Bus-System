<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class Booking extends Model
{
    protected $fillable = [
        'user_id', 'trip_id', 'booking_code',
        'ticket_price', 'protection_price', 'service_fee', 'total_amount',
        'status', 'purchased_at',
        'passenger_name', 'passenger_phone',
    ];

    protected $casts = [
        'purchased_at' => 'datetime',
        'ticket_price' => 'float',
        'protection_price' => 'float',
        'service_fee' => 'float',
        'total_amount' => 'float',
    ];

    public function trip() { return $this->belongsTo(Trip::class); }
    public function user() { return $this->belongsTo(User::class); }
    public function payment() { return $this->hasOne(Payment::class); }
}
