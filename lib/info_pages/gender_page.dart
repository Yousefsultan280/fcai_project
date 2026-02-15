import 'custom/CustomButton.dart';
import 'custom/custom_page.dart';
import 'package:flutter/material.dart';

class GenderPage extends StatefulWidget {
  const GenderPage({super.key});

  @override
  State<GenderPage> createState() => _GenderPageState();
}

class _GenderPageState extends State<GenderPage> {
  bool sel1=false;
  bool sel2=false;
  @override
  Widget build(BuildContext context) {
    double hei = MediaQuery.of(context).size.height;
    double wid = MediaQuery.of(context).size.width;

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 60),
        child: Column(
          children: [
            CustomPage(text: "What's your gender?", des: "Let's get to know your gender.", number: 3),
            SizedBox(height:hei*.1 ,),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                InkWell(
                  onTap: (){
                    sel1=!sel1;
                    setState(() {});
                  },
                  child: Container(
                    width: wid*.3,
                    height: hei*.15,
                    decoration: BoxDecoration(color: Colors.grey[200],border: BoxBorder.all(width: sel1?3:1,color:sel1?Color(0xff2563eb):Colors.grey ),borderRadius: BorderRadius.circular(16)),
                    child: Center(child: Text("Male",style: TextStyle(color: Color(0xff2563eb),fontWeight: FontWeight.bold,fontSize: 26),)),
                  ),
                ),
                InkWell(
                  onTap: (){
                    sel2=!sel2;
                    setState(() {});
                  },
                  child: Container(
                    width: wid*.3,
                    height: hei*.15,
                    decoration: BoxDecoration(color: Colors.grey[200],border: BoxBorder.all(width: sel2?3:1,color:sel2?Color(0xff2563eb):Colors.grey),borderRadius: BorderRadius.circular(16)),
                    child: Center(child: Text("Female",style: TextStyle(color: Color(0xff2563eb),fontWeight: FontWeight.bold,fontSize: 26),)),
                  ),
                ),
              ],
            ),
            Spacer(),
            CustomButton(onTap: (){},text: "Countinue",)
          ],
        ),
      ),
    );
  }
}
