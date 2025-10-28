import 'package:flutter/material.dart';

class DetailTicketPage extends StatelessWidget {
  const DetailTicketPage({super.key});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white, // Keep white
        elevation: 0, // No shadow
        surfaceTintColor:
            Colors.white, // Prevent Material3 overlay turning grey
        scrolledUnderElevation: 0, // Prevent color change when scrolled
        titleSpacing: 0,
        centerTitle: true,
        title: Padding(
          padding: const EdgeInsets.only(right: 18),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            textDirection: TextDirection.rtl,
            children: [
              Image.asset('assets/icons/back.png', height: 28, width: 22),
              const SizedBox(width: 8),
              const Text(
                'تفاصيل التذكرة',
                style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),
            ],
          ),
        ),
      ),

      body: SingleChildScrollView(
        child: Column(
          children: [
            // ---------- NARROW CENTERED PART ----------
            Center(
              child: Container(
                width: screenWidth * 0.9,
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Align(
                      alignment: Alignment.centerRight,
                      child: Text(
                        'تذكرتك الالكترونية',
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    Center(
                      child: Image.asset(
                        'assets/images/qr.png',
                        width: 200,
                        height: 200,
                      ),
                    ),
                    const SizedBox(height: 4),
                    const Center(
                      child: Text(
                        'كود الحجز',
                        style: TextStyle(color: Colors.grey, fontSize: 16),
                      ),
                    ),
                    const SizedBox(height: 4),
                    const Center(
                      child: Text(
                        'BUS01150224',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    const SizedBox(height: 15),
                    const Center(
                      child: Text(
                        'قم بمسح الرمز الشريطي أو إدخال رمز الحجز عند ركوب الحافلة.',
                        style: TextStyle(
                          color: Color.fromARGB(255, 170, 165, 165),
                          fontSize: 13,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    const SizedBox(height: 20),
                    Container(height: 8, color: Colors.grey[300]),
                    const SizedBox(height: 20),
                    const Align(
                      alignment: Alignment.centerRight,
                      child: Text(
                        'الاثنين، 19 فبراير 2024',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.black87,
                        ),
                      ),
                    ),
                    const SizedBox(height: 12),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Container(
                          width: 60,
                          height: 28,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            color: Colors.orange,
                            borderRadius: BorderRadius.circular(6),
                          ),
                          child: const Text(
                            'الأسرع',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                        const SizedBox(width: 10),
                        Container(
                          width: 44,
                          height: 28,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            color: const Color(0xFFF4F5F6),
                            borderRadius: BorderRadius.circular(6),
                            border: Border.all(color: Colors.grey, width: 0.5),
                          ),
                          child: const Text(
                            'مزيج',
                            style: TextStyle(
                              color: Colors.black87,
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                  ],
                ),
              ),
            ),

            // ---------- FULL-WIDTH ROUTE SECTION ----------
            Container(
              width: double.infinity,
              color: Colors.white,
              padding: const EdgeInsets.symmetric(
                horizontal: 18.0,
                vertical: 12.0,
              ),
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 12,
                ),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Row(
                      children: [
                        Container(
                          width: 25,
                          height: 25,
                          padding: const EdgeInsets.all(6),
                          decoration: BoxDecoration(
                            color: Colors.green,
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Image.asset(
                            'assets/images/location.png',
                            width: 22,
                            height: 26,
                            fit: BoxFit.contain,
                          ),
                        ),
                        const SizedBox(width: 6),
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 12,
                            vertical: 6,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: const [
                              Text(
                                'موقف',
                                style: TextStyle(
                                  fontSize: 10,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.grey,
                                ),
                              ),
                              SizedBox(height: 2),
                              Text(
                                'بالي',
                                style: TextStyle(
                                  fontSize: 11,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 10,
                      ),
                      decoration: BoxDecoration(
                        color: const Color.fromARGB(255, 236, 236, 236),
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(color: Colors.grey),
                      ),
                      child: const Text(
                        'الوقت المقدر : 30 دقيقة',
                        style: TextStyle(
                          fontSize: 12,
                          color: Color.fromARGB(221, 54, 45, 45),
                          fontWeight: FontWeight.w600,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    Row(
                      children: [
                        Image.asset(
                          'assets/images/Destination.png',
                          width: 22,
                          height: 26,
                          fit: BoxFit.contain,
                        ),
                        const SizedBox(width: 6),
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 12,
                            vertical: 6,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: const [
                              Text(
                                'موقف',
                                style: TextStyle(
                                  fontSize: 10,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.grey,
                                ),
                              ),
                              SizedBox(height: 2),
                              Text(
                                'عدن',
                                style: TextStyle(
                                  fontSize: 10,
                                  color: Colors.black,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),

            // ---------- REST OF PAGE ----------
            Center(
              child: Container(
                width: screenWidth * 0.9,
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Flexible(
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 8,
                              vertical: 4,
                            ),
                            child: const Text(
                              'الوصول الساعة 15:30 الى موقف كامبونج بالي ',
                              style: TextStyle(
                                fontSize: 13,
                                color: Colors.black87,
                              ),
                              textAlign: TextAlign.right,
                            ),
                          ),
                        ),
                        const SizedBox(width: 10),
                        const Text(
                          'باص 01',
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(width: 10),
                        Image.asset(
                          'assets/images/bus.png',
                          width: 27,
                          height: 27,
                          fit: BoxFit.contain,
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                    Container(height: 8, color: Colors.grey[300]),
                    const SizedBox(height: 20),
                    const Align(
                      alignment: Alignment.centerRight,
                      child: Text(
                        'تتبع الحافلة',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    const SizedBox(height: 12),
                    LayoutBuilder(
                      builder: (context, constraints) {
                        double imageHeight = constraints.maxWidth * 0.35;
                        return Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(18),
                            border: Border.all(color: Colors.grey, width: 0.5),
                          ),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(16),
                            child: Image.asset(
                              'assets/images/maps.png',
                              width: double.infinity,
                              height: imageHeight,
                              fit: BoxFit.cover,
                            ),
                          ),
                        );
                      },
                    ),
                    const SizedBox(height: 20),
                    Container(height: 8, color: Colors.grey[300]),
                    const SizedBox(height: 20),

                    // -------- تفاصيل الرحلة --------
                    Stack(
                      children: [
                        Container(
                          width: double.infinity,
                          padding: const EdgeInsets.all(16),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(16),
                            border: Border.all(color: Colors.grey, width: 0.5),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              const Text(
                                'الرحلة',
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(height: 12),
                              _buildStep(
                                title: 'موقفك',
                                subtitle: 'المشي',
                                time: 'الوقت المقدر: 10 دقائق',
                                imagePath: 'assets/images/location.png',
                                backgroundColor: Colors.green,
                                isLast: false,
                              ),
                              _buildStep(
                                title: 'موقف محطة كامبونج بالي',
                                subtitle: 'باصي',
                                time: 'الوقت المقدر: 30 دقيقة (مباشرة)',
                                imagePath: 'assets/images/bus.png',
                                backgroundColor: Colors.green,
                                isLast: false,
                              ),
                              _buildStep(
                                title: 'موقف محطة شنن',
                                subtitle: 'وسط جاكرتا',
                                imagePath: 'assets/images/destination.png',

                                isLast: true,
                              ),
                            ],
                          ),
                        ),
                        Positioned(
                          top: 20,
                          left: 30,
                          child: Image.asset(
                            'assets/icons/down.png',
                            width: 20,
                            height: 15,
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 20),

                    // -------- بيانات المستخدم --------
                    const Align(
                      alignment: Alignment.centerRight,
                      child: Text(
                        'اسم العميل',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    const SizedBox(height: 12),
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.black54),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: const Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text('عدنان البيتي'),
                          Text('dnanalbyty8@gmail.com'),
                          Text('+967774393235'),
                        ],
                      ),
                    ),

                    const SizedBox(height: 20),
                    Container(height: 8, color: Colors.grey[300]),
                    const SizedBox(height: 20),

                    Container(
                      width: double.infinity,
                      margin: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 8,
                      ),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(
                          color: const Color(0xFFFF9C1A),
                          width: 2,
                        ),
                        boxShadow: [
                          BoxShadow(
                            // ignore: deprecated_member_use
                            color: Colors.black.withOpacity(0.05),
                            blurRadius: 4,
                            offset: const Offset(0, 2),
                          ),
                        ],
                        color: Colors.white,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 12,
                              vertical: 8,
                            ),
                            decoration: const BoxDecoration(
                              gradient: LinearGradient(
                                colors: [Color(0xFFFFB84D), Color(0xFFFF9C1A)],
                                begin: Alignment.centerRight,
                                end: Alignment.centerLeft,
                              ),
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(10),
                                topRight: Radius.circular(10),
                              ),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              textDirection: TextDirection.rtl,
                              children: [
                                const Text(
                                  'حمايتك',
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Stack(
                                  clipBehavior: Clip.none,
                                  children: [
                                    Container(
                                      width: 40,
                                      height: 40,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      child: Padding(
                                        padding: const EdgeInsets.all(0),
                                        child: Image.asset(
                                          'assets/images/LovePlus.png',
                                          fit: BoxFit.contain,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 16,
                              vertical: 10,
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  textDirection: TextDirection.ltr,
                                  children: [
                                    const Text(
                                      'رضا العميل',
                                      style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.bold,
                                        color: Color(0xFF1E1E1E),
                                      ),
                                    ),
                                    const SizedBox(width: 8),

                                    Image.asset(
                                      'assets/images/ShieldDone.png',
                                      width: 20,
                                      height: 24,
                                      fit: BoxFit.contain,
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 4),
                                const Text(
                                  'احصل على استرداد يصل إلى 100% في حال واجهت تجربة سيئة خلال رحلتك.',
                                  textAlign: TextAlign.right,
                                  style: TextStyle(
                                    fontSize: 13,
                                    color: Color(0xFF9B9B9B),
                                    height: 1.4,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(height: 8, color: Colors.grey[300]),
                    const SizedBox(height: 20),

                    const Align(
                      alignment: Alignment.centerRight,
                      child: Text(
                        'تفاصيل الدفع',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    const SizedBox(height: 12),
                    _priceRow('سعر التذكرة', 'IDR 10.000'),
                    const Divider(thickness: 1),
                    _priceRow('الحماية', 'IDR 10.000'),
                    const Divider(thickness: 1),
                    _priceRow('رسوم الخدمة', 'IDR 5.000'),
                    const Divider(thickness: 1),
                    _priceRow(
                      'الإجمالي',
                      'IDR 25.000',
                      bold: true,
                      color: Colors.blue,
                    ),
                    const SizedBox(height: 30),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// --- Helper Widgets ---

Widget _buildStep({
  required String title,
  required String subtitle,
  String? time,
  String? imagePath,
  Color? backgroundColor,
  required bool isLast,
}) {
  return Row(
    crossAxisAlignment: CrossAxisAlignment.start,
    textDirection: TextDirection.rtl,

    children: [
      Column(
        children: [
          if (imagePath != null)
            Container(
              width: 25,
              height: 25,
              padding: const EdgeInsets.all(2),
              decoration: BoxDecoration(
                color: isLast
                    ? Colors.transparent
                    : (backgroundColor ?? Colors.grey[300]),
                borderRadius: BorderRadius.circular(isLast ? 0 : 4),
              ),
              child: Image.asset(imagePath, fit: BoxFit.contain),
            ),
          if (!isLast)
            SizedBox(
              width: 0.7,
              height: 50,
              child: CustomPaint(painter: DashedLinePainter()),
            ),
        ],
      ),

      const SizedBox(width: 8),
      Expanded(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Text(
              subtitle,
              style: const TextStyle(fontSize: 13, color: Colors.grey),
            ),
            Text(
              title,
              style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
            ),
            if (time != null) ...[
              const SizedBox(height: 4),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: Colors.grey[200],
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(
                  time,
                  style: const TextStyle(fontSize: 12, color: Colors.black54),
                ),
              ),
            ],
            const SizedBox(height: 16),
          ],
        ),
      ),
    ],
  );
}

Widget _priceRow(
  String label,
  String value, {
  bool bold = false,
  Color? color,
}) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    textDirection: TextDirection.rtl,
    children: [
      Text(
        label,
        style: TextStyle(
          fontSize: 15,
          fontWeight: bold ? FontWeight.bold : FontWeight.normal,
        ),
      ),
      Text(
        value,
        style: TextStyle(
          fontSize: 15,
          color: color ?? Colors.black,
          fontWeight: bold ? FontWeight.bold : FontWeight.normal,
        ),
      ),
    ],
  );
}

class DashedLinePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    double dashHeight = 4, dashSpace = 4, startY = 0;
    final paint = Paint()
      ..color = Colors.grey[400]!
      ..strokeWidth = size.width;

    while (startY < size.height) {
      canvas.drawLine(Offset(0, startY), Offset(0, startY + dashHeight), paint);
      startY += dashHeight + dashSpace;
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
