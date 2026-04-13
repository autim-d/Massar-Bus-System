<?php

namespace Database\Seeders;

use Illuminate\Database\Console\Seeds\WithoutModelEvents;
use Illuminate\Database\Seeder;
use App\Models\Station;

class StationSeeder extends Seeder
{
    public function run(): void
    {
        $stations = [
            ['name' => 'Riyadh Main Station', 'city' => 'Riyadh', 'latitude' => 24.7136, 'longitude' => 46.6753],
            ['name' => 'Jeddah Central Station', 'city' => 'Jeddah', 'latitude' => 21.4858, 'longitude' => 39.1925],
            ['name' => 'Dammam Eastern Station', 'city' => 'Dammam', 'latitude' => 26.4207, 'longitude' => 50.0888],
            ['name' => 'Makkah Holy Station', 'city' => 'Makkah', 'latitude' => 21.3891, 'longitude' => 39.8579],
        ];

        foreach ($stations as $station) {
            Station::updateOrCreate(['name' => $station['name']], $station);
        }
    }
}
