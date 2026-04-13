<?php

namespace App\Http\Controllers\Api;

use App\Http\Controllers\Controller;
use Illuminate\Http\Request;
use App\Models\Booking;
use App\Models\Payment;
use Stripe\Stripe;
use Stripe\PaymentIntent;

class PaymentController extends Controller
{
    public function createIntent(Request $request)
    {
        $request->validate([
            'booking_id' => 'required|exists:bookings,id',
        ]);

        $booking = $request->user()->bookings()->findOrFail($request->booking_id);

        if ($booking->status !== 'pending') {
            return response()->json(['error' => 'Booking is not pending payment.'], 400);
        }

        Stripe::setApiKey(env('STRIPE_SECRET'));

        try {
            $paymentIntent = PaymentIntent::create([
                'amount' => intval($booking->total_amount * 100),
                'currency' => 'sar',
                'metadata' => ['booking_id' => $booking->id],
            ]);

            return response()->json([
                'client_secret' => $paymentIntent->client_secret,
                'payment_intent_id' => $paymentIntent->id,
            ]);
        } catch (\Exception $e) {
            return response()->json(['error' => $e->getMessage()], 500);
        }
    }

    public function confirm(Request $request)
    {
        $request->validate([
            'booking_id' => 'required|exists:bookings,id',
            'payment_intent_id' => 'required|string',
        ]);

        $booking = $request->user()->bookings()->findOrFail($request->booking_id);

        if ($booking->status === 'paid') {
            return response()->json(['message' => 'Already paid.'], 200);
        }

        Stripe::setApiKey(env('STRIPE_SECRET'));

        try {
            $paymentIntent = PaymentIntent::retrieve($request->payment_intent_id);

            if ($paymentIntent->status === 'succeeded') {
                $booking->update([
                    'status' => 'paid',
                    'purchased_at' => now(),
                ]);

                Payment::create([
                    'booking_id' => $booking->id,
                    'transaction_id' => $paymentIntent->id,
                    'amount' => $booking->total_amount,
                    'payment_method' => 'stripe',
                    'status' => 'completed',
                    'paid_at' => now()
                ]);

                return response()->json(['message' => 'Payment confirmed successfully.', 'booking' => $booking]);
            } else {
                return response()->json(['error' => 'Payment not successful.', 'status' => $paymentIntent->status], 400);
            }
        } catch (\Exception $e) {
            return response()->json(['error' => $e->getMessage()], 500);
        }
    }
}
