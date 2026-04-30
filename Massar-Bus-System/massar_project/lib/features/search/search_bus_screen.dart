import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:massar_project/features/home/models/bus_search_criteria.dart';
import 'package:massar_project/features/home/providers/search_location_provider.dart';
import '../../core/theme/app_colors.dart';
import '../../core/widgets/primary_button.dart';

class SearchBusScreen extends ConsumerStatefulWidget {
  const SearchBusScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<SearchBusScreen> createState() => _SearchBusScreenState();
}

class _SearchBusScreenState extends ConsumerState<SearchBusScreen> {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final locationState = ref.watch(searchLocationProvider);

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      appBar: AppBar(
        title: Text(
          'البحث عن الباص',
          style: TextStyle(
            fontFamily: 'Poppins',
            fontWeight: FontWeight.w600,
            color: theme.textTheme.titleLarge?.color ?? AppColors.textPrimary,
          ),
        ),
        backgroundColor: theme.appBarTheme.backgroundColor,
        elevation: 0,
        centerTitle: true,
        iconTheme: theme.iconTheme,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: theme.cardTheme.color,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: theme.dividerColor),
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
                    onTap: () => context.push('/home/location', extra: false),
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
                  color: theme.textTheme.bodyLarge?.color,
                ),
              ),
            ),
            const SizedBox(height: 12),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              decoration: BoxDecoration(
                color: theme.cardTheme.color,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: theme.dividerColor),
              ),
              child: Row(
                children: [
                  Icon(Icons.location_on, color: theme.iconTheme.color),
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
                      color: theme.textTheme.bodySmall?.color,
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

  Widget _buildLocationSelector({
    required String label,
    required String value,
    required VoidCallback onTap,
  }) {
    final theme = Theme.of(context);
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
                color: theme.textTheme.bodySmall?.color,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              value,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: theme.textTheme.bodyLarge?.color,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
