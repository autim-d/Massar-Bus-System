import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
//import 'package:massar_project/Pages/OrderSummary.dart';
import 'package:massar_project/Pages/tickect_screen.dart';






void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
    locale: const Locale('ar', ''), 
      supportedLocales: const [
        Locale('ar', ''), // Arabic
        Locale('en', ''), // English (optional)
      ],
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],

        home :TicketScreen(),
      
    );
  }
}
  
  

