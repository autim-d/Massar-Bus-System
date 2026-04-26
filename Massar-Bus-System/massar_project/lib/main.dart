import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:massar_project/features/auth/screens/splash_screen.dart';
import 'package:massar_project/core/routing/app_router.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:massar_project/features/auth/bloc/auth_bloc.dart';
import 'package:massar_project/core/theme/bloc/theme_bloc.dart';
import 'package:massar_project/core/theme/bloc/theme_state.dart';
import 'package:massar_project/core/theme/bloc/theme_event.dart';
import 'package:massar_project/core/theme/app_theme.dart';
import 'package:massar_project/features/ticket/bloc/checkout_bloc.dart';
import 'package:massar_project/features/ticket/bloc/ticket_status_bloc/ticket_status_bloc.dart';

import 'package:firebase_core/firebase_core.dart';
import 'package:massar_project/firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  Animate.restartOnHotReload = true; 
  runApp(
    // Added ProviderScope for Riverpod State Management and MultiBlocProvider for BLoC
    MultiBlocProvider(
      providers: [
        BlocProvider<AuthBloc>(create: (context) => AuthBloc()),
        BlocProvider<ThemeBloc>(create: (context) => ThemeBloc()..add(const LoadTheme())),
        BlocProvider<CheckoutBloc>(create: (context) => CheckoutBloc()),
        BlocProvider<TicketStatusBloc>(create: (context) => TicketStatusBloc()..add(LoadTicketStatuses())),
      ],
      child: const ProviderScope(
        child: MyApp(),
      ),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeBloc, ThemeState>(
      builder: (context, themeState) {
        return MaterialApp.router(
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
          themeMode: themeState.themeMode,
          theme: AppTheme.lightTheme,
          darkTheme: AppTheme.darkTheme,
          routerConfig: appRouter,
        );
      },
    );
  }
}
