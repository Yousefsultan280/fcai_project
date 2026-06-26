import 'package:dio/dio.dart';
import 'package:fcai_project/auth_pages/LoginScreen.dart';
import 'package:fcai_project/l10n/app_localizations.dart';
import 'package:flutter/material.dart';

class ResetPasswordScreen extends StatefulWidget {
  final String email;

  const ResetPasswordScreen({super.key, required this.email});

  @override
  State<ResetPasswordScreen> createState() => _ResetPasswordScreenState();
}

class _ResetPasswordScreenState extends State<ResetPasswordScreen> {
  final _formKey = GlobalKey<FormState>();

  bool obscure1 = true;
  bool obscure2 = true;
  bool isLoading = false;

  final TextEditingController passwordController = TextEditingController();

  final TextEditingController confirmController = TextEditingController();

  Future<void> resetPassword() async {
    setState(() {
      isLoading = true;
    });

    try {
      Dio dio = Dio();

      Response response = await dio.post(
        "https://lungdiseases.runasp.net/api/Authentication/ResetPassword",
        data: {
          "email": widget.email,
          "newPassword": passwordController.text.trim(),
        },
      );
      if (response.statusCode == 200 || response.statusCode == 204) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            backgroundColor: Colors.green,
            content: Text(AppLocalizations.of(context)!.passwordResetSuccess),
          ),
        );
        Navigator.push(
          context,
          MaterialPageRoute(builder: (_) => LoginScreen()),
        );
      }
    } on DioException catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            e.response?.data.toString() ??
                AppLocalizations.of(context)!.resetFailed,
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
    passwordController.dispose();
    confirmController.dispose();
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
                        Icons.password,
                        size: width * 0.2 > 90 ? 90 : width * 0.2,
                        color: const Color(0xff2563eb),
                      ),

                      SizedBox(height: height * 0.025),

                      Text(
                        lang.resetPassword,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: width * 0.06 > 26
                              ? 26
                              : width * 0.06,
                          fontWeight: FontWeight.bold,
                        ),
                      ),

                      SizedBox(height: height * 0.03),

                      TextFormField(
                        controller: passwordController,
                        obscureText: obscure1,
                        decoration: InputDecoration(
                          labelText: lang.newPassword,
                          border: const OutlineInputBorder(),
                          suffixIcon: IconButton(
                            icon: Icon(
                              obscure1
                                  ? Icons.visibility_off
                                  : Icons.visibility,
                            ),
                            onPressed: () {
                              setState(() {
                                obscure1 = !obscure1;
                              });
                            },
                          ),
                        ),
                        validator: (v) {
                          if (v == null || v.isEmpty) {
                            return lang.enterNewPassword;
                          }

                          if (v.length < 6) {
                            return lang.passwordTooShort;
                          }

                          return null;
                        },
                      ),

                      SizedBox(height: height * 0.025),

                      TextFormField(
                        controller: confirmController,
                        obscureText: obscure2,
                        decoration: InputDecoration(
                          labelText: lang.confirmPassword,
                          border: const OutlineInputBorder(),
                          suffixIcon: IconButton(
                            icon: Icon(
                              obscure2
                                  ? Icons.visibility_off
                                  : Icons.visibility,
                            ),
                            onPressed: () {
                              setState(() {
                                obscure2 = !obscure2;
                              });
                            },
                          ),
                        ),
                        validator: (v) {
                          if (v == null || v.isEmpty) {
                            return lang.confirmPassword;
                          }

                          if (v != passwordController.text) {
                            return lang.passwordsDoNotMatch;
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
                              resetPassword();
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
                            lang.resetPassword,
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
