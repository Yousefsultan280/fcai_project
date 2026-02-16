
import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
   CustomButton({
    super.key,
    required this.onTap,
    required this.text,
  });

  final void Function() onTap;
  String text;

  @override
  Widget build(BuildContext context) {
    double hei = MediaQuery.of(context).size.height;
    return InkWell(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        height: hei * .08,
        decoration: BoxDecoration(
          color: Color(0xff2563eb),
          borderRadius: BorderRadius.circular(16),
        ),
        child: Center(
          child: Text(
            text,
            style: TextStyle(color: Colors.white, fontSize: 25),
          ),
        ),
      ),
    );
  }
}
