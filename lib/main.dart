
// wait abhi mobile connect kr rha thora time lega wait ye 2 command chlaya haia abi


import 'package:find_lost_app/Screens/splashScreen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'Screens/homescreen.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
  options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Lost and Found App',
      theme: ThemeData(
        textTheme: TextTheme(
          titleSmall: GoogleFonts.metrophobic(
            fontSize: 14,
            color: const Color(0xffb80924),
            fontWeight: FontWeight.bold,
          ),
          titleMedium: GoogleFonts.metrophobic(
            fontSize: 18,
            color: const Color(0xffb80924),
            fontWeight: FontWeight.bold,
          ),
          titleLarge: GoogleFonts.metrophobic(
            fontSize: 24,
            color: const Color(0xffb80924),
            fontWeight: FontWeight.bold,
          ),
          labelSmall: GoogleFonts.metrophobic(
            fontSize: 14,
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
          labelMedium: GoogleFonts.metrophobic(
            fontSize: 12,
            color: Colors.black,
            fontWeight: FontWeight.w500,
          ),
          headlineSmall: GoogleFonts.metrophobic(
            fontSize: 14,
            color: Colors.purple,
            fontWeight: FontWeight.bold,
          ),
          displaySmall: GoogleFonts.metrophobic(
            fontSize: 14,
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
          displayMedium: GoogleFonts.metrophobic(
            fontSize: 10,
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
          displayLarge: GoogleFonts.metrophobic(
            fontSize: 14,
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
          bodySmall:GoogleFonts.metrophobic(
            fontSize: 8,
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
        primarySwatch: Colors.blue,
      ),
      home: const SplashScreen(),
    );
  }
}
