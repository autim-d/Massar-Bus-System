import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  void _showBarcode(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.white,
      isScrollControlled: true, // ✅ Allows scrolling for tall content
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) {
        return DraggableScrollableSheet(
          expand: false,
          initialChildSize: 0.6,
          minChildSize: 0.3,
          maxChildSize: 0.7,
          builder: (context, scrollController) {
            return SingleChildScrollView(
              controller: scrollController,
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 25),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // Close button row
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      IconButton(
                        icon: const Icon(Icons.close, color: Colors.black),
                        onPressed: () => Navigator.pop(context),
                      ),
                    ],
                  ),

                  // Title
                  const Text(
                    "تذكرتك الإلكترونية",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),

                  const SizedBox(height: 10),

                  // QR image
                  Image.asset(
                    'assets/images/qr.png',
                    width: 180,
                    height: 180,
                    fit: BoxFit.contain,
                  ),

                  const SizedBox(height: 10),

                  // Booking code label
                  const Text(
                    "كود الحجز",
                    style: TextStyle(fontSize: 14, color: Colors.black),
                  ),
                  const SizedBox(height: 4),

                  // Booking code value
                  const Text(
                    "BUS01150224",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                      color: Colors.black,
                    ),
                  ),

                  const SizedBox(height: 5),

                  // Instruction text
                  const Text(
                    "قم بمسح الرمز الشريطي أو إدخال رمز الحجز عند ركوب الحافلة.",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.grey,
                      fontSize: 13,
                      height: 1.4,
                    ),
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;

    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(
          child: Align(
            alignment: Alignment.topCenter,
            child: SizedBox(
              width: screenWidth * 0.9,
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(), // ✅ Smooth scroll
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 20),

                    // Greeting + Notification Row
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          textDirection: TextDirection.rtl,
                          children: const [
                            Text(
                              "صباح الخير",
                              style: TextStyle(
                                color: Colors.grey,
                                fontSize: 14,
                              ),
                            ),
                            Text(
                              "عدنان البيتي",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 20,
                                color: Colors.black,
                              ),
                            ),
                          ],
                        ),
                        Image.asset(
                          'assets/icons/Notification.png',
                          width: 80,
                          height: 80,
                        ),
                      ],
                    ),

                    const SizedBox(height: 10),

                    // Search Field
                    SizedBox(
                      height: 45,
                      child: TextField(
                        textAlign: TextAlign.right,
                        decoration: InputDecoration(
                          hintText: "إلى أين أنت ذاهب اليوم؟",
                          hintStyle: const TextStyle(fontSize: 15),
                          contentPadding: const EdgeInsets.symmetric(
                            horizontal: 15,
                            vertical: 10,
                          ),
                          filled: true,
                          fillColor: Colors.white,
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                            borderSide: BorderSide(color: Colors.grey.shade300),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                            borderSide: BorderSide(color: Colors.grey.shade300),
                          ),
                        ),
                      ),
                    ),

                    const SizedBox(height: 20),

                    // City Buttons
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      physics: const BouncingScrollPhysics(),
                      child: Row(
                        children: [
                          _buildCityButton("عدن"),
                          _buildCityButton("تعز"),
                          _buildCityButton("حضرموت"),
                          _buildCityButton("المكلا"),
                          _buildCityButton("صنعاء"),
                        ],
                      ),
                    ),

                    const SizedBox(height: 25),

                    // Active Ticket Title
                    const Text(
                      "تذكرتك النشطة",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                        color: Colors.black,
                      ),
                    ),

                    const SizedBox(height: 10),

                    // Ticket Card
                    _buildTicketCard(context),

                    const SizedBox(height: 60),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  // ✅ Reusable city button widget
  Widget _buildCityButton(String cityName) {
    return Container(
      height: 75,
      width: 180,
      margin: const EdgeInsets.only(right: 12),
      decoration: BoxDecoration(
        color: const Color(0xFFF8F9FC),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: const Color(0xFFE0E0E0), width: 1),
      ),
      child: OutlinedButton(
        onPressed: () {},
        style: OutlinedButton.styleFrom(
          backgroundColor: const Color(0xFFF2F3F3),
          padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 12),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          side: const BorderSide(color: Color(0xFFE0E0E0)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              "شراء تذكرة إلى",
              style: TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w400,
                color: Color(0xFF6C7280),
              ),
            ),
            const SizedBox(height: 4),
            Row(
              children: [
                Image.asset(
                  'assets/images/Blacklocation.png',
                  width: 20,
                  height: 20,
                ),
                const SizedBox(width: 5),
                Text(
                  cityName,
                  style: const TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w600,
                    color: Color(0xFF101828),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  // ✅ Reusable Ticket Card widget
  Widget _buildTicketCard(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: Colors.black, width: 1),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Align(
            alignment: Alignment.centerRight,
            child: Text(
              'الاثنين، 19 فبراير 2024',
              style: const TextStyle(
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
              _tagBox("مزيج", Colors.white, Colors.grey),
              const SizedBox(width: 10),
              _tagBox("الأسرع", Colors.orange, Colors.white),
            ],
          ),
          const SizedBox(height: 20),
          _routeSection(),
          const SizedBox(height: 10),
          _busInfo(),
          const SizedBox(height: 20),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () => _showBarcode(context),
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF0062FF),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                padding: const EdgeInsets.symmetric(vertical: 14),
              ),
              child: const Text(
                "انظر إلى الباركود",
                style: TextStyle(fontSize: 16, color: Colors.white),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _tagBox(String text, Color bg, Color fg) {
    return Container(
      width: 60,
      height: 28,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: bg,
        borderRadius: BorderRadius.circular(6),
        border: Border.all(color: Colors.grey, width: 0.5),
      ),
      child: Text(
        text,
        style: TextStyle(color: fg, fontSize: 14, fontWeight: FontWeight.w500),
      ),
    );
  }

  Widget _routeSection() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // Start
          Row(
            children: [
              const SizedBox(width: 6),
              _stopInfo("بالي"),
              Image.asset(
                'assets/images/Destination.png',
                width: 22,
                height: 26,
              ),
            ],
          ),
          // Time
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
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
          // Destination
          Row(
            children: [
              _stopInfo("عدن"),
              const SizedBox(width: 6),
              Container(
                padding: const EdgeInsets.all(3),
                decoration: BoxDecoration(
                  color: Colors.green,
                  borderRadius: BorderRadius.circular(5),
                ),
                child: Image.asset(
                  'assets/images/location.png',
                  width: 15,
                  height: 15,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _stopInfo(String name) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const Text(
            'موقف',
            style: TextStyle(
              fontSize: 10,
              fontWeight: FontWeight.bold,
              color: Colors.grey,
            ),
          ),
          const SizedBox(height: 2),
          Text(
            name,
            style: const TextStyle(
              fontSize: 11,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
        ],
      ),
    );
  }

  Widget _busInfo() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Image.asset('assets/images/bus.png', width: 27, height: 27),
        const SizedBox(width: 10),
        const Text(
          'باص 01',
          style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
        ),
        const SizedBox(width: 35),
        Flexible(
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            child: const Text(
              'الوصول الساعة 15:30 الى موقف كامبونج بالي ',
              style: TextStyle(fontSize: 13, color: Colors.black87),
              textAlign: TextAlign.right,
            ),
          ),
        ),
      ],
    );
  }
}
