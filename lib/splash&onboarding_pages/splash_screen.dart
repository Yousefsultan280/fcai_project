import 'dart:async';
import 'package:flutter/material.dart';
import 'onboarding_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  @override
  void initState() {
    super.initState();


    Timer(const Duration(seconds: 4), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => OnboardingScreen(),
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [

            Container(
              width: double.infinity,

              child: const Center(
                child: Image(
                  image: AssetImage('assets/images/pulmoscan_splash.png'),fit: BoxFit.fill,

                ),
              ),
            ),
        
            Container(
              width: double.infinity,
              height: 150,
              color: Color(0xff195dfc),

            ),
          ],
        ),
      ),
    );
  }
}
