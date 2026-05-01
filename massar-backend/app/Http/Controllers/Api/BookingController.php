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
            'passenger_name' => 'nullable|string|max:255',
            'passenger_phone' => 'nullable|string|max:20',
        ]);

        $trip = \App\Models\Trip::findOrFail($request->trip_id);
        
        $basePrice = $trip->price;
        $protectionPrice = 200.00; // Fixed for now, but could be dynamic
        $serviceFee = 300.00;    // Fixed for now, but could be dynamic
        $total = $basePrice + $protectionPrice + $serviceFee;

        $booking = $request->user()->bookings()->create([
            'trip_id' => $request->trip_id,
            'booking_code' => 'MAS-' . strtoupper(bin2hex(random_bytes(4))), // More professional code
            'ticket_price' => $basePrice,
            'protection_price' => $protectionPrice,
            'service_fee' => $serviceFee,
            'total_amount' => $total,
            'status' => 'pending',
            'passenger_name' => $request->passenger_name,
            'passenger_phone' => $request->passenger_phone,
            'purchased_at' => null,
        ]);

        // إرسال إشعار للمستخدم
        $request->user()->notify(new \App\Notifications\GeneralNotification(
            'حجز جديد',
            "تم إنشاء حجزك بنجاح للرحلة المتجهة إلى {$trip->route->destinationStation->name}. يرجى إتمام الدفع.",
            'booking_created',
            ['booking_id' => $booking->id, 'booking_code' => $booking->booking_code]
        ));

        return new BookingResource($booking->load('trip.route', 'trip.bus'));
    }

    /**
     * جلب آخر تذكرة نشطة للمستخدم
     */
    public function getActiveTicket(Request $request)
    {
        $booking = $request->user()->bookings()
            ->whereIn('status', ['confirmed', 'pending'])
            ->with(['trip.bus', 'trip.route.originStation', 'trip.route.destinationStation'])
            ->latest()
            ->first();

        if (!$booking) {
            return response()->json(['data' => null]);
        }

        return new BookingResource($booking);
    }
}
