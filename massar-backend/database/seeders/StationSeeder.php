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
            ['name' => 'عدن - كريتر', 'city' => 'عدن', 'latitude' => 12.7750, 'longitude' => 45.0350],
            ['name' => 'عدن - المعلا', 'city' => 'عدن', 'latitude' => 12.7900, 'longitude' => 45.0100],
            ['name' => 'عدن - الشيخ عثمان', 'city' => 'عدن', 'latitude' => 12.8200, 'longitude' => 44.9850],
            ['name' => 'عدن - المنصورة', 'city' => 'عدن', 'latitude' => 12.8350, 'longitude' => 44.9700],
            ['name' => 'المكلا - المحطة المركزية', 'city' => 'المكلا', 'latitude' => 14.5373, 'longitude' => 49.1235],
            ['name' => 'فوه - محطة المساكن', 'city' => 'المكلا', 'latitude' => 14.5120, 'longitude' => 49.0800],
            ['name' => 'الشرج - محطة الستين', 'city' => 'المكلا', 'latitude' => 14.5300, 'longitude' => 49.1100],
            ['name' => 'الديس - جولة الديس', 'city' => 'المكلا', 'latitude' => 14.5450, 'longitude' => 49.1400],
            ['name' => 'باعبود - المحطة القديمة', 'city' => 'المكلا', 'latitude' => 14.5400, 'longitude' => 49.1300],
            ['name' => 'المتضررين - محطة الدفاع', 'city' => 'المكلا', 'latitude' => 14.5150, 'longitude' => 49.0900],
            ['name' => 'الشحر - محطة السوق', 'city' => 'الشحر', 'latitude' => 14.7500, 'longitude' => 49.6000],
            ['name' => 'سيئون - المحطة العامة', 'city' => 'سيئون', 'latitude' => 15.9333, 'longitude' => 48.7833],
            ['name' => 'تعز - جولة القصر', 'city' => 'تعز', 'latitude' => 13.5783, 'longitude' => 44.0142],
            ['name' => 'تعز - بير باشا', 'city' => 'تعز', 'latitude' => 13.5600, 'longitude' => 43.9900],
            ['name' => 'تعز - التحرير', 'city' => 'تعز', 'latitude' => 13.5750, 'longitude' => 44.0050],
            ['name' => 'مأرب - المحطة المركزية', 'city' => 'مأرب', 'latitude' => 15.4591, 'longitude' => 45.3233],
        ];

        foreach ($stations as $station) {
            Station::updateOrCreate(['name' => $station['name']], $station);
        }
    }
}
