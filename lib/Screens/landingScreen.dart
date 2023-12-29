// ignore_for_file: prefer_const_constructors, file_names
import 'package:flutter/material.dart';
import '../widget/widget.dart';
import 'loginScreen.dart';

class LandingScreen extends StatefulWidget {
  const LandingScreen({super.key});

  @override
  State<LandingScreen> createState() => _LandingScreenState();
}

class _LandingScreenState extends State<LandingScreen> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text("Lost and Found App",
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.titleMedium),
        centerTitle: true,

      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [

            CircleAvatar(
              radius: 70,
              child: Image.asset(
                "assets/images/logo.png",
              ),
            ),

            Text("Find lost",
                style: Theme.of(context).textTheme.titleLarge
            ),
              SizedBox(height: 50),

            RoundedButton(
                child: Text("Login / Signup",
                    style: Theme.of(context).textTheme.displaySmall),
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => LoginScreen()));
                }),

          ],
        ),
      ),
    );
  }
}
