<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class Trip extends Model
{
    protected $fillable = [
        'route_id',
        'bus_id',
        'departure_time',
        'arrival_time',
        'price',
        'status',
    ];

    protected $casts = [
        'departure_time' => 'datetime',
        'arrival_time' => 'datetime',
        'price' => 'float',
    ];

    public function route() { return $this->belongsTo(Route::class); }
    public function bus() { return $this->belongsTo(Bus::class); }
    public function bookings() { return $this->hasMany(Booking::class); }
}
