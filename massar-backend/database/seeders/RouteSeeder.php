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
        $stations = Station::all();
        $cities = $stations->pluck('city')->unique();

        // 1. Create routes between all stations in the same city (Neighborhoods)
        foreach ($cities as $city) {
            $cityStations = $stations->where('city', $city);
            foreach ($cityStations as $origin) {
                foreach ($cityStations as $destination) {
                    if ($origin->id !== $destination->id) {
                        Route::firstOrCreate(
                            ['origin_station_id' => $origin->id, 'destination_station_id' => $destination->id],
                            ['estimated_duration_minutes' => 15] // Default neighborhood duration
                        );
                    }
                }
            }
        }

        // 2. Inter-city routes (Major connections)
        $majorConnections = [
            ['from' => 'صنعاء - المحطة الرئيسية', 'to' => 'عدن - المحطة المركزية', 'duration' => 480],
            ['from' => 'عدن - المحطة المركزية', 'to' => 'صنعاء - المحطة الرئيسية', 'duration' => 480],
            ['from' => 'صنعاء - المحطة الرئيسية', 'to' => 'تعز - جولة القصر', 'duration' => 300],
            ['from' => 'تعز - جولة القصر', 'to' => 'صنعاء - المحطة الرئيسية', 'duration' => 300],
            ['from' => 'صنعاء - المحطة الرئيسية', 'to' => 'مأرب - المحطة المركزية', 'duration' => 240],
            ['from' => 'مأرب - المحطة المركزية', 'to' => 'صنعاء - المحطة الرئيسية', 'duration' => 240],
            ['from' => 'عدن - المحطة المركزية', 'to' => 'المكلا - المحطة المركزية', 'duration' => 600],
            ['from' => 'المكلا - المحطة المركزية', 'to' => 'عدن - المحطة المركزية', 'duration' => 600],
            ['from' => 'المكلا - المحطة المركزية', 'to' => 'سيئون - المحطة العامة', 'duration' => 360],
            ['from' => 'سيئون - المحطة العامة', 'to' => 'المكلا - المحطة المركزية', 'duration' => 360],
            ['from' => 'المكلا - المحطة المركزية', 'to' => 'الشحر - محطة السوق', 'duration' => 60],
            ['from' => 'عدن - المحطة المركزية', 'to' => 'تعز - جولة القصر', 'duration' => 180],
            ['from' => 'تعز - جولة القصر', 'to' => 'عدن - المحطة المركزية', 'duration' => 180],
            ['from' => 'الشحر - محطة السوق', 'to' => 'المكلا - المحطة المركزية', 'duration' => 60],
        ];

        $stationsByName = $stations->keyBy('name');
        foreach ($majorConnections as $r) {
            $origin = $stationsByName->get($r['from']);
            $dest = $stationsByName->get($r['to']);

            if ($origin && $dest) {
                Route::firstOrCreate(
                    ['origin_station_id' => $origin->id, 'destination_station_id' => $dest->id],
                    ['estimated_duration_minutes' => $r['duration']]
                );
            }
        }
    }
}
