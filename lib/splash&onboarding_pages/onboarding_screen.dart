import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../auth_pages/LoginScreen.dart';
import '../l10n/app_localizations.dart';


class OnboardingScreen extends StatefulWidget {
  @override
  _OnboardingScreenState createState() => _OnboardingScreenState();
}


class _OnboardingScreenState extends State<OnboardingScreen> {
  PageController _pageController = PageController();
  int _currentPage = 0;

  late final List<Map<String, String>> onboardingData = [
    {
      "image": "assets/images/Voice-control-rafiki.png",
      "title": AppLocalizations.of(context)!.onboarding_title_1,
      "subtitle": AppLocalizations.of(context)!.onboarding_subtitle_1
    },
    {
      "image": "assets/images/Data-extraction-pana.png",
      "title": AppLocalizations.of(context)!.onboarding_title_2,
      "subtitle":AppLocalizations.of(context)!.onboarding_subtitle_2
    },
    {
      "image": "assets/images/Resume-folder-pana.png",
      "title": AppLocalizations.of(context)!.onboarding_title_3,
      "subtitle":AppLocalizations.of(context)!.onboarding_subtitle_3
    },
  ];
  bool seenOnBoard=false;

  @override
  Widget build(BuildContext context) {
    var lang =AppLocalizations.of(context)!;
    return Scaffold(
      backgroundColor: Color(0xFFFFFFFF),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        actions: [
          TextButton(
            onPressed: () async{
              seenOnBoard=true;
              final prefs = await SharedPreferences.getInstance();
               await prefs.setBool("seenonboard",seenOnBoard);

              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => LoginScreen()),
              );
            },
            child: Text(
              lang.skip,
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
