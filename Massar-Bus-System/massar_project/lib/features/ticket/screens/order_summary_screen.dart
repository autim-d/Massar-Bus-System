import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:massar_project/features/auth/bloc/auth_bloc.dart';
import 'package:massar_project/features/auth/bloc/auth_state.dart';
import 'package:massar_project/core/theme/app_colors.dart';
import 'package:massar_project/features/home/models/trip_model.dart';

// import '../models/trip_model.dart';

class OrderSummaryScreen extends StatefulWidget {
  final TripModel? trip;
  const OrderSummaryScreen({super.key, this.trip});

  @override
  State<OrderSummaryScreen> createState() => _OrderSummaryScreenState();
}

class _OrderSummaryScreenState extends State<OrderSummaryScreen> {
  late TripModel _trip;

  @override
  void initState() {
    super.initState();
    _trip = widget.trip ?? TripModel.sample();
  }
  @override
  Widget build(BuildContext context) {
    
    

    return SafeArea(
      child: Directionality(
        // <-- Important: RTL Layout
        textDirection: TextDirection.rtl,

        child: Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
            backgroundColor: Colors.white,
            elevation: 0,
            leading: IconButton(
              icon: Icon(Icons.arrow_back_ios, color: AppColors.textPrimary),
              onPressed: () => context.pop(),
            ),
            title: Padding(
              padding: const EdgeInsets.only(top: 17),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 60, bottom: 20),
                    child: Text(
                      "تذكرة اختيارك",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w800,
                        color: AppColors.textPrimary,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),

          body: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Divider(thickness: 1.5, color: AppColors.grey200),
                const SizedBox(height: 35),
                Padding(
                  padding: const EdgeInsets.only(
                    right: 10,
                    left: 10,
                    bottom: 10,
                  ),
                  child: Container(
                    padding: const EdgeInsets.all(16),
                    width: 375,
                    height: 400,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border.all(
                        color: const Color(0xffE5D2D2),
                        width: .7,
                      ),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        /// ---------------- السطر الأول: التاريخ ----------------
                        Row(
                          children: [
                            Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 8,
                                vertical: 4,
                              ),
                              child: Text(
                                _trip.date,
                                style: TextStyle(
                                  fontWeight: FontWeight.w800,
                                  fontSize: 16,
                                  color: AppColors.textPrimary,
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 15),
                        Padding(
                          padding: const EdgeInsets.only(right: 10),
                          child: Row(
                            children: [
                              const Icon(Icons.directions_bus, color: AppColors.mainButton, size: 20),
                              const SizedBox(width: 6),
                              Text(
                                "${_trip.busName} - الوصول في ${_trip.arrivalTime} الى ${_trip.to}",
                                style: const TextStyle(color: AppColors.textSecondary, fontSize: 14),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 15),
                        Row(
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(right: 8),
                              child: Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 8,
                                  vertical: 4,
                                ),
                                decoration: BoxDecoration(
                                  color: Colors.orange,
                                  borderRadius: BorderRadius.circular(6),
                                ),
                                child: const Text(
                                  "الاسرع",
                                  style: TextStyle(color: Colors.white),
                                ),
                              ),
                            ),
                            const SizedBox(width: 20),
                            Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 8,
                                vertical: 4,
                              ),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(6),
                                border: Border.all(
                                  color: AppColors.grey200,
                                ),
                              ),
                              child: Text(
                                "مختلط",
                                style: TextStyle(color: AppColors.textSecondary),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 16),
                        Divider(thickness: .7, indent: 0, endIndent: 0, color: AppColors.grey200),
                        Padding(
                          padding: const EdgeInsets.only(right: 10),
                          child: Row(
                            children: [
                              const Icon(
                                Icons.location_on_sharp,
                                color: Color(0xFF12B76A),
                                size: 31,
                              ),
                              const SizedBox(width: 10),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(left: 10),
                                    child: Text(
                                      "العمل",
                                      style: TextStyle(
                                        color: AppColors.textSecondary,
                                        fontSize: 14,
                                      ),
                                    ),
                                  ),
                                  Text(
                                    _trip.from,
                                    style: TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.w600,
                                      color: AppColors.textPrimary,
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 8),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                            right: 34,
                            bottom: 5,
                          ),
                          child: Container(
                            width: 60,
                            height: 23,
                            decoration: BoxDecoration(
                              border: Border.all(color: AppColors.grey200),
                              borderRadius: BorderRadius.circular(15),
                              color: const Color(0xffF9FAFB),
                            ),
                            child: Center(
                              child: Text(
                                "10 دقائق",
                                style: TextStyle(fontSize: 10, color: AppColors.textSecondary),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 10),
                        Padding(
                          padding: const EdgeInsets.only(right: 10),
                          child: Row(
                            children: [
                              const Icon(
                                Icons.bus_alert_outlined,
                                color: Color(0xFFE85C0D),
                                size: 31,
                              ),
                              const SizedBox(width: 10),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(
                                      left: 20,
                                    ),
                                    child: Text(
                                      "الوقوف",
                                      style: TextStyle(
                                        color: AppColors.textSecondary,
                                        fontSize: 14,
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                      left: 20,
                                    ),
                                    child: Text(
                                      _trip.to,
                                      style: TextStyle(
                                        fontSize: 15,
                                        fontWeight: FontWeight.w600,
                                        color: AppColors.textPrimary,
                                      ),
                                    ),
                                  ),
                                  Container(
                                    width: 60,
                                    height: 23,
                                    decoration: BoxDecoration(
                                      border: Border.all(
                                        color: AppColors.grey200,
                                      ),
                                      borderRadius: BorderRadius.circular(15),
                                      color: const Color(0xffF9FAFB),
                                    ),
                                    child: Center(
                                      child: Text(
                                        "10 دقائق",
                                        style: TextStyle(fontSize: 10, color: AppColors.textSecondary),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 8),
                            ],
                          ),
                        ),
                        const SizedBox(height: 10),
                        Padding(
                          padding: const EdgeInsets.only(right: 10),
                          child: Row(
                            children: [
                              const Icon(Icons.radio_button_on, color: Color.fromARGB(255, 245, 153, 103)),
                              const SizedBox(width: 10),
                              Column(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(
                                      left: 10,
                                    ),
                                    child: Text(
                                      "اليوم",
                                      style: TextStyle(
                                        color: AppColors.textSecondary,
                                        fontSize: 14,
                                      ),
                                    ),
                                  ),
                                  Text(
                                    "الاثنين",
                                    style: TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.w600,
                                      color: AppColors.textPrimary,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 15),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                Divider(
                  indent: 0,
                  endIndent: 0,
                  height: 20,
                  thickness: 8,
                  color: const Color(0xffF2F4F7),
                ),
                const SizedBox(height: 20),

                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Text(
                    "تتبع الباص ",
                    style: TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.bold,
                      color: AppColors.textPrimary,
                    ),
                  ),
                ),

                const SizedBox(height: 10),

                Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 10, right: 10),
                          child: SizedBox(
                            width: 330,
                            height: 130,
                            child: Image.asset(
                              "assets/images/maps.png",
                              width: 340,
                              height: 120,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),

                const SizedBox(height: 20),
                Divider(
                  indent: 0,
                  endIndent: 0,
                  height: 20,
                  thickness: 8,
                  color: const Color(0xffF2F4F7),
                ),
                const SizedBox(height: 20),
                Padding(
                  padding: const EdgeInsets.only(right: 10, left: 10),
                  child: BlocBuilder<AuthBloc, AuthState>(
                    builder: (context, state) {
                      String name = _trip.passengerName ?? 'خليل سيلان';
                      String email = 'khalilabraheem053@gmail.com';
                      String phone = _trip.passengerPhone ?? '776463185 967+';

                      if (state is AuthAuthenticated) {
                        if (_trip.passengerName == null) {
                          name = '${state.user?.firstName} ${state.user?.lastName}';
                        }
                        email = state.user?.email ?? '';
                        if (_trip.passengerPhone == null) {
                          phone = state.user?.phoneNumber ?? '';
                        }
                      }

                      return Container(
                        width: 350,
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          border: Border.all(
                            color: AppColors.grey200,
                            width: 2,
                          ),
                          borderRadius: BorderRadius.circular(15),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Expanded(
                                  child: Text(
                                    name,
                                    style: TextStyle(
                                      fontWeight: FontWeight.w800,
                                      fontSize: 19,
                                      color: AppColors.textPrimary,
                                    ),
                                  ),
                                ),
                                const Icon(Icons.edit, color: AppColors.textEdit),
                              ],
                            ),
                            const SizedBox(height: 10),
                            Text(
                              email,
                              style: TextStyle(
                                color: AppColors.textSecondary,
                                fontSize: 16,
                              ),
                            ),
                            const SizedBox(height: 10),
                            Text(
                              phone,
                              style: TextStyle(
                                color: AppColors.textSecondary,
                                fontSize: 16,
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ),

                const SizedBox(height: 20),
                Divider(
                  indent: 0,
                  endIndent: 0,
                  height: 20,
                  thickness: 8,
                  color: const Color(0xffF2F4F7),
                ),
                const SizedBox(height: 20),
                Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    children: [
                      Align(
                        alignment: Alignment.centerRight,
                        child: Text(
                          "تفاصيل الدفع",
                          style: TextStyle(
                            fontSize: 17,
                            fontWeight: FontWeight.bold,
                            color: AppColors.textPrimary,
                          ),
                        ),
                      ),

                      const SizedBox(height: 10),

                      _buildPriceRow(context, "سعر التذكرة", " ${_trip.price.toInt()} ريال يمني"),
                      Divider(height: 15, color: AppColors.grey200),
                      _buildPriceRow(context, "الحماية", " 1000 ريال يمني"), // Sample dynamic add-on text could go here
                      Divider(height: 15, color: AppColors.grey200),
                      _buildPriceRow(context, "راحة", " 1000 ريال يمني"),

                      _buildPriceRow(
                        context,
                        "الإجمالي",
                        " ${(_trip.price + 2000).toInt()} ريال يمني",
                        isTotal: true,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),

          bottomNavigationBar: Container(
            color: Colors.white,
            padding: const EdgeInsets.all(16),
            child: SizedBox(
              height: 55,
              child: ElevatedButton(
                onPressed: () {
                  context.push('/tickets/payment');
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.mainButton,
                ),
                child: const Text(
                  "متابعة الدفع",
                  style: TextStyle(fontSize: 16, color: Colors.white, fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildPriceRow(BuildContext context, String title, String amount, {bool isTotal = false}) {
    
    
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        children: [
          Text(
            title,
            style: TextStyle(
              color: isTotal
                  ? AppColors.textPrimary
                  : AppColors.textSecondary,
              fontSize: isTotal ? 17 : 15,
              fontWeight: isTotal ? FontWeight.w600 : FontWeight.w400,
            ),
          ),
          const Spacer(),
          Text(
            amount,
            style: TextStyle(
              fontSize: isTotal ? 17 : 15,
              fontWeight: isTotal ? FontWeight.bold : FontWeight.w400,
              color: isTotal ? AppColors.textEdit : AppColors.textPrimary,
            ),
          ),
        ],
      ),
    );
  }
}









