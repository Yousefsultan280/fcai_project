import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'LoginScreen.dart';

class SignUpScreen extends StatefulWidget {
  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final _formKey = GlobalKey<FormState>();

  bool p1 = true;
  bool p2 = true;
  bool isLoading = false;

  //===================== Controllers =====================
  final TextEditingController displayNameController =
  TextEditingController();

  final TextEditingController usernameController =
  TextEditingController();

  final TextEditingController emailController =
  TextEditingController();

  final TextEditingController passwordController =
  TextEditingController();

  final TextEditingController confirmController =
  TextEditingController();

  //===================== Register Function =====================
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

        headers: {
          'Content-Type': 'application/json',
        },

        body: jsonEncode({
          "email": emailController.text.trim(),
          "displayName":
          displayNameController.text.trim(),
          "userName":
          usernameController.text.trim(),
          "password":
          passwordController.text.trim(),
        }),
      );

      final data = jsonDecode(response.body);

      if (response.statusCode == 200 ||
          response.statusCode == 201) {

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              "Account created successfully",
            ),
            backgroundColor: Colors.green,
          ),
        );

        //================ navigate to login screen =====================
        navigateWithAnimation(
          context,
          LoginScreen(),
        );

      } else {

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              data["message"] ??
                  "Register Failed",
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
      prefixIcon: Icon(
        icon,
        color: Color(0xff2563eb),
      ),

      filled: true,
      fillColor: Colors.white,

      border: OutlineInputBorder(
        borderRadius:
        BorderRadius.circular(18),
      ),

      enabledBorder: OutlineInputBorder(
        borderRadius:
        BorderRadius.circular(18),

        borderSide: BorderSide(
          color: Colors.grey.shade300,
        ),
      ),

      focusedBorder: OutlineInputBorder(
        borderRadius:
        BorderRadius.circular(18),

        borderSide: BorderSide(
          color: Color(0xff2563eb),
          width: 2,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        //============ background ============
        decoration: BoxDecoration(
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
              padding:
              const EdgeInsets.symmetric(
                horizontal: 20,
                vertical: 50,
              ),

              child: Container(
                padding: EdgeInsets.only(
                  left: 15,
                  right: 15,
                ),

                decoration: BoxDecoration(
                  color: Colors.white,

                  borderRadius:
                  BorderRadius.circular(28),

                  boxShadow: [
                    BoxShadow(
                      color: Colors.black26,
                      blurRadius: 25,
                      offset: Offset(0, 10),
                    ),
                  ],
                ),

                //===================== form ==================
                child: Form(
                  key: _formKey,

                  child: Column(
                    mainAxisSize:
                    MainAxisSize.min,

                    children: [
                      Icon(
                        Icons.person_add,
                        size: 60,
                        color:
                        Color(0xff2563eb),
                      ),

                      SizedBox(height: 15),

                      Text(
                        "Create Account",

                        style: TextStyle(
                          fontSize: 26,
                          fontWeight:
                          FontWeight.bold,
                        ),
                      ),

                      SizedBox(height: 25),

                      //===================== text field for display name ================
                      TextFormField(
                        controller:
                        displayNameController,

                        decoration: input(
                          "Display Name",
                          Icons.person_outline,
                        ),

                        validator: (v) {
                          if (v == null ||
                              v.isEmpty) {
                            return "Enter display name";
                          }

                          if (v.length < 3) {
                            return "Min 3 characters";
                          }

                          return null;
                        },
                      ),

                      SizedBox(height: 18),

                      //===================== text field for username ================
                      TextFormField(
                        controller:
                        usernameController,

                        decoration: input(
                          "Username",
                          Icons.person,
                        ),

                        validator: (v) {
                          if (v == null ||
                              v.isEmpty) {
                            return "Enter username";
                          }

                          if (v.length < 3) {
                            return "Min 3 characters";
                          }

                          if (v.contains(" ")) {
                            return "Username must not contain spaces";
                          }

                          return null;
                        },
                      ),

                      SizedBox(height: 18),

                      //===================== text field for email ================
                      TextFormField(
                        controller:
                        emailController,

                        decoration: input(
                          "Email",
                          Icons.email,
                        ),

                        validator: (v) {
                          if (v == null ||
                              v.isEmpty) {
                            return "Please Enter Email";
                          }

                          if (!v.contains("@") ||
                              !v.contains(
                                  ".com")) {
                            return "Enter Valid Email";
                          }

                          return null;
                        },
                      ),

                      SizedBox(height: 18),

                      //========================= text field for password =====================
                      TextFormField(
                        controller:
                        passwordController,

                        obscureText: p1,

                        decoration: input(
                          "Password",
                          Icons.lock,
                        ).copyWith(
                          suffixIcon:
                          IconButton(
                            icon: Icon(
                              p1
                                  ? Icons
                                  .visibility_off
                                  : Icons
                                  .visibility,
                            ),

                            onPressed: () {
                              setState(() {
                                p1 = !p1;
                              });
                            },
                          ),
                        ),

                        validator: (v) {
                          if (v == null ||
                              v.isEmpty) {
                            return "Please Enter Password";
                          }

                          if (v.length < 6) {
                            return "Min 6 characters";
                          }

                          return null;
                        },
                      ),

                      SizedBox(height: 18),

                      // ===================== text field for confirm password ==================
                      TextFormField(
                        controller:
                        confirmController,

                        obscureText: p2,

                        decoration: input(
                          "Confirm Password",
                          Icons.lock,
                        ).copyWith(
                          suffixIcon:
                          IconButton(
                            icon: Icon(
                              p2
                                  ? Icons
                                  .visibility_off
                                  : Icons
                                  .visibility,
                            ),

                            onPressed: () {
                              setState(() {
                                p2 = !p2;
                              });
                            },
                          ),
                        ),

                        validator: (v) {
                          if (v == null ||
                              v.isEmpty) {
                            return "Confirm password";
                          }

                          if (v !=
                              passwordController
                                  .text) {
                            return "Passwords do not match";
                          }

                          return null;
                        },
                      ),

                      SizedBox(height: 25),

                      //===================== sign up button ==================
                      ElevatedButton(
                        onPressed: () {
                          if (_formKey
                              .currentState!
                              .validate()) {
                            register();
                          }
                        },

                        style:
                        ElevatedButton
                            .styleFrom(
                          backgroundColor:
                          Color(0xff2563eb),

                          minimumSize: Size(
                            double.infinity,
                            55,
                          ),

                          shape:
                          RoundedRectangleBorder(
                            borderRadius:
                            BorderRadius
                                .circular(
                              18,
                            ),
                          ),
                        ),

                        child: isLoading
                            ? CircularProgressIndicator(
                          color:
                          Colors
                              .white,
                        )
                            : Text(
                          "Sign Up",

                          style:
                          TextStyle(
                            fontSize:
                            16,
                            color: Colors
                                .white,
                          ),
                        ),
                      ),

                      SizedBox(height: 20),

                      Row(
                        children: [
                          Expanded(
                            child: Divider(),
                          ),

                          Padding(
                            padding:
                            EdgeInsets
                                .symmetric(
                              horizontal: 8,
                            ),

                            child: Text(
                              "OR",
                            ),
                          ),

                          Expanded(
                            child: Divider(),
                          ),
                        ],
                      ),

                      SizedBox(height: 24),

                      //===================== google button ===================
                      OutlinedButton.icon(
                        onPressed: () {},

                        icon: Image.asset(
                          'assets/images/google.png',
                          height: 20,
                          width: 20,
                        ),

                        label: Text(
                          "Continue with Google",

                          style: TextStyle(
                            fontSize: 16,
                          ),
                        ),

                        style:
                        OutlinedButton
                            .styleFrom(
                          minimumSize: Size(
                            double.infinity,
                            50,
                          ),

                          shape:
                          RoundedRectangleBorder(
                            borderRadius:
                            BorderRadius
                                .circular(
                              15,
                            ),
                          ),
                        ),
                      ),

                      SizedBox(height: 10),

                      Row(
                        mainAxisAlignment:
                        MainAxisAlignment
                            .center,

                        children: [
                          TextButton(
                            onPressed: () {
                              navigateWithAnimation(
                                context,
                                LoginScreen(),
                              );
                            },

                            child: Row(
                              children: [
                                Text(
                                  "Already have an account?",

                                  style:
                                  TextStyle(
                                    fontSize:
                                    16,
                                    color: Colors
                                        .black,
                                  ),
                                ),

                                SizedBox(
                                  width: 4,
                                ),

                                Text(
                                  " Log In",

                                  style:
                                  TextStyle(
                                    fontSize:
                                    16,

                                    color: Colors
                                        .blue
                                        .shade800,

                                    fontWeight:
                                    FontWeight
                                        .bold,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
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