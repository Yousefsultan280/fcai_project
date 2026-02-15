
import 'package:flutter/material.dart';
import 'custom/CustomButton.dart';
import 'custom/custom_page.dart';

class AgePage extends StatefulWidget {
  const AgePage({super.key});

  @override
  State<AgePage> createState() => _AgePageState();
}

class _AgePageState extends State<AgePage> {
  int age=1;
  @override
  Widget build(BuildContext context) {
    double hei = MediaQuery.of(context).size.height;
    double wid = MediaQuery.of(context).size.width;

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 60),
        child: Column(
          children: [
            CustomPage(text: "How Old Are You?", des: "Let's get to know your age.", number: 1),
            SizedBox(height:hei*.01 ,),
            Container(
              width: wid*.12,
              height: hei*.05,
              decoration: BoxDecoration(border: Border.all(color: Color(0xff2563eb),width: 2,),borderRadius: BorderRadius.circular(16)),
              child:Center(child: Text("${age}",style: TextStyle(fontSize: 25),)) ,),
            SizedBox(height:hei*.01 ,),
            Slider(value: age.toDouble(),
                min: 1,
                max: 100,
                divisions:100 ,
                activeColor: Color(0xff2563eb),
                label: "${age}",
                onChanged: (double newage){

              setState(() {
                age=newage.round();
              });
                }),
            Spacer(),
            CustomButton(onTap: (){}, text: "Countinue")
          ],
        ),
      ),
    );
  }
}
