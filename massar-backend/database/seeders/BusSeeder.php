<?php

namespace Database\Seeders;

use Illuminate\Database\Console\Seeds\WithoutModelEvents;
use Illuminate\Database\Seeder;
use App\Models\Bus;

class BusSeeder extends Seeder
{
    public function run(): void
    {
        for ($i = 1; $i <= 5; $i++) {
            Bus::updateOrCreate(
                ['bus_name' => "BUS-0$i"],
                [
                    'plate_number' => "KSA-123$i",
                    'capacity' => 50,
                    'status' => 'active'
                ]
            );
        }
    }
}
