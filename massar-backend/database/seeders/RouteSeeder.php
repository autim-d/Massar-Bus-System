<?php

namespace Database\Seeders;

use Illuminate\Database\Console\Seeds\WithoutModelEvents;
use Illuminate\Database\Seeder;
use App\Models\Route;
use App\Models\Station;

class RouteSeeder extends Seeder
{
    public function run(): void
    {
        $riyadh = Station::where('city', 'Riyadh')->first();
        $jeddah = Station::where('city', 'Jeddah')->first();
        $dammam = Station::where('city', 'Dammam')->first();
        $makkah = Station::where('city', 'Makkah')->first();

        if ($riyadh && $jeddah && $dammam && $makkah) {
            $routes = [
                ['origin' => $riyadh->id, 'destination' => $dammam->id, 'duration' => 240],
                ['origin' => $dammam->id, 'destination' => $riyadh->id, 'duration' => 240],
                ['origin' => $riyadh->id, 'destination' => $jeddah->id, 'duration' => 600],
                ['origin' => $jeddah->id, 'destination' => $riyadh->id, 'duration' => 600],
                ['origin' => $jeddah->id, 'destination' => $makkah->id, 'duration' => 60],
                ['origin' => $makkah->id, 'destination' => $jeddah->id, 'duration' => 60],
            ];

            foreach ($routes as $r) {
                Route::firstOrCreate(
                    [
                        'origin_station_id' => $r['origin'],
                        'destination_station_id' => $r['destination'],
                    ],
                    [
                        'estimated_duration_minutes' => $r['duration']
                    ]
                );
            }
        }
    }
}
