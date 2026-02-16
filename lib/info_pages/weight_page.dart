import 'package:flutter/material.dart';
import 'package:fcai_project/info_pages/gender_page.dart';

import 'custom/CustomButton.dart';
import 'custom/custom_page.dart';

class WeightPage extends StatefulWidget {
  const WeightPage({super.key});

  @override
  State<WeightPage> createState() => _WeightPageState();
}

class _WeightPageState extends State<WeightPage> {
  int weight = 60;

  @override
  Widget build(BuildContext context) {
    double hei = MediaQuery.of(context).size.height;
    double wid = MediaQuery.of(context).size.width;

    return Scaffold(
      body: Container(
        width: wid,
        height: hei,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xff1e3a8a), Color(0xff2563eb), Color(0xff60a5fa)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 60),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              CustomPage(
                text: "What's your weight?",
                des: "Let's get to know your weight.",
                number: 2,
              ),
              const SizedBox(height: 40),

              // Card Design for Weight Picker
              Container(
                padding: const EdgeInsets.all(25),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.85),
                  borderRadius: BorderRadius.circular(25),
                  border: Border.all(color: Colors.white24, width: 1.5),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.1),
                      blurRadius: 10,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    Text(
                      "$weight",
                      style: const TextStyle(
                        fontSize: 60,
                        fontWeight: FontWeight.bold,
                        color: Color(0xff2563eb),                      ),
                    ),
                    const SizedBox(height: 10),
                    const Text(
                      "kg",
                      style: TextStyle(
                        fontSize: 18,
                        color: Color(0xff2563eb),                      ),
                    ),
                    const SizedBox(height: 20),
                    SliderTheme(
                      data: SliderTheme.of(context).copyWith(
                        thumbColor: Colors.white,
                        activeTrackColor: Color(0xff2563eb),
                        inactiveTrackColor: Color(0xff2563eb),
                        overlayColor: Colors.white24,
                      ),
                      child: Slider(
                        value: weight.toDouble(),
                        min: 20,
                        max: 150,
                        divisions: 130,
                        label: "$weight",
                        onChanged: (double newWeight) {
                          setState(() {
                            weight = newWeight.round();
                          });
                        },
                      ),
                    ),
                  ],
                ),
              ),

              const Spacer(),

              // Continue Button
              CustomButton(
                onTap: () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => const GenderPage()),
                  );
                },
                text: "Continue",
              ),
            ],
          ),
        ),
      ),
    );
  }
}