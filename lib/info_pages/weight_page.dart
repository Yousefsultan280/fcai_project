import 'package:fcai_project/info_pages/gender_page.dart';

import 'custom/CustomButton.dart';
import 'custom/custom_page.dart';
import 'package:flutter/material.dart';

class WeightPage extends StatefulWidget {
  const WeightPage({super.key});

  @override
  State<WeightPage> createState() => _WeightPageState();
}

class _WeightPageState extends State<WeightPage> {
  int weight=20;
  @override
  Widget build(BuildContext context) {
    double hei = MediaQuery.of(context).size.height;
    double wid = MediaQuery.of(context).size.width;

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 60),
        child: Column(
          children: [
            CustomPage(text: "What's your weight?", des: "Let's get to know your weight.", number: 2),
            SizedBox(height:hei*.01 ,),
            Container(
              width: wid*.12,
              height: hei*.05,
              decoration: BoxDecoration(border: Border.all(color: Color(0xff2563eb),width: 2,),borderRadius: BorderRadius.circular(16)),
              child:Center(child: Text("${weight}",style: TextStyle(fontSize: 25),)) ,),
            SizedBox(height:hei*.01 ,),
            Slider(value: weight.toDouble(),
                min: 20,
                max: 150,
                divisions:130 ,
                activeColor: Color(0xff2563eb),
                label: "${weight}",
                onChanged: (double newage){

                  setState(() {
                    weight=newage.round();
                  });
                }),
            Spacer(),
            CustomButton(onTap: (){
              Navigator.push(context, MaterialPageRoute(builder: (context) => GenderPage()));
            },text: "Countinue",)
          ],
        ),
      ),
    );
  }
}
