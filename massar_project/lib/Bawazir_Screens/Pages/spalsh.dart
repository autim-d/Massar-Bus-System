import 'package:flutter/material.dart';
import 'package:massar_project/Bawazir_Screens/Pages/login.dart';
// import 'package:massar_project/main.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'مسار',
      
      debugShowCheckedModeBanner: false,
      home: const Directionality(
        textDirection: TextDirection.rtl,
        child: splash(),
      ),
    );
  }
}

class splash extends StatefulWidget {
  const splash({super.key});
  @override
  State<splash> createState() => _splashState();
}

class _splashState extends State<splash> with SingleTickerProviderStateMixin {
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
      Navigator.of(context).pushReplacement(
        PageRouteBuilder(
          transitionDuration: const Duration(milliseconds: 450),
          pageBuilder: (_, __, ___) => const login(),
          transitionsBuilder: (_, animation, __, child) {
            return FadeTransition(opacity: animation, child: child);
          },
        ),
      );
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
            // شاشة التصميم الأصلية كانت 375px عرض -> نستخدم نسب منه
            final screenW = constraints.maxWidth;
            final logoWidth = screenW * 0.224; // ~84/375
            final logoHeight = logoWidth;
            final titleFontSize = screenW * 0.096; // ~36/375
            final subtitleFontSize = screenW * 0.037; // ~14/375
            final spacingBetween = screenW * 0.048; // ~18/375
            final spinnerSize = screenW * 0.053; // ~20/375

            return Center(
              child: FadeTransition(
                opacity: ReverseAnimation(_opacityAnim),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  textDirection:
                      TextDirection.ltr, // to keep order: logo -> texts
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    // اللوغو
                    Image.asset(
                      'assets/images/logo.png',
                      width: logoWidth,
                      height: logoHeight,
                      fit: BoxFit.contain,
                    ),

                    SizedBox(width: spacingBetween),

                    // النصوص و spinner
                    Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // العنوان
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

                        SizedBox(height: screenW * 0.016), // small gap
                        // الوصف الصغير
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

                        // مؤشر التحميل (Spinner)
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

class HomePage extends StatelessWidget {
  const HomePage({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('الرئيسية', textDirection: TextDirection.rtl),
        backgroundColor: const Color(0xFF2563EB),
      ),
      body: const Center(
        child: Text(
          'محتوى التطبيق الرئيسي هنا',
          textDirection: TextDirection.rtl,
        ),
      ),
    );
  }
}
