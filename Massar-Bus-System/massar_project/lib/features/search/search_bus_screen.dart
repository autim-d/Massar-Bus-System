import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:massar_project/features/home/models/bus_search_criteria.dart';
import 'package:massar_project/features/home/providers/search_location_provider.dart';
import '../../core/theme/app_colors.dart';
import '../../core/widgets/primary_button.dart';
import '../../core/widgets/custom_text_field.dart';
import 'package:geolocator/geolocator.dart';
import '../../location_fun.dart';
import '../../core/constants/api_constants.dart';

class SearchBusScreen extends ConsumerStatefulWidget {
  const SearchBusScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<SearchBusScreen> createState() => _SearchBusScreenState();
}

class _SearchBusScreenState extends ConsumerState<SearchBusScreen> {
  final List<String> fallbackPlaces = [
    "الشافعي", "إبن سينا", "المساكن", "مستشفى النور", 
    "العمودي المتضررين", "رئاسة الجامعة", "أبراج بن محفوظ", 
    "باعبود", "الجسر", "الشرج"
  ];

  @override
  Widget build(BuildContext context) {
    
    final locationState = ref.watch(searchLocationProvider);

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(
          'البحث عن الباص',
          style: TextStyle(
            fontFamily: 'Poppins',
            fontWeight: FontWeight.w600,
            color: AppColors.textPrimary ?? AppColors.textPrimary,
          ),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        iconTheme: const IconThemeData(color: AppColors.textPrimary),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: AppColors.grey200),
              ),
              child: Column(
                children: [
                  _buildLocationSelector(
                    label: 'من',
                    value: locationState.currentLocation?.name ?? 'موقعك الحالي',
                    onTap: () => context.push('/home/location', extra: true),
                  ),
                  const Padding(
                    padding: EdgeInsets.symmetric(vertical: 12),
                    child: Divider(),
                  ),
                  _buildLocationSelector(
                    label: 'إلى',
                    value: locationState.destination?.name ?? 'ابحث عن وجهة',
                    onTap: () => _showDestinationBottomSheet(context),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),
            PrimaryButton(
              label: 'البحث عن باص',
              onPressed: () {
                if (locationState.currentLocation != null &&
                    locationState.destination != null) {
                  final criteria = BusSearchCriteria(
                    from: locationState.currentLocation!.name,
                    to: locationState.destination!.name,
                    fromId: locationState.currentLocation!.id,
                    toId: locationState.destination!.id,
                    date: DateTime.now(),
                  );
                  context.push('/home/results', extra: criteria);
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                        content: Text('يرجى تحديد محطة الانطلاق والوصول')),
                  );
                }
              },
            ),
            const SizedBox(height: 24),
            Align(
              alignment: Alignment.centerRight,
              child: Text(
                'مكاتب التخزين',
                style: TextStyle(
                  fontFamily: 'Poppins',
                  fontWeight: FontWeight.w500,
                  fontSize: 16,
                  color: AppColors.textPrimary,
                ),
              ),
            ),
            const SizedBox(height: 12),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: AppColors.grey200),
              ),
              child: Row(
                children: [
                  Icon(Icons.location_on, color: AppColors.textPrimary),
                  const SizedBox(width: 12),
                  const Text(
                    'المساكن',
                    style: TextStyle(
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const Spacer(),
                  Text(
                    'حفظ الموقع',
                    style: TextStyle(
                      color: AppColors.textSecondary,
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showDestinationBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder: (context) {
        return Directionality(
          textDirection: TextDirection.rtl,
          child: ListView.builder(
            padding: const EdgeInsets.symmetric(vertical: 16),
            itemCount: fallbackPlaces.length,
            itemBuilder: (context, index) {
              final place = fallbackPlaces[index];
              return ListTile(
                leading: const Icon(Icons.location_on_outlined, color: AppColors.textSecondary),
                title: Text(
                  place,
                  style: const TextStyle(fontFamily: 'Poppins', fontWeight: FontWeight.w500),
                ),
                onTap: () {
                  // Update destination via the Riverpod provider
                  Navigator.pop(context);
                },
              );
            },
          ),
        );
      },
    );
  }

  Widget _buildLocationSelector({
    required String label,
    required String value,
    required VoidCallback onTap,
  }) {
    
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              label,
              style: TextStyle(
                fontSize: 14,
                color: AppColors.textSecondary,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              value,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: AppColors.textPrimary,
              ),
            ),
          ],
        ),
      ),
    );
  }
}







