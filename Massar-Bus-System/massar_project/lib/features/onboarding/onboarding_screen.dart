import 'dart:async';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../core/theme/app_colors.dart';

import 'widgets/onboarding_header.dart';
import 'widgets/onboarding_page.dart';
import 'widgets/pill_indicator.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({Key? key}) : super(key: key);

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _pageController = PageController();
  int _currentPage = 0;
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _startAutoScroll();
  }

  @override
  void dispose() {
    _timer?.cancel();
    _pageController.dispose();
    super.dispose();
  }

  void _startAutoScroll() {
    _timer = Timer.periodic(const Duration(seconds: 2), (timer) {
      if (_currentPage < _onboardingData.length - 1) {
        _pageController.nextPage(
          duration: const Duration(milliseconds: 600),
          curve: Curves.easeInOut,
        );
      } else {
        _timer?.cancel();
      }
    });
  }

  final List<Map<String, String>> _onboardingData = [
    {
      'title': 'مرحبا بك',
      'description': 'تطبيق مسار يسهل لك حجز تذاكر الحافلات بسرعة وأمان.',
      'image': 'assets/images/Illustration Buy Ticket Anywhere.png',
    },
    {
      'title': 'تتبع مسارك',
      'description': 'تتبع مسار الحافلة بسهولة ومعرفة وقت الوصول.',
      'image': 'assets/images/Illustration Plan Trip.png',
    },
    {
      'title': 'حجز التذاكر',
      'description': 'احجز تذكرتك من مكانك بخطوات بسيطة.',
      'image': 'assets/images/Illustration Buy Ticket .png',
    },
  ];

  Future<void> _completeOnboarding(BuildContext context) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('show_onboarding', false);
    if (context.mounted) {
      context.go('/login');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primaryBlue,
      body: Stack(
        children: [
          // Background Decorative Elements (Optional dots/shapes if needed)
          Positioned(
            top: -50,
            left: -50,
            child: _buildDecorativeDot(100, Colors.white.withValues(alpha: 0.05)),
          ),
          Positioned(
            bottom: 100,
            right: -30,
            child: _buildDecorativeDot(80, Colors.white.withValues(alpha: 0.05)),
          ),

          SafeArea(
            child: Column(
              children: [
                // Header
                const OnboardingHeader(),

                // Page Content
                Expanded(
                  child: PageView.builder(
                    controller: _pageController,
                    onPageChanged: (index) {
                      setState(() {
                        _currentPage = index;
                      });
                      _timer?.cancel();
                      _startAutoScroll();
                    },
                    itemCount: _onboardingData.length,
                    itemBuilder: (context, index) {
                      return OnboardingPage(
                        title: _onboardingData[index]['title']!,
                        description: _onboardingData[index]['description']!,
                        imagePath: _onboardingData[index]['image']!,
                      );
                    },
                  ),
                ),

                const SizedBox(height: 16),

                // Page Indicator
                PillIndicator(
                  count: _onboardingData.length,
                  currentIndex: _currentPage,
                ),

                const SizedBox(height: 48),

                // Bottom Navigation Buttons
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 24),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      // Skip Button
                      SizedBox(
                        width: 120,
                        height: 52,
                        child: OutlinedButton(
                          onPressed: () => _completeOnboarding(context),
                          style: OutlinedButton.styleFrom(
                            side: const BorderSide(color: Colors.white, width: 1.2),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                          child: const Text(
                            'تخطي',
                            style: TextStyle(
                              fontFamily: 'ReadexPro',
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),

                      // Next / Get Started Button
                      SizedBox(
                        width: 120,
                        height: 52,
                        child: ElevatedButton(
                          onPressed: () {
                            if (_currentPage < _onboardingData.length - 1) {
                              _pageController.nextPage(
                                duration: const Duration(milliseconds: 400),
                                curve: Curves.easeInOut,
                              );
                            } else {
                              _completeOnboarding(context);
                            }
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppColors.secondaryOrange,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            elevation: 0,
                          ),
                          child: Text(
                            _currentPage == _onboardingData.length - 1
                                ? 'ابدأ'
                                : 'التالي',
                            style: const TextStyle(
                              fontFamily: 'ReadexPro',
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDecorativeDot(double size, Color color) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        color: color,
        shape: BoxShape.circle,
      ),
    );
  }
}
