<?php

namespace App\Http\Controllers\Api;

use App\Http\Controllers\Controller;
use Illuminate\Http\Request;
use App\Models\Booking;
use App\Http\Resources\BookingResource;

class BookingController extends Controller
{
    public function index(Request $request)
    {
        $bookings = $request->user()->bookings()->with('trip.route', 'trip.bus')->get();
        return BookingResource::collection($bookings);
    }

    public function store(Request $request)
    {
        $request->validate([
            'trip_id' => 'required|exists:trips,id',
        ]);

        $basePrice = 50.00;
        $protectionPrice = 10.00;
        $serviceFee = 5.00;
        $total = $basePrice + $protectionPrice + $serviceFee;

        $booking = $request->user()->bookings()->create([
            'trip_id' => $request->trip_id,
            'booking_code' => 'MAS-' . time() . rand(100, 999),
            'ticket_price' => $basePrice,
            'protection_price' => $protectionPrice,
            'service_fee' => $serviceFee,
            'total_amount' => $total,
            'status' => 'pending',
            'purchased_at' => null,
        ]);

        return new BookingResource($booking->load('trip.route', 'trip.bus'));
    }
}
