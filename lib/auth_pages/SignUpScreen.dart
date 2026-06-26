import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../homeScreen_pages/home_page.dart';
import '../l10n/app_localizations.dart';
import 'LoginScreen.dart';

class SignUpScreen extends StatefulWidget {
  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final _formKey = GlobalKey<FormState>();
  Map<String, dynamic>? data;

  bool p1 = true;
  bool p2 = true;
  bool isLoading = false;

  //===================== Controllers =====================
  final TextEditingController displayNameController = TextEditingController();

  final TextEditingController usernameController = TextEditingController();

  final TextEditingController emailController = TextEditingController();

  final TextEditingController passwordController = TextEditingController();

  final TextEditingController confirmController = TextEditingController();

  // Future signInWithGoogle() async {
  //   final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
  //
  //   if (googleUser == null) return null;
  //
  //   // Obtain the auth details from the request
  //   final GoogleSignInAuthentication? googleAuth = await googleUser?.authentication;
  //
  //   // Create a new credential
  //   final credential = GoogleAuthProvider.credential(
  //     accessToken: googleAuth?.accessToken,
  //     idToken: googleAuth?.idToken,
  //   );
  //
  //   // Once signed in, return the UserCredential
  //   await FirebaseAuth.instance.signInWithCredential(credential);
  //   Navigator.of(context).push(
  //     MaterialPageRoute<void>(
  //       builder: (context) => HomePage(
  //       ),
  //     ),
  //   );
  // }

  Future<void> register() async {
    setState(() {
      isLoading = true;
    });

    final url = Uri.parse(
      'https://lungdiseases.runasp.net/api/Authentication/Register',
    );

    try {
      final response = await http.post(
        url,

        headers: {'Content-Type': 'application/json'},

        body: jsonEncode({
          "email": emailController.text.trim(),
          "displayName": displayNameController.text.trim(),
          "userName": usernameController.text.trim(),
          "password": passwordController.text.trim(),
        }),
      );

      data = jsonDecode(response.body);

      if (response.statusCode == 200 || response.statusCode == 201) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(AppLocalizations.of(context)!.account_created_successfully),
            backgroundColor: Colors.green,
          ),
        );

        navigateWithAnimation(
          context,
          LoginScreen(),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(data?["message"] ?? AppLocalizations.of(context)!.register_failed),
            backgroundColor: Colors.red,
          ),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Error: $e"), backgroundColor: Colors.red),
      );
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  //===================== function to create input decoration with icon ================
  InputDecoration input(String label, IconData icon) {
    return InputDecoration(
      labelText: label,
      prefixIcon: Icon(icon, color: Color(0xff2563eb)),

      filled: true,
      fillColor: Colors.white,

      border: OutlineInputBorder(borderRadius: BorderRadius.circular(18)),

      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(18),

        borderSide: BorderSide(color: Colors.grey.shade300),
      ),

      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(18),

        borderSide: BorderSide(color: Color(0xff2563eb), width: 2),
      ),
    );
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
            colors: [Color(0xff1e3a8a), Color(0xff3b82f6)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),

        child: Center(
          child: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.symmetric(
                horizontal: width * 0.05,
                vertical: height * 0.03,
              ),

              child: Container(
                width: width > 600 ? 500 : double.infinity,
                padding: EdgeInsets.symmetric(
                  horizontal: width * 0.04,
                  vertical: height * 0.03,
                ),

                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(28),
                  boxShadow: const [
                    BoxShadow(
                      color: Colors.black26,
                      blurRadius: 25,
                      offset: Offset(0, 10),
                    ),
                  ],
                ),

                child: Form(
                  key: _formKey,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        Icons.person_add,
                        size: width * 0.15 > 60 ? 60 : width * 0.15,
                        color: const Color(0xff2563eb),
                      ),

                      SizedBox(height: height * 0.015),

                      Text(
                        lang.create_account,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: width * 0.065 > 26
                              ? 26
                              : width * 0.065,
                          fontWeight: FontWeight.bold,
                        ),
                      ),

                      SizedBox(height: height * 0.03),

                      TextFormField(
                        controller: displayNameController,
                        decoration: input(
                          lang.display_name,
                          Icons.person_outline,
                        ),
                        validator: (v) {
                          if (v == null || v.isEmpty) {
                            return lang.enter_display_name;
                          }
                          if (v.length < 3) {
                            return lang.min_3_characters;
                          }
                          return null;
                        },
                      ),

                      SizedBox(height: height * 0.018),

                      TextFormField(
                        controller: usernameController,
                        decoration: input(lang.username, Icons.person),
                        validator: (v) {
                          if (v == null || v.isEmpty) {
                            return lang.enter_username;
                          }
                          if (v.length < 3) {
                            return lang.min_3_characters;
                          }
                          if (v.contains(" ")) {
                            return lang.username_no_spaces;
                          }
                          return null;
                        },
                      ),

                      SizedBox(height: height * 0.018),

                      TextFormField(
                        controller: emailController,
                        decoration: input(lang.email, Icons.email),
                        validator: (v) {
                          if (v == null || v.isEmpty) {
                            return lang.please_enter_email;
                          }
                          if (!v.contains("@") || !v.contains(".com")) {
                            return lang.enter_valid_email;
                          }
                          return null;
                        },
                      ),

                      SizedBox(height: height * 0.018),

                      TextFormField(
                        controller: passwordController,
                        obscureText: p1,
                        decoration: input(lang.password, Icons.lock)
                            .copyWith(
                          suffixIcon: IconButton(
                            icon: Icon(
                              p1
                                  ? Icons.visibility_off
                                  : Icons.visibility,
                            ),
                            onPressed: () {
                              setState(() {
                                p1 = !p1;
                              });
                            },
                          ),
                        ),
                        validator: (v) {
                          if (v == null || v.isEmpty) {
                            return lang.please_enter_password;
                          }
                          if (v.length < 6) {
                            return lang.min_6_characters;
                          }
                          return null;
                        },
                      ),

                      SizedBox(height: height * 0.018),

                      TextFormField(
                        controller: confirmController,
                        obscureText: p2,
                        decoration:
                        input(lang.confirm_password, Icons.lock)
                            .copyWith(
                          suffixIcon: IconButton(
                            icon: Icon(
                              p2
                                  ? Icons.visibility_off
                                  : Icons.visibility,
                            ),
                            onPressed: () {
                              setState(() {
                                p2 = !p2;
                              });
                            },
                          ),
                        ),
                        validator: (v) {
                          if (v == null || v.isEmpty) {
                            return lang.confirm_password;
                          }
                          if (v != passwordController.text) {
                            return lang.passwords_not_match;
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
                            if (_formKey.currentState!.validate()) {
                              register();
                            }
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xff2563eb),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(18),
                            ),
                          ),
                          child: isLoading
                              ? const CircularProgressIndicator(
                            color: Colors.white,
                          )
                              : Text(
                            lang.sign_up,
                            style: TextStyle(
                              fontSize: width * 0.042,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),

                      SizedBox(height: height * 0.02),

                      Row(
                        children: [
                          const Expanded(child: Divider()),
                          Padding(
                            padding: EdgeInsets.symmetric(
                              horizontal: width * 0.02,
                            ),
                            child: Text(lang.or),
                          ),
                          const Expanded(child: Divider()),
                        ],
                      ),

                      // SizedBox(height: height * 0.02),

                      // SizedBox(
                      //   width: double.infinity,
                      //   height: height * 0.065 > 50
                      //       ? 50
                      //       : height * 0.065,
                      //   child: OutlinedButton.icon(
                      //     onPressed: () {
                      //       signInWithGoogle();
                      //     },
                      //     icon: Image.asset(
                      //       'assets/images/google.png',
                      //       height: 20,
                      //       width: 20,
                      //     ),
                      //     label: Text(
                      //       lang.continue_with_google,
                      //       style: TextStyle(
                      //         fontSize: width * 0.04,
                      //       ),
                      //     ),
                      //     style: OutlinedButton.styleFrom(
                      //       shape: RoundedRectangleBorder(
                      //         borderRadius: BorderRadius.circular(15),
                      //       ),
                      //     ),
                      //   ),
                      // ),

                      // SizedBox(height: height * 0.015),

                      TextButton(
                        onPressed: () {
                          navigateWithAnimation(
                            context,
                            LoginScreen(),
                          );
                        },
                        child: Wrap(
                          alignment: WrapAlignment.center,
                          children: [
                            Text(
                              lang.already_have_account,
                              style: TextStyle(
                                fontSize: width * 0.04,
                                color: Colors.black,
                              ),
                            ),
                            SizedBox(width: width * 0.01),
                            Text(
                              lang.login,
                              style: TextStyle(
                                fontSize: width * 0.04,
                                color: Colors.blue,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
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
