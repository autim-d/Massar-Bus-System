import 'dart:io';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

// الاستيرادات الخاصة بالمشروع
import '../widgets/home_header.dart';
import '../widgets/home_search_bar.dart';
import '../widgets/quick_action_section.dart';
import '../widgets/active_ticket_card.dart';
import '../../../../core/widgets/custom_drawer.dart';
import '../../auth/bloc/auth_bloc.dart';
import '../../auth/bloc/auth_event.dart'; // تأكد من استيراد ملف الأحداث
import '../../auth/bloc/auth_state.dart';

import '../../../../core/widgets/location_map_card.dart';
import '../../../../core/constants/api_constants.dart';
import 'package:geolocator/geolocator.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  Position? _currentPosition;
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
        _isLoadingLocation = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    // ─── استدعاء الحدث (Triggering the Event) ───
    // نقوم باستدعاء جلب بيانات المستخدم فور دخول الشاشة
    // لضمان تحديث الاسم وعدد الإشعارات من الباك أند
    context.read<AuthBloc>().add(GetUserDataEvent());

    return Directionality(
      textDirection:
          TextDirection.rtl, // ضمان دعم اللغة العربية من اليمين لليسار
      child: Scaffold(
        drawer: const CustomDrawer(),
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        body: Stack(
          children: [
            // خلفية نمط الخريطة الباهتة (Pattern Background)
            Positioned(
              top: 0,
              left: 0,
              right: 0,
              height: 250,
              child: Opacity(
                opacity: 0.1,
                child: Image.asset(
                  'assets/images/map.png',
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) =>
                      const SizedBox.shrink(),
                ),
              ),
            ),

            // المحتوى الرئيسي للشاشة
            SafeArea(
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    // 1. قسم الهيدر (Header) - مرتبط بحالة المصادقة
                    BlocBuilder<AuthBloc, AuthState>(
                      builder: (context, state) {
                        String name = 'زائر';
                        int unreadNotifications = 0;

                        if (state is AuthAuthenticated) {
                          // جلب البيانات الحقيقية من كائن المستخدم القادم من Laravel
                          name = state.user?.firstName ?? 'مستخدم مسار';
                          unreadNotifications =
                              state.user?.unreadNotificationsCount ?? 0;
                        } else if (state is AuthLoading) {
                          name = 'جاري التحميل...';
                        }

                        return HomeHeader(
                          notificationCount: unreadNotifications,
                          greeting: _getGreeting(),
                          userName: name,
                        );
                      },
                    ),

                    const SizedBox(height: 16),

                    // 2. شريط البحث (Search Bar)
                    HomeSearchBar(onTap: () => context.pushNamed('homeSearch')),

                    const SizedBox(height: 24),

                    // 3. بطاقة الموقع على الخريطة
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 24.0),
                      child: LocationMapCard(
                        title: 'موقعك الحالي',
                        locationDetails: _isLoadingLocation ? 'جاري تحديد الموقع...' : (_currentPosition != null ? null : 'لم نتمكن من تحديد الموقع'),
                        position: _currentPosition,
                        mapboxPublicToken: ApiConstants.mapboxPublicToken,
                        isLoading: _isLoadingLocation,
                      ),
                    ),
                    const SizedBox(height: 24),

                    // 4. قسم الإجراءات السريعة (Quick Action Section)
                    QuickActionSection(currentPosition: _currentPosition),

                    const SizedBox(height: 32),

                    // 5. بطاقة التذكرة النشطة (Active Ticket Card)
                    const ActiveTicketCard(),

                    const SizedBox(height: 48), // مساحة تباعد سفلية
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// دالة ذكية لتحديد التحية بناءً على وقت جهاز المستخدم
  String _getGreeting() {
    var hour = DateTime.now().hour;
    if (hour >= 5 && hour < 12) {
      return 'صباح الخير';
    } else if (hour >= 12 && hour < 21) {
      return 'مساء الخير';
    } else {
      return 'ليلة سعيدة';
    }
  }
}
