<?php

namespace App\Http\Resources;

use Illuminate\Http\Request;
use Illuminate\Http\Resources\Json\JsonResource;

class BookingResource extends JsonResource
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
            'booking_code' => $this->booking_code,
            'trip' => new TripResource($this->whenLoaded('trip')),
            'status' => $this->status,
            'passenger_name' => $this->passenger_name,
            'passenger_phone' => $this->passenger_phone,
            'pricing' => [
                'ticket_price' => (float) $this->ticket_price,
                'protection_price' => (float) $this->protection_price,
                'service_fee' => (float) $this->service_fee,
                'total_amount' => (float) $this->total_amount,
            ],
            'purchased_at' => $this->purchased_at,
        ];
    }
}
