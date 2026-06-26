import 'dart:convert';
import 'package:fcai_project/auth_pages/forget_password_screens/forget_password.dart';
import 'package:fcai_project/l10n/app_localizations.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import '../homeScreen_pages/home_page.dart';
import 'SignUpScreen.dart';

//================== class animation ======================
void navigateWithAnimation(BuildContext context, Widget page) {
  Navigator.pushReplacement(
    context,
    PageRouteBuilder(
      transitionDuration: Duration(milliseconds: 500),
      pageBuilder: (_, __, ___) => page,
      transitionsBuilder: (_, animation, __, child) {
        final slide = Tween(
          begin: Offset(1, 0),
          end: Offset.zero,
        ).animate(
          CurvedAnimation(parent: animation, curve: Curves.easeInOut),
        );

        final fade = Tween<double>(
          begin: 0,
          end: 1,
        ).animate(animation);

        return FadeTransition(
          opacity: fade,
          child: SlideTransition(position: slide, child: child),
        );
      },
    ),
  );
}

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
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
  //    await FirebaseAuth.instance.signInWithCredential(credential);
  //   Navigator.of(context).push(
  //     MaterialPageRoute<void>(
  //       builder: (context) => HomePage(
  //       ),
  //     ),
  //   );
  // }
  final _formKey = GlobalKey<FormState>();
  bool obscure = true;
  bool isLoading = false;

  final TextEditingController emailController =
  TextEditingController();

  final TextEditingController passwordController =
  TextEditingController();


  //===================== API Login Function =====================
  Future<void> login() async {
    setState(() {
      isLoading = true;
    });

    final url = Uri.parse(
      'https://lungdiseases.runasp.net/api/Authentication/Login',
    );

    try {
      final response = await http.post(
        url,
        headers: {
          'Content-Type': 'application/json',
        },
        body: jsonEncode({
          "email": emailController.text.trim(),
          "password": passwordController.text.trim(),
        }),
      );

      final data = jsonDecode(response.body);
      var res=jsonDecode(response.body) ;

      Future<void> setToken()async{
        final pref=await SharedPreferences.getInstance();
        await pref.setString("token", res["token"]);
      }

      Future<void> setDisplayName()async{
        final pref=await SharedPreferences.getInstance();
        await pref.setString("displayName", res["displayName"]);
      }

      if (response.statusCode == 200) {
        await setToken();
          await setDisplayName();
        Navigator.of(context).push(
            MaterialPageRoute<void>(
                builder: (context) => HomePage()));
          ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(AppLocalizations.of(context)!.login_success),
            backgroundColor: Colors.green,
          ),
        );
      }
      else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              data["message"] ?? AppLocalizations.of(context)!.login_failed,
            ),
            backgroundColor: Colors.red,
          ),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Error: $e"),
          backgroundColor: Colors.red,
        ),
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

      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(18),
      ),

      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(18),
        borderSide: BorderSide(color: Colors.grey.shade300),
      ),

      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(18),
        borderSide: BorderSide(
          color: Color(0xff2563eb),
          width: 2,
        ),
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
            colors: [
              Color(0xff1e3a8a),
              Color(0xff3b82f6),
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
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
                      CircleAvatar(
                        radius: width * 0.15 > 60
                            ? 60
                            : width * 0.15,
                        backgroundColor: Colors.white,
                        backgroundImage: const AssetImage(
                          "assets/images/logo.png",
                        ),
                      ),

                      SizedBox(height: height * 0.02),

                      Text(
                        lang.welcome_back,
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

                      SizedBox(height: height * 0.02),

                      TextFormField(
                        controller: passwordController,
                        obscureText: obscure,
                        validator: (v) {
                          if (v == null || v.isEmpty) {
                            return lang.please_enter_password;
                          }

                          if (v.length < 6) {
                            return lang.min_6_characters;
                          }

                          return null;
                        },
                        decoration: input(
                          lang.password,
                          Icons.lock,
                        ).copyWith(
                          suffixIcon: IconButton(
                            icon: Icon(
                              obscure
                                  ? Icons.visibility_off
                                  : Icons.visibility,
                              color: Colors.grey,
                            ),
                            onPressed: () {
                              setState(() {
                                obscure = !obscure;
                              });
                            },
                          ),
                        ),
                      ),

                      SizedBox(height: height * 0.01),

                      Align(
                        alignment: Alignment.centerLeft,
                        child: InkWell(
                          onTap: () {
                            navigateWithAnimation(
                              context,
                              ForgotPasswordScreen(),
                            );
                          },
                          child: Text(
                            lang.forget_password,
                            style: const TextStyle(
                              color: Color(0xff2563eb),
                            ),
                          ),
                        ),
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
                              login();
                            }
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor:
                            const Color(0xff2563eb),
                            shape: RoundedRectangleBorder(
                              borderRadius:
                              BorderRadius.circular(18),
                            ),
                            elevation: 6,
                          ),
                          child: isLoading
                              ? const CircularProgressIndicator(
                            color: Colors.white,
                          )
                              : Text(
                            lang.login,
                            style: TextStyle(
                              fontSize: width * 0.042,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),

                      SizedBox(height: height * 0.025),

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


                      // SizedBox(height: height * 0.015),

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
                      //       lang.google,
                      //       style: TextStyle(
                      //         fontSize: width * 0.04,
                      //       ),
                      //     ),
                      //     style: OutlinedButton.styleFrom(
                      //       shape: RoundedRectangleBorder(
                      //         borderRadius:
                      //         BorderRadius.circular(15),
                      //       ),
                      //     ),
                      //   ),
                      // ),
                      // SizedBox(height: height * 0.015),

                      TextButton(
                        onPressed: () {
                          navigateWithAnimation(
                            context,
                            SignUpScreen(),
                          );
                        },
                        child: Text(
                          lang.create_new_account,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: width * 0.04,
                            color: Colors.black,
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