import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:massar_project/features/auth/screens/splash_screen.dart';
import 'package:massar_project/core/routing/app_router.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:massar_project/features/auth/bloc/auth_bloc.dart';
import 'package:massar_project/features/ticket/bloc/checkout_bloc.dart';
import 'package:massar_project/features/ticket/bloc/ticket_status_bloc/ticket_status_bloc.dart';

import 'package:firebase_core/firebase_core.dart';
import 'package:massar_project/firebase_options.dart';
import 'package:massar_project/repositories/auth_repository.dart';
import 'package:massar_project/core/repositories/booking_repository.dart';
import 'package:massar_project/core/repositories/payment_repository.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  Animate.restartOnHotReload = true;

  // 1. ProviderScope يجب أن يكون هو الطبقة الخارجية تماماً لتهيئة Riverpod
  runApp(const ProviderScope(child: MyApp()));
}

// 2. تحويل MyApp إلى ConsumerWidget لكي يمنحنا الوصول لـ WidgetRef ref
class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // 3. وضع MultiBlocProvider داخل الـ build لكي يتمكن من رؤية الـ ref
    return MultiBlocProvider(
      providers: [
        BlocProvider<AuthBloc>(
          create: (context) => AuthBloc(
            // الآن كلمة ref معرفة وتعمل بدون أي أخطاء!
            authRepository: ref.read(authRepositoryProvider),
          ),
        ),
        BlocProvider<CheckoutBloc>(
          create: (context) => CheckoutBloc(
            ref.read(bookingRepositoryProvider),
            ref.read(paymentRepositoryProvider),
          ),
        ),
        BlocProvider<TicketStatusBloc>(
          create: (context) => TicketStatusBloc(ref.read(bookingRepositoryProvider))
            ..add(LoadTicketStatuses()),
        ),
      ],
      child: MaterialApp.router(
        title: 'Masar Smart Transportation',
        locale: const Locale('ar', ''),
        supportedLocales: const [
          Locale('ar', ''), // Arabic
          Locale('en', ''), // English
        ],
        localizationsDelegates: const [
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          fontFamily: 'ReadexPro',
          primarySwatch: Colors.blue,
        ),
        routerConfig: appRouter,
      ),
    );
  }
}
