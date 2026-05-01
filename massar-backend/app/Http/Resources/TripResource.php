<?php

namespace App\Http\Resources;

use Illuminate\Http\Request;
use Illuminate\Http\Resources\Json\JsonResource;
use Carbon\Carbon;

class TripResource extends JsonResource
{
    /**
     * تحويل البيانات لتتناسب مع واجهة Flutter (Massar Project)
     *
     * @return array<string, mixed>
     */
    public function toArray(Request $request): array
    {
        // تحويل أوقات الإقلاع والوصول إلى كائنات Carbon للتعامل مع الوقت بسهولة
        $departure = Carbon::parse($this->departure_time);
        $arrival = Carbon::parse($this->arrival_time);

        return [
            // نحول الـ ID إلى String ليتوافق مع Flutter Models
            'id' => (string) $this->id,
            
            // اسم الباص (يتم جلب الحقل الصحيح من علاقة الـ bus)
            'busName' => $this->bus->bus_name ?? 'باص غير محدد',
            
            // السعر (نتأكد أنه Integer لعمليات الحساب في التطبيق)
            'price' => (int) ($this->price ?? 10000), 

            // التواريخ والأوقات بتنسيق مفهوم للواجهة
            'date' => $departure->toDateString(), // YYYY-MM-DD
            'departureTime' => $departure->format('H:i'), // تنسيق 24 ساعة (مثلاً 15:00)
            'arrivalTime' => $arrival->format('h:i A'), // تنسيق 12 ساعة (مثلاً 03:45 PM)
            
            // حساب مدة الرحلة نصياً كما هو مطلوب في واجهة البحث
            'durationText' => 'المدة: ' . $departure->diffInMinutes($arrival) . ' دقيقة',

            // محطات الانطلاق والوصول (نفس أسماء الحقول في LocationModel بـ Flutter)
            'fromStation' => [
                'id' => (string) ($this->route->origin_station_id ?? ''),
                'name' => $this->route->originStation->name ?? 'محطة غير معروفة',
                'description' => 'محطة الانطلاق',
            ],
            'toStation' => [
                'id' => (string) ($this->route->destination_station_id ?? ''),
                'name' => $this->route->destinationStation->name ?? 'محطة غير معروفة',
                'description' => 'محطة الوصول',
            ],

            // حالات إضافية تظهر على الكارت في Flutter
            'isFastest' => $this->is_fastest ?? false,
            'isCheapest' => $this->is_cheapest ?? false,
            'isLadiesOnly' => $this->is_ladies_only ?? false,
            'isMenOnly' => $this->is_men_only ?? false,
            'isMixed' => $this->is_mixed ?? true,
            
            // حالة الرحلة العامة
            'status' => $this->status,
        ];
    }
}