import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rakhshak/constant.dart';
import 'package:rakhshak/model/emergency_contacts.dart';
import './view/home_page.dart';
import './view/contact_screen.dart';
import './view/dashboard.dart';
import './view/phone_mobile.dart';

void main() async {
  // WidgetsFlutterBinding.ensureInitialized();
  // await Permission.notification.isDenied.then((value) {
  //   if (value) {
  //     Permission.notification.request();
  //   }
  // });
  runApp(ChangeNotifierProvider(
      create: (context) => EmergencyContacts(), child: const MyApp()));


    
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  // This widget is the root of your application
  // .
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: backgroundColor),
        useMaterial3: true,
        primaryTextTheme: const TextTheme(
          headlineLarge: TextStyle(
              fontSize: 20, fontWeight: FontWeight.w500, color: Colors.black),
          bodySmall: TextStyle(
              fontSize: 16, fontWeight: FontWeight.w400, color: Colors.pink),
          bodyLarge: TextStyle(
              fontSize: 20, fontWeight: FontWeight.w400, color: Colors.black),
        ),
        scrollbarTheme: ScrollbarThemeData(
          trackVisibility: MaterialStateProperty.all(true),
          thumbVisibility: MaterialStateProperty.all(true),
        ),
      ),
      routes: {
        '/home': (context) => HomePage(),
        '/contacts': (context) => const ContactScreen(),
        '/dashboard': (context) => const Dashboard(),
        '/phone': (context) => PhoneMobile(),
      },
      home: HomePage(),
    );
  }
}
