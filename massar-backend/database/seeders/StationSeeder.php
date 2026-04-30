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
            ['name' => 'صنعاء - المحطة الرئيسية', 'city' => 'صنعاء', 'latitude' => 15.3694, 'longitude' => 44.1910],
            ['name' => 'عدن - المحطة المركزية', 'city' => 'عدن', 'latitude' => 12.7855, 'longitude' => 45.0186],
            ['name' => 'تعز - المحطة الغربية', 'city' => 'تعز', 'latitude' => 13.5794, 'longitude' => 44.0116],
            ['name' => 'إب - محطة الجبل', 'city' => 'إب', 'latitude' => 13.9743, 'longitude' => 44.1730],
        ];

        foreach ($stations as $station) {
            Station::updateOrCreate(['name' => $station['name']], $station);
        }
    }
}
