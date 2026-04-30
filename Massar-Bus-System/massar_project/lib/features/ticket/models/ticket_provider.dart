import 'package:flutter_riverpod/legacy.dart';
import 'ticket_model.dart';

/// مزود التذكرة الحالية - يتم تحديثه عند إتمام الحجز بالبيانات الحقيقية
/// تم إصلاح: تحويل من Provider ببيانات وهمية إلى StateProvider قابل للتحديث
final ticketProvider = StateProvider<TicketModel?>((ref) {
  return null; // يبدأ فارغاً ويتم تعبئته عند الحجز الفعلي
});
