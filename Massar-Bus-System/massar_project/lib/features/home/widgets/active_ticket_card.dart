import 'package:massar_project/core/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:massar_project/features/home/widgets/e_ticket_modal.dart';
import 'package:massar_project/features/auth/bloc/auth_bloc.dart';
import 'package:massar_project/features/auth/bloc/auth_state.dart';

class ActiveTicketCard extends StatelessWidget {
  const ActiveTicketCard({super.key});

  @override
  Widget build(BuildContext context) {
    
    

    return BlocBuilder<AuthBloc, AuthState>(
      builder: (context, state) {
        if (state is AuthAuthenticated && state.activeTicket != null) {
          final ticket = state.activeTicket!;


        // استخدام البيانات الحقيقية القادمة من السيرفر
        final String bookingCode = ticket['booking_code'] ?? 'N/A';
        final String dateStr = ticket['date'] ?? '---';
        final String fromStation = ticket['from'] ?? '---';
        final String toStation = ticket['to'] ?? '---';
        final String duration = ticket['duration'] ?? '---';
        final String busInfo = ticket['bus_info'] ?? '---';

        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                'تذكرتك النشطة',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: AppColors.textPrimary,
                ),
              ),
              const SizedBox(height: 16),
              Container(
                padding: const EdgeInsets.all(16.0),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16.0),
                  border: Border.all(
                    color: const Color(0xFFE4E7EC),
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.04),
                      blurRadius: 10,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    // Date (بيانات حقيقية)
                    Text(
                      dateStr,
                      textAlign: TextAlign.left,
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: AppColors.textPrimary,
                      ),
                    ),
                    const SizedBox(height: 12),

                    // Tags
                    Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 10,
                            vertical: 4,
                          ),
                          decoration: BoxDecoration(
                            color: const Color(0xFFE85C0D), // Orange
                            borderRadius: BorderRadius.circular(6.0),
                          ),
                          child: const Text(
                            'الأسرع',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                        const SizedBox(width: 8),
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 10,
                            vertical: 4,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(6.0),
                            border: Border.all(
                              color: const Color(0xFFE4E7EC),
                            ),
                          ),
                          child: Text(
                            'مختلط',
                            style: TextStyle(
                              color: AppColors.textSecondary,
                              fontSize: 12,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 24),

                    // Timeline
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        // Start Station (بيانات حقيقية)
                        _buildStationInfo(
                          context,
                          iconColor: const Color(0xFF12B76A), // Green
                          title: 'محطة',
                          subtitle: fromStation,
                          crossAxisAlignment: CrossAxisAlignment.start,
                        ),

                        // Duration Connector
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 8.0,
                            ),
                            child: Row(
                              children: [
                                Expanded(
                                  child: Container(
                                    height: 1.5,
                                    color: const Color(0xFFF2F4F7),
                                  ),
                                ),
                                Container(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 10,
                                    vertical: 4,
                                  ),
                                  decoration: BoxDecoration(
                                    color: const Color(0xFFF9FAFB),
                                    borderRadius: BorderRadius.circular(12.0),
                                    border: Border.all(
                                      color: const Color(0xFFE4E7EC),
                                    ),
                                  ),
                                  child: Text(
                                    'المدة: $duration',
                                    style: TextStyle(
                                      fontSize: 10,
                                      fontWeight: FontWeight.w600,
                                      color: AppColors.textSecondary,
                                    ),
                                  ),
                                ),
                                Expanded(
                                  child: Container(
                                    height: 1.5,
                                    color: const Color(0xFFF2F4F7),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),

                        // End Station (بيانات حقيقية)
                        _buildStationInfo(
                          context,
                          iconColor: const Color(0xFFE85C0D), // Orange
                          title: 'محطة',
                          subtitle: toStation,
                          crossAxisAlignment: CrossAxisAlignment.end,
                        ),
                      ],
                    ),
                    const SizedBox(height: 24),

                    // Bus Details (بيانات حقيقية)
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Icon(
                          Icons.directions_bus_rounded,
                          color: AppColors.textSecondary,
                          size: 20,
                        ),
                        const SizedBox(width: 8),
                        Flexible(
                          child: Text(
                            busInfo,
                            style: TextStyle(
                              fontSize: 13,
                              color: AppColors.textSecondary,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),

                    // See Barcode Button
                    SizedBox(
                      width: double.infinity,
                      height: 48,
                      child: ElevatedButton(
                        onPressed: () {
                          ETicketModal.show(context, bookingCode: bookingCode);
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.mainButton,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          elevation: 0,
                        ),
                        child: const Text(
                          'عرض الباركود',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
        }
        return const SizedBox.shrink();
      },
    );
  }

  Widget _buildStationInfo(
    BuildContext context, {
    required Color iconColor,
    required String title,
    required String subtitle,
    required CrossAxisAlignment crossAxisAlignment,
  }) {
    
    return Row(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (crossAxisAlignment == CrossAxisAlignment.start) ...[
          _buildMarkerIcon(iconColor),
          const SizedBox(width: 8),
        ],
        Column(
          crossAxisAlignment: crossAxisAlignment,
          children: [
            Text(
              title,
              style: TextStyle(
                fontSize: 11,
                color: AppColors.textSecondary,
                fontWeight: FontWeight.w500,
              ),
            ),
            Text(
              subtitle,
              style: TextStyle(
                fontSize: 14,
                color: AppColors.textPrimary,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        if (crossAxisAlignment == CrossAxisAlignment.end) ...[
          const SizedBox(width: 8),
          _buildMarkerIcon(iconColor),
        ],
      ],
    );
  }

  Widget _buildMarkerIcon(Color color) {
    return Container(
      width: 20,
      height: 20,
      decoration: BoxDecoration(
        color: color.withOpacity(0.15),
        border: Border.all(color: color, width: 2),
        shape: BoxShape.circle,
      ),
    );
  }
}




