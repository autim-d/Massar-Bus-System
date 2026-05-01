import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:massar_project/core/theme/app_colors.dart';
import 'package:massar_project/features/auth/bloc/auth_bloc.dart';
import 'package:massar_project/features/auth/bloc/auth_event.dart';
import 'package:massar_project/features/home/models/bus_ticket_model.dart';
import 'package:massar_project/features/ticket/bloc/checkout_bloc.dart';
import '../widgets/components/checkout_stepper.dart';
import '../widgets/components/price_breakdown_column.dart';
import '../widgets/components/animated_success_modal.dart';

class PaymentMethodScreen extends StatelessWidget {
  final BusTicketModel ticket;

  const PaymentMethodScreen({super.key, required this.ticket});

  String _formatArabicDate(DateTime date) {
    const months = [
      'يناير',
      'فبراير',
      'مارس',
      'أبريل',
      'مايو',
      'يونيو',
      'يوليو',
      'أغسطس',
      'سبتمبر',
      'أكتوبر',
      'نوفمبر',
      'ديسمبر',
    ];
    const weekdays = [
      'الاثنين',
      'الثلاثاء',
      'الأربعاء',
      'الخميس',
      'الجمعة',
      'السبت',
      'الأحد',
    ];
    return '${weekdays[date.weekday - 1]} , ${date.day} ${months[date.month - 1]} ${date.year}';
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return BlocListener<CheckoutBloc, CheckoutState>(
      listener: (context, state) {
        if (state is CheckoutSuccess && !state.isTemporaryBooking) {
          // Show the animated success modal for payment
          showAnimatedSuccessModal(
            context: context,
            title: "تم الدفع بنجاح",
            orderId: state.session.orderId,
            paymentMethod: state.session.paymentMethod,
            transactionDate: state.session.transactionDate,
            onViewTicket: () {
              // تحديث بيانات المستخدم (عدد الإشعارات) فوراً بعد الدفع الناجح
              context.read<AuthBloc>().add(GetUserDataEvent());

              // Clear stack and go to e-ticket
              context.go('/tickets/my-ticket', extra: state.session);
            },
          );
        } else if (state is CheckoutError) {
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(SnackBar(content: Text(state.message)));
        }
      },
      child: SafeArea(
        child: Directionality(
          textDirection: TextDirection.rtl,
          child: Scaffold(
            backgroundColor: theme.scaffoldBackgroundColor,
            appBar: AppBar(
              backgroundColor: theme.appBarTheme.backgroundColor,
              elevation: 0,
              leading: IconButton(
                icon: Icon(Icons.arrow_back_ios, color: theme.iconTheme.color),
                onPressed: () => context.pop(),
              ),
              title: Column(
                children: [
                  Text(
                    "مواصلة الدفع",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w800,
                      color: theme.textTheme.titleLarge?.color,
                    ),
                  ),
                  Text(
                    "سيتم إنشاء المعرف عند الدفع",
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w400,
                      color: theme.textTheme.bodySmall?.color,
                    ),
                  ),
                ],
              ),
              centerTitle: true,
            ),
            body: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const CheckoutStepper(),
                  const SizedBox(height: 10),

                  // Countdown Timer
                  Container(
                    width: 350,
                    height: 50,
                    decoration: const BoxDecoration(
                      gradient: LinearGradient(
                        colors: [Color(0xff1570EF), Color(0xff2E90FA)],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Padding(
                          padding: EdgeInsets.all(5),
                          child: Text(
                            "الانتهاء في :",
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w800,
                              fontSize: 17,
                            ),
                          ),
                        ),
                        Row(
                          children: [
                            _buildTimerBox("59"),
                            const Text(
                              " : ",
                              style: TextStyle(color: Colors.white),
                            ),
                            _buildTimerBox("01"),
                            const Text(
                              " : ",
                              style: TextStyle(color: Colors.white),
                            ),
                            _buildTimerBox("00"),
                            const SizedBox(width: 10),
                          ],
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),

                  // Ticket Summary Card
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: theme.cardTheme.color,
                        border: Border.all(
                          color: isDark
                              ? Colors.white.withOpacity(0.1)
                              : const Color(0xffE5D2D2),
                          width: .7,
                        ),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            _formatArabicDate(ticket.date),
                            style: TextStyle(
                              fontWeight: FontWeight.w800,
                              fontSize: 16,
                              color: theme.textTheme.bodyLarge?.color,
                            ),
                          ),
                          const SizedBox(height: 16),
                          Row(
                            children: [
                              const Icon(
                                Icons.place,
                                color: Colors.green,
                                size: 20,
                              ),
                              const SizedBox(width: 4),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "التوقف الحالي",
                                    style: TextStyle(
                                      color: isDark
                                          ? theme.textTheme.bodySmall?.color
                                          : const Color(0xff667085),
                                      fontSize: 10,
                                    ),
                                  ),
                                  Text(
                                    ticket.fromStation.name,
                                    style: TextStyle(
                                      fontSize: 15,
                                      color: theme.textTheme.bodyLarge?.color,
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(width: 15),
                              Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 8,
                                  vertical: 2,
                                ),
                                decoration: BoxDecoration(
                                  color: isDark
                                      ? Colors.white.withOpacity(0.05)
                                      : const Color(0xffF9FAFB),
                                  borderRadius: BorderRadius.circular(8),
                                  border: Border.all(
                                    color: isDark
                                        ? Colors.white.withOpacity(0.1)
                                        : const Color(0xffE5D2D2),
                                  ),
                                ),
                                child: Text(
                                  "الوصول المتوقع: ${ticket.arrivalTime}",
                                  style: TextStyle(
                                    fontSize: 10,
                                    color: theme.textTheme.bodySmall?.color,
                                  ),
                                ),
                              ),
                              const SizedBox(width: 15),
                              const Icon(
                                Icons.place,
                                color: AppColors.destenation,
                                size: 20,
                              ),
                              const SizedBox(width: 4),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "الوجهة",
                                    style: TextStyle(
                                      color: isDark
                                          ? theme.textTheme.bodySmall?.color
                                          : const Color(0xff667085),
                                      fontSize: 10,
                                    ),
                                  ),
                                  Text(
                                    ticket.toStation.name,
                                    style: TextStyle(
                                      fontSize: 15,
                                      color: theme.textTheme.bodyLarge?.color,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                          const SizedBox(height: 15),
                          SizedBox(
                            height: 30,
                            child: ElevatedButton(
                              onPressed: () {},
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.transparent,
                                shadowColor: Colors.transparent,
                                elevation: 0,
                                padding: EdgeInsets.zero,
                              ),
                              child: const Text(
                                "تفاصيل الطلب",
                                style: TextStyle(
                                  color: AppColors.textEdit,
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  Divider(
                    height: 20,
                    thickness: 8,
                    color: isDark
                        ? Colors.black.withOpacity(0.3)
                        : const Color(0xffF2F4F7),
                  ),

                  // Payment Method Selector
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 10,
                    ),
                    child: Align(
                      alignment: Alignment.centerRight,
                      child: Text(
                        "طريقة الدفع",
                        style: TextStyle(
                          fontSize: 17,
                          fontWeight: FontWeight.bold,
                          color: theme.textTheme.titleLarge?.color,
                        ),
                      ),
                    ),
                  ),

                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: theme.cardTheme.color,
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(color: theme.dividerColor),
                      ),
                      child: Column(
                        children: [
                          Row(
                            children: [
                              Image.asset(
                                "assets/images/vector.png",
                                width: 40,
                                height: 30,
                              ),
                              const SizedBox(width: 10),
                              Text(
                                "Mandiri VA",
                                style: TextStyle(
                                  fontSize: 16,
                                  color: theme.textTheme.bodyLarge?.color,
                                ),
                              ),
                              const Spacer(),
                              TextButton(
                                onPressed: () {},
                                child: const Text(
                                  "تغيير",
                                  style: TextStyle(
                                    color: AppColors.textEdit,
                                    fontWeight: FontWeight.w800,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          Divider(thickness: 0.3, color: theme.dividerColor),
                          Row(
                            children: [
                              Expanded(
                                child: Text(
                                  "استخدام الحساب الافتراضي سيضيف رسوم إضافية",
                                  style: TextStyle(
                                    color: isDark
                                        ? theme.textTheme.bodySmall?.color
                                        : const Color(0xff667085),
                                    fontSize: 11,
                                  ),
                                ),
                              ),
                              Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 8,
                                  vertical: 2,
                                ),
                                decoration: BoxDecoration(
                                  color: isDark
                                      ? Colors.white.withOpacity(0.05)
                                      : const Color(0xffF9FAFB),
                                  border: Border.all(color: theme.dividerColor),
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                child: Text(
                                  " 800+ ريال",
                                  style: TextStyle(
                                    fontSize: 11,
                                    color: theme.textTheme.bodyMedium?.color,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),

                  const SizedBox(height: 20),
                  Divider(
                    height: 20,
                    thickness: 8,
                    color: isDark
                        ? Colors.black.withOpacity(0.3)
                        : const Color(0xffF2F4F7),
                  ),

                  // Promo Code
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 10,
                    ),
                    child: Container(
                      decoration: BoxDecoration(
                        color: theme.cardTheme.color,
                        border: Border.all(color: theme.dividerColor),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: ListTile(
                        leading: SvgPicture.asset(
                          "assets/icons/promo.svg",
                          width: 24,
                          height: 24,
                        ),
                        title: const Text(
                          "استخدم العرض الترويجي",
                          style: TextStyle(
                            color: Colors.green,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        trailing: const Icon(
                          Icons.arrow_forward_ios,
                          color: Colors.green,
                          size: 16,
                        ),
                        onTap: () {},
                      ),
                    ),
                  ),

                  // Important Info & Terms
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: theme.cardTheme.color,
                        border: Border.all(color: theme.dividerColor),
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "معلومة مهمة",
                            style: TextStyle(
                              fontSize: 14,
                              color: theme.textTheme.bodyLarge?.color,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            "الدفع يتم فقط عن طريق بنك بن دول ولا يمكن استبداله",
                            style: TextStyle(
                              fontSize: 12,
                              color: isDark
                                  ? theme.textTheme.bodySmall?.color
                                  : const Color(0xff667085),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),

                  Padding(
                    padding: const EdgeInsets.all(16),
                    child: RichText(
                      text: TextSpan(
                        style: TextStyle(
                          color: theme.textTheme.bodySmall?.color,
                          fontSize: 12,
                        ),
                        children: const [
                          TextSpan(
                            text: "بالضغط على زر الدفع، فإنك توافق على ",
                          ),
                          TextSpan(
                            text: "الشروط والأحكام",
                            style: TextStyle(
                              color: Colors.blue,
                              decoration: TextDecoration.underline,
                            ),
                          ),
                          TextSpan(text: " و "),
                          TextSpan(
                            text: "سياسة الخصوصية",
                            style: TextStyle(
                              color: Colors.blue,
                              decoration: TextDecoration.underline,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),

                  Divider(
                    height: 20,
                    thickness: 8,
                    color: isDark
                        ? Colors.black.withOpacity(0.3)
                        : const Color(0xffF2F4F7),
                  ),

                  // Price Breakdown
                  Padding(
                    padding: const EdgeInsets.all(16),
                    child: PriceBreakdownColumn(
                      ticketPrice: ticket.price,
                      protectionFee: 200, // Sample convenience fee
                      serviceFee: 300, // Sample service fee
                    ),
                  ),
                ],
              ),
            ),
            bottomNavigationBar: Container(
              color: theme.scaffoldBackgroundColor,
              padding: const EdgeInsets.all(16),
              child: BlocBuilder<CheckoutBloc, CheckoutState>(
                builder: (context, state) {
                  final isLoading = state is CheckoutLoading;
                  return SizedBox(
                    height: 55,
                    child: ElevatedButton(
                      onPressed: isLoading
                          ? null
                          : () {
                              context.read<CheckoutBloc>().add(
                                ProcessPaymentRequested(
                                  tripId: ticket.id,
                                  passengerName: ticket.passengerName,
                                  passengerPhone: ticket.passengerPhone,
                                ),
                              );
                            },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xff1570EF),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      child: isLoading
                          ? const CircularProgressIndicator(color: Colors.white)
                          : const Text(
                              "الدفع باستخدام بن دول باي",
                              style: TextStyle(
                                fontSize: 16,
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                    ),
                  );
                },
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTimerBox(String val) {
    return Container(
      width: 24,
      height: 24,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Text(
        val,
        style: const TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 12,
          color: Color(0xff1570EF),
        ),
      ),
    );
  }
}
