// ignore_for_file: file_names

import 'package:find_lost_app/Screens/homescreen.dart';
import 'package:flutter/material.dart';

import 'landingScreen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  void switchToSignInPage() {
    // Navigator.pushReplacement(context,
    //     MaterialPageRoute(builder: (context) => const HomeScreen()));
    Navigator.pushReplacement(context,
        MaterialPageRoute(builder: (context) => const LandingScreen()));
  }

  @override
  void initState() {
    // Timer(Duration(seconds: 10),() => switchToLoginPage());
    Future.delayed(const Duration(seconds: 3), switchToSignInPage);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: Color.fromARGB(25 5, 237, 194, 65).withOpacity(0.8),
      body: Center(
        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          Image.asset(
            "assets/images/logo.png",
            width: 260,
            height: 220,
          )
        ]),
      ),
    );
  }
}
