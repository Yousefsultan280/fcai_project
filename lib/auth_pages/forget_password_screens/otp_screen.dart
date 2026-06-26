import 'package:dio/dio.dart';
import 'package:fcai_project/l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'reset_password_screen.dart';

class OtpScreen extends StatefulWidget {
  final String email;

  const OtpScreen({
    super.key,
    required this.email,
  });

  @override
  State<OtpScreen> createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> {
  final TextEditingController otpController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  bool isLoading = false;

  Future<void> verifyOtp() async {
    setState(() {
      isLoading = true;
    });

    try {
      Dio dio = Dio();

      Response response = await dio.post(
        "https://lungdiseases.runasp.net/api/Authentication/VerifyCode",
        data: {
          "email": widget.email,
          "code": otpController.text.trim(),
        },
      );
      if (response.statusCode == 200) {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => ResetPasswordScreen(
              email: widget.email,
            ),
          ),
        );
      }
    } on DioException catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          backgroundColor: Colors.red,
          content: Text(
             e.response?.data["errors"]?.values?.first?[0]?? AppLocalizations.of(context)!.invaildOtp,
          ),
        ),
      );
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  void dispose() {
    otpController.dispose();
    super.dispose();
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
                        Icons.security,
                        size: width * 0.2 > 90 ? 90 : width * 0.2,
                        color: const Color(0xff2563eb),
                      ),

                      SizedBox(height: height * 0.025),

                      Text(
                        lang.otpVerification,
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
                        lang.enterOtpSentToEmail,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: width * 0.04,
                        ),
                      ),

                      SizedBox(height: height * 0.03),

                      TextFormField(
                        controller: otpController,
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                          labelText: lang.otp,
                          prefixIcon: const Icon(Icons.numbers),
                          border: const OutlineInputBorder(),
                        ),
                        validator: (v) {
                          if (v == null || v.isEmpty) {
                            return lang.enterOtp;
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
                          onPressed: isLoading
                              ? null
                              : () {
                            if (_formKey.currentState!
                                .validate()) {
                              verifyOtp();
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
                            lang.verifyOtp,
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