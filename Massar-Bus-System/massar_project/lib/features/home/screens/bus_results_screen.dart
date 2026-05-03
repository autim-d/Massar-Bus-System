import 'package:massar_project/core/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:massar_project/features/home/widgets/components/date_price_selector_item.dart';
import '../providers/bus_search_provider.dart';
import '../widgets/components/bus_result_card.dart';
import '../models/bus_search_criteria.dart';

class BusResultsScreen extends ConsumerStatefulWidget {
  final BusSearchCriteria? criteria;

  const BusResultsScreen({super.key, this.criteria});

  @override
  ConsumerState<BusResultsScreen> createState() => _BusResultsScreenState();
}

class _BusResultsScreenState extends ConsumerState<BusResultsScreen> {
  late BusSearchCriteria searchCriteria;

  @override
  void initState() {
    super.initState();
    searchCriteria =
        widget.criteria ??
        BusSearchCriteria(from: '', to: '', date: DateTime.now());
  }

  @override
  Widget build(BuildContext context) {
    
    

    // تم التعديل هنا: تمرير criteria إلى الـ Provider لجلب بيانات التاريخ المحدد
    final ticketsAsync = ref.watch(busSearchProvider(searchCriteria));

    return Directionality(
      textDirection: TextDirection.rtl, // تغيير الاتجاه للعربية
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          leading: IconButton(
            icon: const Icon(Icons.close),
            onPressed: () => context.pop(),
          ),
          title: const Text(
            'نتائج البحث',
            style: TextStyle(fontFamily: 'air', fontSize: 16),
          ),
        ),
        body: Column(
          children: [
            // شريط اختيار التاريخ
            Container(
              color: Colors.white,
              height: 80,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: 14, // عرض أسبوعين
                itemBuilder: (context, index) {
                  final date = DateTime.now().add(Duration(days: index));
                  return DatePriceSelectorItem(
                    date: date,
                    price: 2500, // يمكن جلب السعر الأدنى من الباك أند لاحقاً
                    isSelected:
                        date.day == searchCriteria.date.day &&
                        date.month == searchCriteria.date.month &&
                        date.year == searchCriteria.date.year,
                    onTap: () {
                      setState(() {
                        searchCriteria = BusSearchCriteria(
                          from: searchCriteria.from,
                          to: searchCriteria.to,
                          fromId: searchCriteria.fromId,
                          toId: searchCriteria.toId,
                          date: date,
                          passengerName: searchCriteria.passengerName,
                          passengerPhone: searchCriteria.passengerPhone,
                        );
                      });
                      // تم التعديل هنا: تحديث المزود بالتاريخ الجديد
                      ref.invalidate(busSearchProvider(searchCriteria));
                    },
                  );
                },
              ),
            ),

            // عرض نتائج الحافلات من الباك أند
            Expanded(
              child: ticketsAsync.when(
                data: (tickets) {
                  if (tickets.isEmpty) {
                    return _buildEmptyState();
                  }
                  return ListView.builder(
                    padding: const EdgeInsets.all(16),
                    itemCount: tickets.length,
                    itemBuilder: (context, index) {
                      return BusResultCard(
                        ticket: tickets[index],
                        passengerName: searchCriteria.passengerName,
                        passengerPhone: searchCriteria.passengerPhone,
                      );
                    },
                  );
                },
                // حالة التحميل (Loading)
                loading: () => const Center(
                  child: CircularProgressIndicator(color: AppColors.mainButton),
                ),
                // حالة الخطأ (Error)
                error: (error, stack) => Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(
                        Icons.error_outline,
                        size: 48,
                        color: Colors.red,
                      ),
                      const SizedBox(height: 16),
                      Text(
                        'حدث خطأ أثناء جلب الرحلات',
                        style: TextStyle(color: Colors.grey.shade600),
                      ),
                      TextButton(
                        onPressed: () =>
                            ref.invalidate(busSearchProvider(searchCriteria)),
                        child: const Text('إعادة المحاولة'),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.directions_bus_filled_outlined,
            size: 64,
            color: Colors.grey.shade300,
          ),
          const SizedBox(height: 16),
          const Text(
            'لا توجد رحلات متاحة في هذا التاريخ',
            style: TextStyle(fontFamily: 'air'),
          ),
        ],
      ),
    );
  }
}






