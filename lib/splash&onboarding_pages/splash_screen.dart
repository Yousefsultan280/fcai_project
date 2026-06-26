import 'dart:async';
import 'package:fcai_project/auth_pages/LoginScreen.dart';
import 'package:fcai_project/homeScreen_pages/home_page.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
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
    timer();
  }

  Timer timer() {
    return Timer(const Duration(seconds: 4), () async {
      final pref1 = await SharedPreferences.getInstance();
      final seen = pref1.getBool("seenonboard") ?? false;

      // final pref=await SharedPreferences.getInstance();
      // final token= pref.getString("token");

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => seen ? LoginScreen() : OnboardingScreen(),
        ),
      );
    });
  }
  // if(token!=null && token.isNotEmpty){
  //   Navigator.pushReplacement(
  //     context,
  //     MaterialPageRoute(
  //       builder: (context) =>HomePage(),
  //     ),
  //   );
  // }
  //else {

  //     }
  // });

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
                  image: AssetImage('assets/images/pulmoscan_splash.png'),
                  fit: BoxFit.fill,
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
