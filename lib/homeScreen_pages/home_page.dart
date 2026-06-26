import 'package:fcai_project/homeScreen_pages/record_page.dart';
import 'package:fcai_project/homeScreen_pages/profile/profile_page.dart';
import 'package:fcai_project/homeScreen_pages/result_page.dart';
import 'package:flutter/material.dart';

import '../l10n/app_localizations.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late List<Widget> screens;
  @override
  void initState() {
    super.initState();
    screens=[RecordPage()
      ,ProfilePage()];

  }

int currentindex=0;
  @override
  Widget build(BuildContext context) {
     var lang=AppLocalizations.of(context)!;

    return Scaffold(
      body: screens[currentindex],
       bottomNavigationBar:BottomNavigationBar(
         backgroundColor: Colors.white,
         onTap: (value){
           setState(() {
             currentindex=value;
           });
         },
           currentIndex:currentindex,
           selectedItemColor: Color(0xff1d4ed8),
           selectedFontSize: 16,
           unselectedFontSize: 14,
           items: [
         BottomNavigationBarItem(icon: Icon(Icons.home,size: 35,),label: lang.home,),
         BottomNavigationBarItem(icon: Icon(Icons.person,size: 35),label: lang.my_profile,),
       ])
    );
  }
}
