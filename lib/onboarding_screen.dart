import 'package:flutter/material.dart';
import 'LoginScreen.dart';

class OnboardingScreen extends StatefulWidget {
  @override
  _OnboardingScreenState createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  PageController _pageController = PageController();
  int _currentPage = 0;

  final List<Map<String, String>> onboardingData = [
    {
      "image": "assets/images/onboarding1.PNG",
      "title": "Consultation with a Doctor",
      "subtitle": "We help patients manage and schedule appointment with the Doctors..."
    },
    {
      "image": "assets/images/onboarding2.PNG",
      "title": "Buy Medications at a discount",
      "subtitle": "We help patients to choose the right medical treatment..."
    },
    {
      "image": "assets/images/onboarding3.PNG",
      "title": "Keep EHR files in one place",
      "subtitle": "Our vision is to improve the way of the world..."
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFFFFFFF),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        actions: [
          TextButton(
            onPressed: () {
              // هنا هننقلك لصفحة Login
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => LoginScreen()),
              );
            },
            child: Text(
              "Skip",
              style: TextStyle(color: Colors.blue, fontSize: 16),
            ),
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: PageView.builder(
              controller: _pageController,
              onPageChanged: (index) {
                setState(() {
                  _currentPage = index;
                });
              },
              itemCount: onboardingData.length,
              itemBuilder: (context, index) {
                return Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      height: 380,
                      child: Image.asset(
                        onboardingData[index]["image"]!,
                        fit: BoxFit.cover,
                      ),
                    ),

                    SizedBox(height: 20),
                    Text(
                      onboardingData[index]["title"]!,
                      style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.black),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: 10),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 30),
                      child: Text(
                        onboardingData[index]["subtitle"]!,
                        style: TextStyle(fontSize: 16, color: Colors.grey[700]),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ],
                );
              },
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(
              onboardingData.length,
                  (index) => AnimatedContainer(
                duration: Duration(milliseconds: 300),
                margin: EdgeInsets.symmetric(horizontal: 5, vertical: 20),
                width: _currentPage == index ? 20 : 8,
                height: 8,
                decoration: BoxDecoration(
                  color: _currentPage == index ? Colors.blue : Colors.grey[400],
                  borderRadius: BorderRadius.circular(5),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
