import 'dart:convert';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:massar_project/core/constants/api_constants.dart';
import 'package:massar_project/core/services/http_service.dart';

/// مزود لجلب آخر تذكرة نشطة للمستخدم من الباك أند
/// يُستخدم في ActiveTicketCard على الشاشة الرئيسية
/// تم إصلاح: استخدام HttpService بدل http.get المباشر لإرسال Token المصادقة
final activeTicketProvider = FutureProvider<Map<String, dynamic>?>((ref) async {
  final httpService = ref.watch(httpServiceProvider);

  try {
    final response = await httpService.get('${ApiConstants.baseUrl}/user/active-ticket');

    if (response.statusCode == 200) {
      final decoded = json.decode(response.body);
      final booking = decoded['data'];

      if (booking == null) return null;

      // تحويل بيانات الحجز إلى الشكل الذي يتوقعه ActiveTicketCard
      final trip = booking['trip'] ?? {};
      return {
        'booking_code': booking['booking_code'] ?? 'N/A',
        'date': trip['date'] ?? '---',
        'from': trip['fromStation']?['name'] ?? '---',
        'to': trip['toStation']?['name'] ?? '---',
        'duration': trip['durationText'] ?? '---',
        'bus_info':
            '${trip['busName'] ?? 'باص'} الوصول الساعة ${trip['arrivalTime'] ?? '--:--'} في المحطة',
      };
    }

    return null;
  } catch (e) {
    // في حال فشل الاتصال بالسيرفر، نعود بـ null (لا بيانات وهمية)
    return null;
  }
});
