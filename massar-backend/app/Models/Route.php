<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class Route extends Model
{
    public function origin() { return $this->belongsTo(Station::class, 'origin_station_id'); }
    public function destination() { return $this->belongsTo(Station::class, 'destination_station_id'); }

    // Aliases used by TripResource, TripController, and UserController
    public function originStation() { return $this->belongsTo(Station::class, 'origin_station_id'); }
    public function destinationStation() { return $this->belongsTo(Station::class, 'destination_station_id'); }

    public function trips() { return $this->hasMany(Trip::class); }
}
