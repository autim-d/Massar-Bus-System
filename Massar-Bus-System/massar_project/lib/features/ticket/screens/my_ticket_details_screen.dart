import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:massar_project/features/ticket/models/checkout_session_model.dart';
import '../widgets/components/qr_code_card.dart';
import '../widgets/components/price_breakdown_column.dart';
import 'package:massar_project/features/home/widgets/components/vertical_route_timeline.dart';
import 'package:massar_project/features/home/widgets/components/map_placeholder_card.dart';
import '../../../core/navigation/main_layout.dart';

class MyTicketDetailsScreen extends StatelessWidget {
  final CheckoutSessionModel session;

  const MyTicketDetailsScreen({super.key, required this.session});

  String _formatArabicDate(DateTime date) {
    const months = ['يناير', 'فبراير', 'مارس', 'أبريل', 'مايو', 'يونيو', 'يوليو', 'أغسطس', 'سبتمبر', 'أكتوبر', 'نوفمبر', 'ديسمبر'];
    const weekdays = ['الاثنين', 'الثلاثاء', 'الأربعاء', 'الخميس', 'الجمعة', 'السبت', 'الأحد'];
    return '${weekdays[date.weekday - 1]} , ${date.day} ${months[date.month - 1]} ${date.year}';
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    // For demo purposes, we'll hardcode some of the route data since it's an E-Ticket view.
    final String dateString = _formatArabicDate(session.transactionDate);

    return SafeArea(
      child: Directionality(
        textDirection: TextDirection.rtl,
        child: PopScope(
          canPop: false,
          onPopInvokedWithResult: (didPop, result) {
            if (didPop) return;
            Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (context) => const MainLayout()),
              (route) => false,
            );
          },
          child: Scaffold(
            backgroundColor: theme.scaffoldBackgroundColor,
            appBar: AppBar(
              backgroundColor: theme.appBarTheme.backgroundColor,
              elevation: 0,
              leading: IconButton(
                icon: Icon(Icons.arrow_back_ios, color: theme.iconTheme.color),
                onPressed: () {
                  Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(builder: (context) => const MainLayout()),
                    (route) => false,
                  );
                },
              ),
              title: Text(
                "تفاصيل التذكرة",
                style: TextStyle(
                    color: theme.textTheme.titleLarge?.color,
                    fontSize: 18,
                    fontWeight: FontWeight.bold),
              ),
              centerTitle: true,
            ),
            body: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    // 1. QR Code Section
                    Center(child: QRCodeCard(orderId: session.orderId)),

                    const SizedBox(height: 20),
                    Divider(
                        thickness: 2,
                        color: theme.dividerColor),
                    const SizedBox(height: 20),

                    // 2. Route Top Summary
                    Text(
                      dateString,
                      style: TextStyle(
                          fontWeight: FontWeight.w800,
                          fontSize: 16,
                          color: theme.textTheme.titleLarge?.color),
                    ),
                    const SizedBox(height: 16),
                    Row(
                      children: [
                        const Icon(Icons.place, color: Colors.green, size: 20),
                        const SizedBox(width: 8),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("موقف",
                                style: TextStyle(
                                    color: theme.textTheme.bodySmall?.color,
                                    fontSize: 10)),
                            Text("K. Bali",
                                style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold,
                                    color: theme.textTheme.bodyLarge?.color)),
                          ],
                        ),
                        const Spacer(),
                        Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 8, vertical: 4),
                          decoration: BoxDecoration(
                            color: isDark ? Colors.white.withOpacity(0.05) : const Color(0xffF9FAFB),
                            borderRadius: BorderRadius.circular(20),
                            border: Border.all(color: theme.dividerColor),
                          ),
                          child: Text("الوقت المقدر: 30 دقيقة",
                              style: TextStyle(
                                  fontSize: 10,
                                  color: theme.textTheme.bodySmall?.color)),
                        ),
                        const Spacer(),
                        const Icon(Icons.place,
                            color: Color(0xFFE85C0D), size: 20),
                        const SizedBox(width: 8),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("موقف",
                                style: TextStyle(
                                    color: theme.textTheme.bodySmall?.color,
                                    fontSize: 10)),
                            Text("Senen",
                                style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold,
                                    color: theme.textTheme.bodyLarge?.color)),
                          ],
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    Row(
                      children: [
                        Icon(Icons.directions_bus,
                            color: theme.textTheme.bodySmall?.color, size: 20),
                        const SizedBox(width: 8),
                        Text("باص 01",
                            style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w600,
                                color: theme.textTheme.bodyLarge?.color)),
                        const SizedBox(width: 16),
                        Text("الوصول الساعة 15:30 إلى موقف كامبونج بالي",
                            style: TextStyle(
                                fontSize: 12,
                                color: theme.textTheme.bodySmall?.color)),
                      ],
                    ),

                    const SizedBox(height: 24),

                    // 3. Map Placeholder
                    Text("تتبع الحافلة",
                        style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: theme.textTheme.titleLarge?.color)),
                    const SizedBox(height: 10),
                    const MapPlaceholderCard(),

                    const SizedBox(height: 24),

                    // 4. Timeline
                    Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        border: Border.all(color: theme.dividerColor),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text("الرحلة",
                                  style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                      color: theme.textTheme.titleLarge?.color)),
                              Icon(Icons.keyboard_arrow_down,
                                  color: theme.textTheme.bodySmall?.color),
                            ],
                          ),
                          const SizedBox(height: 20),
                          VerticalRouteTimeline(
                            fromStation: 'موقف محطة كامبونج بالي',
                            toStation: 'موقف محطة سنين',
                            dateString: dateString.split(' ').first,
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 24),

                    // 5. Customer Info
                    Text("اسم العميل",
                        style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: theme.textTheme.titleLarge?.color)),
                    const SizedBox(height: 10),
                    Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        border: Border.all(color: theme.dividerColor),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text("عدنان البيني",
                              style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: theme.textTheme.bodyLarge?.color)),
                          const SizedBox(height: 4),
                          Text("adnanabyby@gmail.com",
                              style: TextStyle(
                                  fontSize: 14,
                                  color: theme.textTheme.bodySmall?.color)),
                          const SizedBox(height: 4),
                          Text("+967774393235",
                              style: TextStyle(
                                  fontSize: 14,
                                  color: theme.textTheme.bodySmall?.color)),
                        ],
                      ),
                    ),

                    const SizedBox(height: 24),

                    // 6. Protection Promo
                    Container(
                      decoration: BoxDecoration(
                        border: Border.all(
                            color: isDark
                                ? Colors.orange.shade800
                                : Colors.orange.shade300),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Column(
                        children: [
                          Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 16, vertical: 8),
                            decoration: BoxDecoration(
                              color: Colors.amber.shade400,
                              borderRadius: const BorderRadius.vertical(
                                  top: Radius.circular(11)),
                            ),
                            child: const Row(
                              children: [
                                Icon(Icons.shield, color: Colors.white),
                                SizedBox(width: 8),
                                Text("حمايتك",
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold)),
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Row(
                              children: [
                                Icon(Icons.verified_user_outlined,
                                    color: theme.textTheme.bodyLarge?.color),
                                const SizedBox(width: 12),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text("رضا العميل",
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              color: theme.textTheme.bodyLarge?.color)),
                                      const SizedBox(height: 4),
                                      Text(
                                        "احصل على استرداد يصل إلى 100% في حال واجهت تجربة سيئة خلال رحلتك.",
                                        style: TextStyle(
                                            fontSize: 11,
                                            color: theme.textTheme.bodySmall?.color),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 24),

                    // 7. Price Breakdown
                    const PriceBreakdownColumn(
                      ticketPrice: 10000,
                      protectionFee: 10000,
                      serviceFee: 5000,
                    ),

                    const SizedBox(height: 40),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
