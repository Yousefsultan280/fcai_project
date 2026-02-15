import 'package:fcai_project/homeScreen_pages/record_page.dart';
import 'package:fcai_project/homeScreen_pages/profile_page.dart';
import 'package:fcai_project/homeScreen_pages/result_page.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  List<Widget> screens=[RecordPage(),ResultPage(),ProfilePage()];
int currentindex=0;
  @override
  Widget build(BuildContext context) {
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
         BottomNavigationBarItem(icon: Icon(Icons.home,size: 35,),label: "Home",),
         BottomNavigationBarItem(icon: Icon(Icons.paste,size: 30),label: "Result",),
         BottomNavigationBarItem(icon: Icon(Icons.person,size: 35),label: "Profile",),
       ])
    );
  }
}
