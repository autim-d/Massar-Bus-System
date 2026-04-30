<?php

namespace App\Http\Controllers\Api;

use App\Http\Controllers\Controller;
use Illuminate\Http\Request;
use App\Models\Trip;
use App\Http\Resources\TripResource;
use Carbon\Carbon;

class TripController extends Controller
{
    /**
     * البحث عن الرحلات بناءً على المحطات والتاريخ
     */
    public function search(Request $request)
    {
        // 1. التحقق من المدخلات
        // جعلنا origin و destination اختيارية في حال أراد المستخدم عرض كل الرحلات لتاريخ معين
        $request->validate([
            'origin_station_id'      => 'sometimes|exists:stations,id',
            'destination_station_id' => 'sometimes|exists:stations,id',
            'date'                   => 'required|date',
        ]);

        // تحويل التاريخ القادم من Flutter إلى تنسيق Carbon
        $date = Carbon::parse($request->date)->startOfDay();

        // 2. بناء الاستعلام (Query)
        $query = Trip::with(['route', 'bus', 'route.originStation', 'route.destinationStation'])
            ->whereDate('departure_time', $date)
            ->where('status', 'scheduled');

        // فلترة بناءً على محطة الانطلاق والوصول إذا تم إرسالها
        if ($request->has('origin_station_id') && $request->has('destination_station_id')) {
            $query->whereHas('route', function($q) use ($request) {
                $q->where('origin_station_id', $request->origin_station_id)
                  ->where('destination_station_id', $request->destination_station_id);
            });
        }

        // 3. جلب النتائج وترتيبها حسب وقت الإقلاع
        $trips = $query->orderBy('departure_time', 'asc')->get();

        // 4. إرجاع النتائج عبر الـ Resource
        return TripResource::collection($trips);
    }

    /**
     * دالة إضافية لجلب تفاصيل رحلة معينة (إذا احتجتها مستقبلاً)
     */
    public function show($id)
    {
        $trip = Trip::with(['route', 'bus'])->findOrFail($id);
        return new TripResource($trip);
    }
}