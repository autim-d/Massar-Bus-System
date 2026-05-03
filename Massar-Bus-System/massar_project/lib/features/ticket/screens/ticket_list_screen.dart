import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:massar_project/core/theme/app_colors.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:geolocator/geolocator.dart';
import 'package:massar_project/core/widgets/location_map_card.dart';
import 'package:massar_project/core/constants/api_constants.dart';

class TicketListScreen extends StatefulWidget {
  const TicketListScreen({super.key});
  @override
  State<TicketListScreen> createState() => _TicketListScreenState();
}

class _TicketListScreenState extends State<TicketListScreen> {
  Position? _currentPosition;
  String _locationName = 'جاري تحديد الموقع...';
  bool _isLoadingLocation = true;

  @override
  void initState() {
    super.initState();
    _determinePosition();
  }

  Future<void> _determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      if (mounted) setState(() => _isLoadingLocation = false);
      return;
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        if (mounted) setState(() => _isLoadingLocation = false);
        return;
      }
    }
    
    if (permission == LocationPermission.deniedForever) {
      if (mounted) setState(() => _isLoadingLocation = false);
      return;
    } 

    final position = await Geolocator.getCurrentPosition();
    if (mounted) {
      setState(() {
        _currentPosition = position;
      });
      _getPlaceName(position.latitude, position.longitude);
    }
  }

  Future<void> _getPlaceName(double lat, double lng) async {
    try {
      final url = 'https://api.mapbox.com/geocoding/v5/mapbox.places/$lng,$lat.json?access_token=${ApiConstants.mapboxPublicToken}&language=ar';
      final response = await http.get(Uri.parse(url));
      
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        if (data['features'] != null && data['features'].isNotEmpty) {
          final placeName = data['features'][0]['place_name'];
          if (mounted) {
            setState(() {
              _locationName = placeName;
              _isLoadingLocation = false;
            });
          }
          return;
        }
      }
      if (mounted) setState(() => _locationName = 'موقع مجهول');
    } catch (e) {
      if (mounted) setState(() => _locationName = 'خطأ في تحديد الموقع');
    } finally {
      if (mounted) setState(() => _isLoadingLocation = false);
    }
  }

  final List<Map<String, dynamic>> savedPlaces = [
    {'label': 'بيتنا', 'icon': Icons.home},
    {'label': 'مكتبي', 'icon': Icons.work},
    {'label': 'أحمد', 'icon': Icons.person},
  ];

  final List<String> recentSearches = [
    'Monumen Nasional',
    'Central Park Mall',
    'Stasiun Gambir',
  ];

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
                            'صباح الخير يا خليل',
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
                        LocationMapCard(
                          title: 'موقعك الحالي',
                          locationDetails: _locationName,
                          position: _currentPosition,
                          mapboxPublicToken: ApiConstants.mapboxPublicToken,
                          isLoading: _isLoadingLocation,
                        ),
                        const SizedBox(height: 14),
                        GestureDetector(
                          onTap: () {},
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 12,
                              vertical: 14,
                            ),
                            decoration: BoxDecoration(
                              color: theme.cardTheme.color,
                              borderRadius: BorderRadius.circular(12),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withValues(alpha: 0.03),
                                  blurRadius: 8,
                                  offset: const Offset(0, 4),
                                ),
                              ],
                            ),
                            child: Row(
                              children: [
                                Container(
                                  width: 36,
                                  height: 36,
                                  decoration: BoxDecoration(
                                    color: isDark
                                        ? Colors.white.withValues(alpha: 0.05)
                                        : Colors.grey.shade100,
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  child: IconButton(
                                    icon: Icon(
                                      Icons.chevron_left,
                                      color: theme.iconTheme.color,
                                    ),
                                    onPressed: () {
                                      context.push('/home/location');
                                    },
                                  ),
                                ),
                                const SizedBox(width: 12),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.stretch,
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
                                        children: [
                                          Container(
                                            width: 12,
                                            height: 12,
                                            decoration: const BoxDecoration(
                                              color: Colors.orange,
                                              shape: BoxShape.circle,
                                            ),
                                          ),
                                          const SizedBox(width: 6),
                                          Expanded(
                                            child: Text(
                                              'حدد الموقع',
                                              textAlign: TextAlign.right,
                                              style: TextStyle(
                                                fontFamily: 'AirStripArabic',
                                                fontSize: w * 0.032,
                                                color: theme.textTheme.bodyMedium?.color,
                                              ),
                                            ),
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
                        Container(
                          padding: const EdgeInsets.fromLTRB(12, 12, 12, 12),
                          decoration: BoxDecoration(
                            color: theme.cardTheme.color,
                            borderRadius: BorderRadius.circular(12),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withValues(alpha: 0.03),
                                blurRadius: 8,
                                offset: const Offset(0, 4),
                              ),
                            ],
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              Text(
                                'الموقع المحفوظ',
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
                                  itemCount: savedPlaces.length + 1,
                                  separatorBuilder: (_, __) =>
                                      const SizedBox(width: 10),
                                  itemBuilder: (context, idx) {
                                    if (idx < savedPlaces.length) {
                                      final item = savedPlaces[idx];
                                      return InkWell(
                                        onTap: () {},
                                        child: Container(
                                          padding: const EdgeInsets.symmetric(
                                            horizontal: 14,
                                          ),
                                          decoration: BoxDecoration(
                                            color: isDark
                                                ? Colors.white.withValues(alpha: 0.05)
                                                : Colors.grey.shade50,
                                            borderRadius: BorderRadius.circular(
                                              10,
                                            ),
                                            border: Border.all(
                                              color: isDark
                                                  ? Colors.white.withValues(alpha: 0.1)
                                                  : Colors.grey.shade200,
                                            ),
                                          ),
                                          child: Row(
                                            children: [
                                              Icon(
                                                item['icon'] as IconData,
                                                size: 18,
                                                color: primaryBlue,
                                              ),
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
                                    } else {
                                      return InkWell(
                                        onTap: () {},
                                        child: Container(
                                          width: 44,
                                          height: 44,
                                          decoration: BoxDecoration(
                                            color: theme.cardTheme.color,
                                            borderRadius: BorderRadius.circular(
                                              12,
                                            ),
                                            border: Border.all(
                                              color: isDark
                                                  ? Colors.white.withValues(alpha: 0.1)
                                                  : Colors.grey.shade200,
                                            ),
                                            boxShadow: [
                                              BoxShadow(
                                                color: Colors.black.withOpacity(
                                                  0.02,
                                                ),
                                                blurRadius: 6,
                                                offset: const Offset(0, 2),
                                              ),
                                            ],
                                          ),
                                          child: Icon(
                                            Icons.arrow_forward_ios,
                                            size: 18,
                                            color: theme.iconTheme.color,
                                          ),
                                        ),
                                      );
                                    }
                                  },
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 14),
                        Container(
                          padding: const EdgeInsets.symmetric(
                            vertical: 14,
                            horizontal: 12,
                          ),
                          decoration: BoxDecoration(
                            color: theme.cardTheme.color,
                            borderRadius: BorderRadius.circular(12),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withValues(alpha: 0.03),
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
                                  'عمليات البحث السابقة الخاصة بك',
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
                                    padding: const EdgeInsets.symmetric(
                                      vertical: 10,
                                      horizontal: 6,
                                    ),
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
                                        Icon(
                                          Icons.access_time,
                                          size: 18,
                                          color: theme.iconTheme.color?.withValues(alpha: 0.5),
                                        ),
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
  }
}
