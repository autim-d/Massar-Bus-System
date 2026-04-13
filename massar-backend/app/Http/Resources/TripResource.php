<?php

namespace App\Http\Resources;

use Illuminate\Http\Request;
use Illuminate\Http\Resources\Json\JsonResource;

class TripResource extends JsonResource
{
    /**
     * Transform the resource into an array.
     *
     * @return array<string, mixed>
     */
    public function toArray(Request $request): array
    {
        return [
            'id' => $this->id,
            'departure_time' => $this->departure_time,
            'arrival_time' => $this->arrival_time,
            'status' => $this->status,
            'route' => [
                'origin_id' => $this->route->origin_station_id ?? null,
                'destination_id' => $this->route->destination_station_id ?? null,
                'duration_minutes' => $this->route->estimated_duration_minutes ?? null,
            ],
            'bus' => [
                'name' => $this->bus->bus_name ?? null,
                'capacity' => $this->bus->capacity ?? null,
            ]
        ];
    }
}
