import 'package:flutter/material.dart';
import 'package:fcai_project/info_pages/blood_page.dart';

import 'custom/CustomButton.dart';
import 'custom/custom_page.dart';

class GenderPage extends StatefulWidget {
  const GenderPage({super.key});

  @override
  State<GenderPage> createState() => _GenderPageState();
}

class _GenderPageState extends State<GenderPage> {
  String? selectedGender;

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
                text: "What's your gender?",
                des: "Let's get to know your gender.",
                number: 3,
              ),
              const SizedBox(height: 60),

              // Gender selection cards
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  _genderCard(
                    icon: Icons.male,
                    label: "Male",
                    isSelected: selectedGender == "Male",
                    onTap: () {
                      setState(() {
                        selectedGender = "Male";
                      });
                    },
                  ),
                  _genderCard(
                    icon: Icons.female,
                    label: "Female",
                    isSelected: selectedGender == "Female",
                    onTap: () {
                      setState(() {
                        selectedGender = "Female";
                      });
                    },
                  ),
                ],
              ),

              const Spacer(),

              // Continue Button
              CustomButton(
                onTap: () {
                  if (selectedGender != null) {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (context) => const BloodPage()),
                    );
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text("Please select your gender first."),
                        backgroundColor: Colors.black,
                        behavior: SnackBarBehavior.floating,
                      ),
                    );
                  }
                },
                text: "Continue",
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _genderCard({
    required IconData icon,
    required String label,
    required bool isSelected,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 250),
        width: 140,
        height: 160,
        decoration: BoxDecoration(
          color: isSelected ? Colors.white.withOpacity(0.2) : Colors.white.withOpacity(0.1),
          borderRadius: BorderRadius.circular(25),
          border: Border.all(
            color: isSelected ? Colors.white : Colors.white30,
            width: isSelected ? 3 : 1.5,
          ),
          boxShadow: [
            if (isSelected)
              BoxShadow(
                color: Colors.white.withOpacity(0.3),
                blurRadius: 12,
                spreadRadius: 2,
              ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 70, color: Colors.white),
            const SizedBox(height: 10),
            Text(
              label,
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 22,
              ),
            ),
          ],
        ),
      ),
    );
  }
}