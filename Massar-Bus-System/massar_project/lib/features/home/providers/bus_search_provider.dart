import 'dart:convert';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:massar_project/core/constants/api_constants.dart';
import 'package:massar_project/core/services/http_service.dart';
import '../models/bus_ticket_model.dart';
import '../models/bus_search_criteria.dart';

// تم تعديل المزود ليستخدم HttpService (يرسل Token تلقائياً) بدل http.get المباشر
final busSearchProvider = FutureProvider.family<List<BusTicketModel>, BusSearchCriteria>((
  ref,
  criteria,
) async {
  final httpService = ref.watch(httpServiceProvider);

  // 1. تجهيز الرابط (URL) مع فلترة التاريخ والمحطات
  final String formattedDate =
      "${criteria.date.year}-${criteria.date.month.toString().padLeft(2, '0')}-${criteria.date.day.toString().padLeft(2, '0')}";

  final queryParams = <String>[
    'date=$formattedDate',
    // دعم البحث بـ station ID إذا كان متاحاً، أو بالاسم النصي
    if (criteria.fromId != null && criteria.fromId!.isNotEmpty)
      'origin_station_id=${criteria.fromId}',
    if (criteria.toId != null && criteria.toId!.isNotEmpty)
      'destination_station_id=${criteria.toId}',
  ];

  final url = '${ApiConstants.baseUrl}/trips/search?${queryParams.join('&')}';

  try {
    // 2. جلب البيانات الحقيقية من الباك أند (مع Token للمسارات المحمية)
    final response = await httpService.get(url);

    if (response.statusCode == 200) {
      final decoded = json.decode(response.body);
      // Laravel Resource::collection يغلف النتائج داخل مفتاح 'data'
      final List data = decoded is List ? decoded : decoded['data'] ?? [];
      return data.map((json) => BusTicketModel.fromJson(json)).toList();
    }

    throw Exception('فشل في جلب البيانات: ${response.statusCode}');
  } catch (e) {
    throw Exception('فشل الاتصال بالخادم أو لا توجد بيانات متاحة.');
  }
});

