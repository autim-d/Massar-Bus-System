import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});
  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> with SingleTickerProviderStateMixin {
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

    Future.delayed(const Duration(milliseconds: splashDurationMs), () async {
      await _animController.forward();
      if (!mounted) return;
      context.go('/onboarding');
    });
  }

  @override
  void dispose() {
    _animController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
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
                      'assets/images/logo.png',
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
