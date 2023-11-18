import 'package:flutter/material.dart';
import '../view/home_page.dart';
import 'package:easy_splash_screen/easy_splash_screen.dart';
import '../constant.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => SplashState();
}

class SplashState extends State<SplashScreen> {
  Future<Widget> checkFirstSeen() async {
    return Future.delayed(const Duration(seconds: 3), () {
      return HomePage();
    });
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final height = size.height;

    final width = size.width;

    // Calculate the logo height and logo width based on screen size
    final logoHeight = height * 0.65;
    final logoWidth = width * 0.95;

    return EasySplashScreen(
      logo: Image.asset(
        'assets/logo_transparent.png',
        height: logoHeight,
        width: logoWidth,
        fit: BoxFit.contain,
      ),
      backgroundColor: Colors.white,
      showLoader: true,
      loadingText: const Text("Loading..."),
      futureNavigator: checkFirstSeen(),
    );
  }
}
