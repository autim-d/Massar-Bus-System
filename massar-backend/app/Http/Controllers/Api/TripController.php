<?php

namespace App\Http\Controllers\Api;

use App\Http\Controllers\Controller;
use Illuminate\Http\Request;
use App\Models\Trip;
use App\Http\Resources\TripResource;
use Carbon\Carbon;

class TripController extends Controller
{
    public function search(Request $request)
    {
        $request->validate([
            'origin_station_id' => 'required|exists:stations,id',
            'destination_station_id' => 'required|exists:stations,id',
            'date' => 'required|date',
        ]);

        $date = Carbon::parse($request->date)->startOfDay();

        $trips = Trip::with(['route', 'bus'])
            ->whereHas('route', function($q) use ($request) {
                $q->where('origin_station_id', $request->origin_station_id)
                  ->where('destination_station_id', $request->destination_station_id);
            })
            ->whereDate('departure_time', $date)
            ->where('status', 'scheduled')
            ->get();

        return TripResource::collection($trips);
    }
}
