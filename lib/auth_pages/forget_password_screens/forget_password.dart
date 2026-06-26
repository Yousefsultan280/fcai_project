import 'dart:convert';
import 'package:fcai_project/l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'otp_screen.dart';
import 'package:http/http.dart' as http;

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({super.key});

  @override
  State<ForgotPasswordScreen> createState() =>
      _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState
    extends State<ForgotPasswordScreen> {

  final _formKey = GlobalKey<FormState>();

  final TextEditingController emailController =
  TextEditingController();

  bool isLoading = false;

  InputDecoration input(String label, IconData icon) {
    return InputDecoration(
      labelText: label,
      prefixIcon: Icon(icon, color: Color(0xff2563eb)),
      filled: true,
      fillColor: Colors.white,

      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(18),
      ),
    );
  }

  Future<void> sendOtp() async {
    setState(() {
      isLoading = true;
    });

    final url = Uri.parse(
      "https://lungdiseases.runasp.net/api/Authentication/SendCode",
    );
    try {
      final response = await http.post(
        url,
        headers: {
          'Content-Type': 'application/json',
        },
        body: jsonEncode({
          "email": emailController.text.trim(),
        }),
      );
      if (response.statusCode >=200 && response.statusCode<= 204) {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => OtpScreen(
              email: emailController.text,
            ),
          ),
        );

      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(AppLocalizations.of(context)!.please_try_again),
          ),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Error: $e"),
        ),
      );
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  @override
  Widget build(BuildContext context) {
    final lang = AppLocalizations.of(context)!;

    final size = MediaQuery.of(context).size;
    final width = size.width;
    final height = size.height;

    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color(0xff1e3a8a),
              Color(0xff3b82f6),
            ],
          ),
        ),
        child: Center(
          child: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.symmetric(
                horizontal: width * 0.05,
                vertical: height * 0.02,
              ),
              child: Container(
                width: width > 600 ? 500 : double.infinity,
                padding: EdgeInsets.all(width * 0.06),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(28),
                ),
                child: Form(
                  key: _formKey,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        Icons.lock_reset,
                        size: width * 0.2 > 90 ? 90 : width * 0.2,
                        color: const Color(0xff2563eb),
                      ),

                      SizedBox(height: height * 0.025),

                      Text(
                        lang.forgotPassword,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: width * 0.06 > 26
                              ? 26
                              : width * 0.06,
                          fontWeight: FontWeight.bold,
                        ),
                      ),

                      SizedBox(height: height * 0.01),

                      Text(
                        lang.enterEmailToReceiveOtp,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: width * 0.04,
                        ),
                      ),

                      SizedBox(height: height * 0.03),

                      TextFormField(
                        controller: emailController,
                        decoration: input(
                          lang.email,
                          Icons.email,
                        ),
                        validator: (v) {
                          if (v == null || v.isEmpty) {
                            return lang.please_enter_email;
                          }

                          if (!v.contains("@") ||
                              !v.contains(".com")) {
                            return lang.enter_valid_email;
                          }
                          return null;
                        },
                      ),

                      SizedBox(height: height * 0.03),

                      SizedBox(
                        width: double.infinity,
                        height: height * 0.07 > 55
                            ? 55
                            : height * 0.07,
                        child: ElevatedButton(
                          onPressed: () {
                            if (_formKey.currentState!
                                .validate()) {
                              sendOtp();
                            }
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor:
                            const Color(0xff2563eb),
                          ),
                          child: isLoading
                              ? const CircularProgressIndicator(
                            color: Colors.white,
                          )
                              : Text(
                            lang.sendOtp,
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: width * 0.042,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}