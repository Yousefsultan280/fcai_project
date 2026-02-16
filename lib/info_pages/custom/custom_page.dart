import 'package:flutter/material.dart';

import 'CustomButton.dart';

class CustomPage extends StatelessWidget {
  CustomPage({
    super.key,
    required this.text,
    required this.des,
    required this.number,
  });

  final int number;
  final String text;
  final String des;
  @override
  Widget build(BuildContext context) {
    double hei = MediaQuery.of(context).size.height;
    double wid = MediaQuery.of(context).size.width;
    return Column(
      children: [
        SizedBox(height: hei * .06),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("${number}", style: TextStyle(color: Colors.black, fontSize: 25)),
            Text(" /4", style: TextStyle(color: Colors.grey, fontSize: 18)),
          ],
        ),
        SizedBox(height: hei * .01),
        Text(text, style: TextStyle(color: Colors.black, fontSize: 25)),
        Text(des, style: TextStyle(color: Colors.grey[600], fontSize: 18)),
      ],
    );
  }
}
