
import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  const CustomButton({
    super.key,
    required this.onTap,
  });

  final void Function() onTap;

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
            "Countinue",
            style: TextStyle(color: Colors.white, fontSize: 25),
          ),
        ),
      ),
    );
  }
}
