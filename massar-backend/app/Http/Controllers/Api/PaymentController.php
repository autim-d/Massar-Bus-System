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

        $stripeSecret = env('STRIPE_SECRET');
        
        if (empty($stripeSecret)) {
            // وضع التجربة (Sandbox Mode) في حال عدم وجود مفتاح Stripe
            return response()->json([
                'client_secret' => 'pi_mock_secret_' . bin2hex(random_bytes(10)),
                'payment_intent_id' => 'pi_mock_' . bin2hex(random_bytes(10)),
                'message' => 'التطبيق يعمل في وضع التجربة (Sandbox) لعدم وجود مفتاح Stripe.'
            ]);
        }

        Stripe::setApiKey($stripeSecret);

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

        $stripeSecret = env('STRIPE_SECRET');

        // التعامل مع وضع التجربة (Sandbox)
        if (str_starts_with($request->payment_intent_id, 'pi_mock_')) {
            $booking->update([
                'status' => 'paid',
                'purchased_at' => now(),
            ]);

            // إرسال إشعار بالدفع الناجح
            $booking->user->notify(new \App\Notifications\GeneralNotification(
                'تم تأكيد الدفع',
                "تم استلام دفعيتك للحجز رقم {$booking->booking_code} بنجاح. رحلة سعيدة!",
                'payment_confirmed',
                ['booking_id' => $booking->id, 'booking_code' => $booking->booking_code]
            ));

            Payment::create([
                'booking_id' => $booking->id,
                'transaction_id' => $request->payment_intent_id,
                'amount' => $booking->total_amount,
                'payment_method' => 'sandbox',
                'status' => 'completed',
                'paid_at' => now()
            ]);

            return response()->json(['message' => 'Payment confirmed (Sandbox Mode).', 'booking' => $booking]);
        }

        if (empty($stripeSecret)) {
            return response()->json(['error' => 'Stripe key is missing and this is not a mock ID.'], 400);
        }

        Stripe::setApiKey($stripeSecret);

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
