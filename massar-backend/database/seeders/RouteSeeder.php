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
        $sanaa = Station::where('city', 'صنعاء')->first();
        $aden = Station::where('city', 'عدن')->first();
        $taiz = Station::where('city', 'تعز')->first();
        $ibb = Station::where('city', 'إب')->first();

        if ($sanaa && $aden && $taiz && $ibb) {
            $routes = [
                ['origin' => $sanaa->id, 'destination' => $aden->id, 'duration' => 420], // ~7 hours
                ['origin' => $aden->id, 'destination' => $sanaa->id, 'duration' => 420],
                ['origin' => $sanaa->id, 'destination' => $taiz->id, 'duration' => 300], // ~5 hours
                ['origin' => $taiz->id, 'destination' => $sanaa->id, 'duration' => 300],
                ['origin' => $taiz->id, 'destination' => $aden->id, 'duration' => 180], // ~3 hours
                ['origin' => $aden->id, 'destination' => $taiz->id, 'duration' => 180],
                ['origin' => $ibb->id, 'destination' => $sanaa->id, 'duration' => 120],  // ~2 hours
                ['origin' => $sanaa->id, 'destination' => $ibb->id, 'duration' => 120],
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
