import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart'; // أضف هذا
import 'package:go_router/go_router.dart';
import 'package:massar_project/features/auth/bloc/auth_bloc.dart';
import 'package:massar_project/features/auth/bloc/auth_state.dart';
import 'package:massar_project/features/auth/bloc/auth_event.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});
  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  static const int splashDurationMs = 2500;
  late AnimationController _animController;
  late Animation<double> _opacityAnim;

  @override
  void initState() {
    super.initState();
    _animController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 400),
    );
    _opacityAnim = CurvedAnimation(
      parent: _animController,
      curve: Curves.easeInOut,
    );

    _navigateToNext();
  }

  // دالة اتخاذ القرار للربط بالباك إند
  void _navigateToNext() async {
    // 1. انتظر وقت الشاشة الافتراضي
    await Future.delayed(const Duration(milliseconds: splashDurationMs));

    if (!mounted) return;

    // 2. تفعيل أنيميشن الاختفاء
    await _animController.forward();

    // 3. الربط بالمنطق: فحص حالة المستخدم الحالية من الـ BLoC
    final authState = context.read<AuthBloc>().state;

    if (authState is AuthAuthenticated) {
      // إذا كان مسجل دخول فعلاً (التوكن موجود وصحيح)
      // إذا كان المستخدم مسجلاً بالفعل، نطلب بياناته فوراً لتحديث الهوم
      context.read<AuthBloc>().add(const GetUserDataEvent());
      context.go('/home');
    } else {
      // إذا كان مستخدم جديد أو لم يسجل دخوله
      context.go('/onboarding');
    }
  }

  @override
  void dispose() {
    _animController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // ... [باقي كود الواجهة كما هو بدون تغيير] ...
    const backgroundColor = Color(0xFF2563EB);

    return Scaffold(
      backgroundColor: backgroundColor,
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            final screenW = constraints.maxWidth;
            final logoWidth = screenW * 0.224;
            final logoHeight = logoWidth;
            final titleFontSize = screenW * 0.096;
            final subtitleFontSize = screenW * 0.037;
            final spacingBetween = screenW * 0.048;
            final spinnerSize = screenW * 0.053;

            return Center(
              child: FadeTransition(
                opacity: ReverseAnimation(_opacityAnim),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  textDirection: TextDirection.ltr,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Image.asset(
                      'assets/images/logo.png', // تأكد من وجود الشعار فيassets
                      width: logoWidth,
                      height: logoHeight,
                      fit: BoxFit.contain,
                    ),
                    SizedBox(width: spacingBetween),
                    Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'مســـــــــــــــــار',
                          textDirection: TextDirection.rtl,
                          style: TextStyle(
                            fontFamily: 'AirStrip',
                            fontSize: titleFontSize,
                            fontWeight: FontWeight.w700,
                            color: Colors.white,
                            height: 1.0,
                          ),
                        ),
                        SizedBox(height: screenW * 0.016),
                        Text(
                          'المواصلات الذكية',
                          textDirection: TextDirection.rtl,
                          style: TextStyle(
                            fontFamily: 'air',
                            fontSize: subtitleFontSize,
                            fontWeight: FontWeight.w500,
                            color: Colors.white70,
                          ),
                        ),
                        SizedBox(height: screenW * 0.037),
                        SizedBox(
                          width: spinnerSize,
                          height: spinnerSize,
                          child: CircularProgressIndicator(
                            strokeWidth: spinnerSize * 0.12,
                            valueColor: const AlwaysStoppedAnimation<Color>(
                              Colors.white,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
