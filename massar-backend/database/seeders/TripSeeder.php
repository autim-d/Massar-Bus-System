<?php

namespace Database\Seeders;

use Illuminate\Database\Console\Seeds\WithoutModelEvents;
use Illuminate\Database\Seeder;
use App\Models\Trip;
use App\Models\Route;
use App\Models\Bus;
use Carbon\Carbon;

class TripSeeder extends Seeder
{
    public function run(): void
    {
        $routes = Route::all();
        $buses = Bus::all();

        if ($routes->isEmpty() || $buses->isEmpty()) {
            return;
        }

        for ($i = 0; $i < 7; $i++) {
            $date = Carbon::now()->addDays($i)->setTime(8, 0, 0);

            foreach ($routes as $index => $route) {
                $bus = $buses[$index % $buses->count()];
                
                $departure = $date->copy()->addHours($index);
                $arrival = $departure->copy()->addMinutes($route->estimated_duration_minutes);

                Trip::firstOrCreate(
                    [
                        'route_id' => $route->id,
                        'bus_id' => $bus->id,
                        'departure_time' => $departure,
                    ],
                    [
                        'arrival_time' => $arrival,
                        'status' => 'scheduled'
                    ]
                );
            }
        }
    }
}
