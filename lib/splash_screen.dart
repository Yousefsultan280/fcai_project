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

   Timer(const Duration(seconds: 3), () {
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
      backgroundColor: const Color(0xFF3E64F0),
      body: Stack(
        children: [

          // icons
          _circleIcon(top: 70, left: 40, image: 'capsules.png'),
          _circleIcon(top: 160, right: 30, image: 'medicine.png'),
          _circleIcon(bottom: 140, left: 30, image: 'doctor-consultation.png'),
          _circleIcon(bottom: 90, right: 50, image: 'healthcare.png'),
          _circleIcon(top: 260, left: 120, image: 'healthcare(1).png'),
          _circleIcon(bottom: 260, right: 120, image: 'medical-report.png'),

          // center logo
          Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Image.asset(
                  'assets/images/iconsplash.PNG',
                  width: 130,
                ),
                const SizedBox(height: 20),
                const Text(
                  'COMEDICS',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 2,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _circleIcon({
    double? top,
    double? bottom,
    double? left,
    double? right,
    required String image,
    double? imageSize, // حجم الصورة داخل الدائرة
  }) {
    return Positioned(
      top: top,
      bottom: bottom,
      left: left,
      right: right,
      child: Container(
        width: 60,
        height: 60,
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.25),
          shape: BoxShape.circle,
        ),
        child: Center(
          child: Image.asset(
            'assets/images/$image',
            width: imageSize ?? 50,
            height: imageSize ?? 50,
            fit: BoxFit.contain,
          ),
        ),
      ),
    );
  }

}
