import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../auth/bloc/auth_bloc.dart';
import '../../auth/bloc/auth_state.dart';
import '../../home/providers/search_location_provider.dart';
import '../../home/models/location_model.dart';
import '../../home/models/bus_search_criteria.dart';
import 'package:massar_project/core/theme/app_colors.dart';

class TicketListScreen extends ConsumerStatefulWidget {
  const TicketListScreen({super.key});
  @override
  ConsumerState<TicketListScreen> createState() => _TicketListScreenState();
}

class _TicketListScreenState extends ConsumerState<TicketListScreen> {
  static const Color primaryBlue = Color(0xFF2563EB);
  static const double _cardRadius = 14.0;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final w = MediaQuery.of(context).size.width;
    final h = MediaQuery.of(context).size.height;
    final horizontalPadding = w * 0.06;
    final bannerHeight = h * 0.49;

    final locationState = ref.watch(searchLocationProvider);

    return BlocBuilder<AuthBloc, AuthState>(
      builder: (context, state) {
        String name = 'زائر';
        List<Map<String, dynamic>> savedPlaces = [
          {'label': 'بيتنا', 'icon': Icons.home},
          {'label': 'مكتبي', 'icon': Icons.work},
        ];

        if (state is AuthAuthenticated) {
          name = state.name.split(' ').first;
          if (state.suggestedStations != null && state.suggestedStations!.isNotEmpty) {
            savedPlaces = state.suggestedStations!.map((s) {
              return {
                'id': s['id'].toString(),
                'label': s['name'] as String,
                'city': s['city'] as String,
                'icon': Icons.place_outlined,
              };
            }).toList();
          }
        }

        final List<String> recentSearches = [
          'المكلا سنتر',
          'الشرج',
          'باعبود',
        ];

        return Directionality(
          textDirection: TextDirection.rtl,
          child: Scaffold(
            backgroundColor: theme.scaffoldBackgroundColor,
            body: SafeArea(
              child: Stack(
                children: [
                  Positioned(
                    top: 0,
                    left: 0,
                    right: 0,
                    height: bannerHeight,
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        ClipRRect(
                          borderRadius: const BorderRadius.only(
                            bottomLeft: Radius.circular(50),
                            bottomRight: Radius.circular(50),
                          ),
                          child: Image.asset(
                            'assets/images/Background3.png',
                            fit: BoxFit.cover,
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(
                            horizontal: horizontalPadding,
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const SizedBox(height: 190),
                              Text(
                                'صباح الخير يا $name',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontFamily: 'air',
                                  fontSize: w * 0.053,
                                  fontWeight: FontWeight.w800,
                                  color: AppColors.textSave,
                                ),
                              ),
                              const SizedBox(height: 6),
                              Text(
                                'أتمنى أن يكون يومك مشرقًا\nمثل الشمس',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontFamily: 'AirStripArabic',
                                  fontSize: w * 0.034,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.white,
                                  height: 1.1,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  Positioned.fill(
                    child: SingleChildScrollView(
                      physics: const BouncingScrollPhysics(),
                      child: Padding(
                        padding: EdgeInsets.fromLTRB(
                          horizontalPadding,
                          bannerHeight - 40,
                          horizontalPadding,
                          28,
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            const SizedBox(height: 90),
                            GestureDetector(
                              onTap: () => context.push('/home/location', extra: true),
                              child: Container(
                                decoration: BoxDecoration(
                                  color: theme.cardTheme.color,
                                  borderRadius: BorderRadius.circular(_cardRadius),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.black.withOpacity(0.04),
                                      blurRadius: 10,
                                      offset: const Offset(0, 6),
                                    ),
                                  ],
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.stretch,
                                  children: [
                                    ClipRRect(
                                      borderRadius: const BorderRadius.only(
                                        topLeft: Radius.circular(_cardRadius),
                                        topRight: Radius.circular(_cardRadius),
                                      ),
                                      child: Container(
                                        height: 120,
                                        color: isDark
                                            ? Colors.white.withOpacity(0.05)
                                            : Colors.grey.shade100,
                                        child: Stack(
                                          children: [
                                            Positioned.fill(
                                              child: Image.asset(
                                                'assets/images/map.png',
                                                fit: BoxFit.cover,
                                                errorBuilder: (_, __, ___) =>
                                                    const Center(child: Icon(Icons.map, size: 48, color: Colors.grey)),
                                              ),
                                            ),
                                            Positioned(
                                              left: 20,
                                              top: 18,
                                              child: Container(
                                                width: 16,
                                                height: 16,
                                                decoration: BoxDecoration(
                                                  color: const Color(0xFF2E9BFF),
                                                  shape: BoxShape.circle,
                                                  border: Border.all(
                                                    color: Colors.white,
                                                    width: 3,
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(14.0),
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.stretch,
                                        children: [
                                          Text(
                                            'موقعك الحالي',
                                            textAlign: TextAlign.right,
                                            style: TextStyle(
                                              fontFamily: 'AirStripArabic',
                                              fontSize: w * 0.038,
                                              fontWeight: FontWeight.w700,
                                              color: theme.textTheme.bodyLarge?.color,
                                            ),
                                          ),
                                          const SizedBox(height: 6),
                                          Text(
                                            locationState.currentLocation?.name ?? 'حدد موقع الانطلاق',
                                            textAlign: TextAlign.right,
                                            style: TextStyle(
                                              fontFamily: 'AirStripArabic',
                                              fontSize: w * 0.032,
                                              color: theme.textTheme.bodyMedium?.color,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            const SizedBox(height: 14),
                            GestureDetector(
                              onTap: () => context.push('/home/location', extra: false),
                              child: Container(
                                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 14),
                                decoration: BoxDecoration(
                                  color: theme.cardTheme.color,
                                  borderRadius: BorderRadius.circular(12),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.black.withOpacity(0.03),
                                      blurRadius: 8,
                                      offset: const Offset(0, 4),
                                    ),
                                  ],
                                ),
                                child: Row(
                                  children: [
                                    const Icon(Icons.chevron_left, color: Colors.grey),
                                    const SizedBox(width: 12),
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.stretch,
                                        children: [
                                          Text(
                                            'ابحث عن وجهة',
                                            textAlign: TextAlign.right,
                                            style: TextStyle(
                                              fontFamily: 'AirStripArabic',
                                              fontSize: w * 0.036,
                                              fontWeight: FontWeight.w700,
                                              color: theme.textTheme.bodyLarge?.color,
                                            ),
                                          ),
                                          const SizedBox(height: 6),
                                          Row(
                                            mainAxisAlignment: MainAxisAlignment.end,
                                            children: [
                                              Text(
                                                locationState.destination?.name ?? 'حدد الموقع',
                                                textAlign: TextAlign.right,
                                                style: TextStyle(
                                                  fontFamily: 'AirStripArabic',
                                                  fontSize: w * 0.032,
                                                  color: theme.textTheme.bodyMedium?.color,
                                                ),
                                              ),
                                              const SizedBox(width: 6),
                                              Container(
                                                width: 12,
                                                height: 12,
                                                decoration: const BoxDecoration(color: Colors.orange, shape: BoxShape.circle),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            const SizedBox(height: 14),
                            // Search Button
                            if (locationState.currentLocation != null && locationState.destination != null)
                              Padding(
                                padding: const EdgeInsets.only(bottom: 14),
                                child: ElevatedButton(
                                  onPressed: () {
                                    final criteria = BusSearchCriteria(
                                      from: locationState.currentLocation!.name,
                                      to: locationState.destination!.name,
                                      fromId: locationState.currentLocation!.id,
                                      toId: locationState.destination!.id,
                                      date: DateTime.now(),
                                    );
                                    context.push('/home/results', extra: criteria);
                                  },
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: const Color(0xFF1570EF),
                                    padding: const EdgeInsets.symmetric(vertical: 14),
                                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                                  ),
                                  child: const Text("بحث عن رحلات", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                                ),
                              ),
                            Container(
                              padding: const EdgeInsets.all(12),
                              decoration: BoxDecoration(
                                color: theme.cardTheme.color,
                                borderRadius: BorderRadius.circular(12),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black.withOpacity(0.03),
                                    blurRadius: 8,
                                    offset: const Offset(0, 4),
                                  ),
                                ],
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.stretch,
                                children: [
                                  Text(
                                    'المواقع المقترحة',
                                    textAlign: TextAlign.right,
                                    style: TextStyle(
                                      fontFamily: 'AirStripArabic',
                                      fontSize: w * 0.036,
                                      fontWeight: FontWeight.w700,
                                      color: AppColors.textSave,
                                    ),
                                  ),
                                  const SizedBox(height: 12),
                                  SizedBox(
                                    height: 48,
                                    child: ListView.separated(
                                      scrollDirection: Axis.horizontal,
                                      itemCount: savedPlaces.length,
                                      separatorBuilder: (_, __) => const SizedBox(width: 10),
                                      itemBuilder: (context, idx) {
                                        final item = savedPlaces[idx];
                                        return InkWell(
                                          onTap: () {
                                            final loc = LocationModel(
                                              id: item['id'] ?? '0',
                                              name: item['label'],
                                              description: item['city'] ?? '',
                                            );
                                            ref.read(searchLocationProvider.notifier).updateDestination(loc);
                                          },
                                          child: Container(
                                            padding: const EdgeInsets.symmetric(horizontal: 14),
                                            decoration: BoxDecoration(
                                              color: isDark ? Colors.white.withOpacity(0.05) : Colors.grey.shade50,
                                              borderRadius: BorderRadius.circular(10),
                                              border: Border.all(color: isDark ? Colors.white.withOpacity(0.1) : Colors.grey.shade200),
                                            ),
                                            child: Row(
                                              children: [
                                                Icon(item['icon'] as IconData, size: 18, color: primaryBlue),
                                                const SizedBox(width: 8),
                                                Text(
                                                  item['label'] as String,
                                                  style: TextStyle(
                                                    fontWeight: FontWeight.w700,
                                                    color: theme.textTheme.bodyLarge?.color,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        );
                                      },
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(height: 14),
                            Container(
                              padding: const EdgeInsets.all(12),
                              decoration: BoxDecoration(
                                color: theme.cardTheme.color,
                                borderRadius: BorderRadius.circular(12),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black.withOpacity(0.03),
                                    blurRadius: 8,
                                    offset: const Offset(0, 4),
                                  ),
                                ],
                              ),
                              child: Column(
                                children: [
                                  Align(
                                    alignment: Alignment.centerRight,
                                    child: Text(
                                      'عمليات البحث السابقة',
                                      textAlign: TextAlign.right,
                                      style: TextStyle(
                                        fontFamily: 'AirStripArabic',
                                        fontSize: w * 0.034,
                                        fontWeight: FontWeight.w700,
                                        color: theme.textTheme.bodyLarge?.color,
                                      ),
                                    ),
                                  ),
                                  const SizedBox(height: 12),
                                  Column(
                                    children: recentSearches.map((place) {
                                      return Padding(
                                        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 6),
                                        child: Row(
                                          children: [
                                            Expanded(
                                              child: Text(
                                                place,
                                                style: TextStyle(
                                                  fontSize: w * 0.034,
                                                  color: theme.textTheme.bodyMedium?.color,
                                                ),
                                              ),
                                            ),
                                            const SizedBox(width: 8),
                                            Icon(Icons.access_time, size: 18, color: theme.iconTheme.color?.withOpacity(0.5)),
                                          ],
                                        ),
                                      );
                                    }).toList(),
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(height: 36),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
