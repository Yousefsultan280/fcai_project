import 'package:flutter/material.dart';

class ResultPage extends StatelessWidget {
  const ResultPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const MedicalResultScreen(
      testName: 'Blood Pressure Result',
      resultValue: '120/80',
      resultStatus: 'Normal',
    );
  }
}

class MedicalResultScreen extends StatelessWidget {
  final String testName;
  final String resultValue;
  final String resultStatus;

  const MedicalResultScreen({
    super.key,
    required this.testName,
    required this.resultValue,
    required this.resultStatus,
  });

  Color _getStatusColor() {
    switch (resultStatus.toLowerCase()) {
      case 'good':
      case 'normal':
        return Colors.greenAccent.shade400;
      case 'bad':
      case 'high':
      case 'low':
        return Colors.redAccent.shade200;
      default:
        return Colors.amberAccent.shade400;
    }
  }

  IconData _getStatusIcon() {
    switch (resultStatus.toLowerCase()) {
      case 'good':
      case 'normal':
        return Icons.check_circle_outline;
      case 'bad':
      case 'high':
      case 'low':
        return Icons.warning_amber_rounded;
      default:
        return Icons.info_outline;
    }
  }

  @override
  Widget build(BuildContext context) {
    final statusColor = _getStatusColor();

    return Scaffold(
      body: Container(
        width: double.infinity,
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
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                "Test Result",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 1.2,
                ),
              ),
              const SizedBox(height: 50),

              // Result Card
              AnimatedContainer(
                duration: const Duration(milliseconds: 400),
                padding: const EdgeInsets.all(25),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.95),
                  borderRadius: BorderRadius.circular(25),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.15),
                      blurRadius: 12,
                      offset: const Offset(0, 6),
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    Icon(
                      _getStatusIcon(),
                      color: statusColor,
                      size: 80,
                    ),
                    const SizedBox(height: 20),
                    Text(
                      testName,
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        color: Colors.indigo,
                      ),
                    ),
                    const SizedBox(height: 15),
                    Text(
                      resultValue,
                      style: const TextStyle(
                        fontSize: 42,
                        fontWeight: FontWeight.bold,
                        color: Colors.black87,
                      ),
                    ),
                    const SizedBox(height: 15),
                    Text(
                      resultStatus,
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w700,
                        color: statusColor,
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 60),

              // Back Button
              // ElevatedButton.icon(
              //   style: ElevatedButton.styleFrom(
              //     backgroundColor: Colors.white,
              //     padding:
              //     const EdgeInsets.symmetric(horizontal: 36, vertical: 14),
              //     shape: RoundedRectangleBorder(
              //       borderRadius: BorderRadius.circular(30),
              //     ),
              //     elevation: 8,
              //   ),
              //   onPressed: () => Navigator.pop(context),
              //   icon: const Icon(Icons.arrow_back, color: Colors.indigo),
              //   label: const Text(
              //     "Back",
              //     style: TextStyle(
              //       color: Colors.indigo,
              //       fontSize: 18,
              //       fontWeight: FontWeight.bold,
              //     ),
              //   ),
              // ),
            ],
          ),
        ),
      ),
    );
  }
}