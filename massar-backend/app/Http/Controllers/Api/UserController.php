<?php

namespace App\Http\Controllers\Api;

use App\Http\Controllers\Controller;
use Illuminate\Http\Request;
use App\Models\Booking;

class UserController extends Controller
{
    /**
     * جلب بيانات الملف الشخصي
     */
    public function profile(Request $request)
    {
        $user = $request->user();
        // نرسل البيانات بحقول متسقة مع UserModel.fromJson في Flutter
        return response()->json([
            'success' => true,
            'user' => [
                'first_name' => $user->first_name ?? '',
                'last_name' => $user->last_name ?? '',
                'email' => $user->email ?? '',
                'phone_number' => $user->phone_number ?? '',
                'avatar_url' => $user->avatar_url ?? '',
                'identity_number' => $user->identity_number ?? '',
                'nationality' => $user->nationality ?? '',
                'unread_notifications_count' => $user->unreadNotificationsCount ?? 0,
            ]
        ]);
    }


    public function getDashboardData(Request $request)
    {
        $user = $request->user();

        // جلب أحدث تذكرة نشطة (مؤكدة ولم تنتهِ بعد)
        $activeBooking = Booking::where('user_id', $user->id)
            ->whereIn('status', ['confirmed', 'pending'])
            ->with(['trip.bus', 'trip.route.originStation', 'trip.route.destinationStation'])
            ->latest()
            ->first();

        $activeTicketData = null;

        if ($activeBooking && $activeBooking->trip) {
            $trip = $activeBooking->trip;
            $route = $trip->route;
            $bus = $trip->bus;

            $departureTime = \Carbon\Carbon::parse($trip->departure_time);
            $arrivalTime = \Carbon\Carbon::parse($trip->arrival_time);

            $activeTicketData = [
                'booking_code' => $activeBooking->booking_code ?? 'N/A',
                'date' => $departureTime->format('D, d M Y'),
                'from' => $route && $route->originStation ? $route->originStation->name : '---',
                'to' => $route && $route->destinationStation ? $route->destinationStation->name : '---',
                'duration' => $departureTime->diffInMinutes($arrivalTime) . ' دقيقة',
                'bus_info' => ($bus ? $bus->bus_name : 'باص مسار') . "  الوصول الساعة " . $arrivalTime->format('H:i') . " في المحطة",
            ];
        }

        return response()->json([
            'status' => 'success',
            'user' => [
                'first_name' => $user->first_name,
                'last_name' => $user->last_name ?? '',
                'email' => $user->email ?? '',
                'phone_number' => $user->phone_number ?? '',
                'avatar_url' => $user->avatar_url ?? '',
                'identity_number' => $user->identity_number ?? '',
                'nationality' => $user->nationality ?? '',
                'unread_notifications_count' => $user->unreadNotificationsCount ?? 0,
            ],
            'activeTicket' => $activeTicketData,
        ]);
    }

    /**
     * تحديث بيانات الملف الشخصي
     */
    public function update(Request $request)
    {
        $user = $request->user();

        $request->validate([
            'first_name' => 'required|string|max:255',
            'last_name' => 'nullable|string|max:255',
            'email' => 'required|email|unique:users,email,' . $user->id,
            'phone_number' => 'nullable|string',
            'identity_number' => 'nullable|string',
            'nationality' => 'nullable|string',
        ]);

        // تحديث البيانات في قاعدة البيانات
        $user->update([
            'first_name' => $request->first_name,
            'last_name' => $request->last_name,
            'email' => $request->email,
            'phone_number' => $request->phone_number,
            'identity_number' => $request->identity_number,
            'nationality' => $request->nationality,
        ]);

        return response()->json([
            'success' => true, // نستخدم success ليتناسب مع فلاتر
            'message' => 'تم تحديث الملف الشخصي بنجاح',
            'user' => [
                'first_name' => $user->first_name,
                'last_name' => $user->last_name ?? '',
                'email' => $user->email ?? '',
                'phone_number' => $user->phone_number ?? '',
                'avatar_url' => $user->avatar_url ?? '',
                'identity_number' => $user->identity_number ?? '',
                'nationality' => $user->nationality ?? '',
            ]
        ]);
    }

    /**
     * تحديث الصورة الشخصية
     */
    public function updateAvatar(Request $request)
    {
        $request->validate([
            'avatar' => 'required|image|mimes:jpeg,png,jpg,gif|max:2048',
        ]);

        $user = $request->user();

        if ($request->hasFile('avatar')) {
            $path = $request->file('avatar')->store('avatars', 'public');
            
            // Generate full URL
            $url = url('storage/' . $path);
            
            $user->update(['avatar_url' => $url]);
            
            return response()->json([
                'success' => true,
                'message' => 'تم تحديث الصورة بنجاح',
                'user' => $user->fresh()
            ]);
        }
        
        return response()->json(['success' => false, 'message' => 'لم يتم رفع صورة'], 400);
    }
}
