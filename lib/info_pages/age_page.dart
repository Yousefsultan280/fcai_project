import 'package:flutter/material.dart';
import 'package:fcai_project/info_pages/weight_page.dart';

import 'custom/CustomButton.dart';
import 'custom/custom_page.dart';

class AgePage extends StatefulWidget {
  const AgePage({super.key});

  @override
  State<AgePage> createState() => _AgePageState();
}

class _AgePageState extends State<AgePage> {
  int age = 18;

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
                text: "How Old Are You?",
                des: "Let's get to know your age.",
                number: 1,
              ),
              const SizedBox(height: 40),

              // Card Design for Age Picker
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
                      "$age",
                      style: const TextStyle(
                        fontSize: 60,
                        fontWeight: FontWeight.bold,
                        color: Color(0xff2563eb),
                      ),
                    ),
                    const SizedBox(height: 10),
                    const Text(
                      "years old",
                      style: TextStyle(
                        fontSize: 18,
                        color: Color(0xff2563eb),
                      ),
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
                        value: age.toDouble(),
                        min: 1,
                        max: 100,
                        divisions: 99,
                        label: "$age",
                        onChanged: (double newAge) {
                          setState(() {
                            age = newAge.round();
                          });
                        },
                      ),
                    ),
                  ],
                ),
              ),

              const Spacer(),

              // Button
              CustomButton(
                onTap: () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => const WeightPage()),
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