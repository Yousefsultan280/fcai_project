import 'package:flutter/material.dart';
import 'LoginScreen.dart';

class SignUpScreen extends StatefulWidget {
  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {

  final _formKey = GlobalKey<FormState>();

  bool p1 = true;
  bool p2 = true;

  final passwordController = TextEditingController();
  final confirmController = TextEditingController();

  //function to create input decoration with icon
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
        borderSide: BorderSide(color: Color(0xff2563eb), width: 2),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(

        //background
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xff1e3a8a), Color(0xff3b82f6)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),

        child: Center(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(20),

              child: Container(
                padding: EdgeInsets.all(25),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(28),
                  boxShadow: [
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

                      Icon(Icons.person_add,
                          size: 60, color: Color(0xff2563eb)),

                      SizedBox(height: 15),

                      Text("Create Account",
                          style: TextStyle(
                              fontSize: 26,
                              fontWeight: FontWeight.bold)),

                      SizedBox(height: 25),

                      /// ===== EMAIL =====
                      TextFormField(
                        decoration: input("Email", Icons.email),
                        validator: (v) {
                          if (v == null || v.isEmpty)
                            return "Enter email";

                          if (!v.contains("@"))
                            return "Email must contain @";

                          if (!v.contains("gmail"))
                            return "Email must contain gmail";

                          if (!v.contains(".com"))
                            return "Email must contain .com";

                          return null;
                        },
                      ),

                      SizedBox(height: 18),

                      /// ===== PASSWORD =====
                      TextFormField(
                        controller: passwordController,
                        obscureText: p1,
                        decoration: input("Password", Icons.lock)
                            .copyWith(
                          suffixIcon: IconButton(
                            icon: Icon(
                                p1
                                    ? Icons.visibility_off
                                    : Icons.visibility),
                            onPressed: () =>
                                setState(() => p1 = !p1),
                          ),
                        ),
                        validator: (v) {
                          if (v == null || v.isEmpty)
                            return "Enter password";

                          if (v.length < 6)
                            return "Min 6 characters";

                          return null;
                        },
                      ),

                      SizedBox(height: 18),

                      /// ===== CONFIRM PASSWORD =====
                      TextFormField(
                        controller: confirmController,
                        obscureText: p2,
                        decoration:
                        input("Confirm Password", Icons.lock)
                            .copyWith(
                          suffixIcon: IconButton(
                            icon: Icon(
                                p2
                                    ? Icons.visibility_off
                                    : Icons.visibility),
                            onPressed: () =>
                                setState(() => p2 = !p2),
                          ),
                        ),
                        validator: (v) {
                          if (v == null || v.isEmpty)
                            return "Confirm password";

                          if (v != passwordController.text)
                            return "Passwords do not match";

                          return null;
                        },
                      ),

                      SizedBox(height: 25),

                      /// 🔥 SIGN UP BUTTON
                      ElevatedButton(
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {

                            /// نجاح التسجيل (مؤقت)
                            ScaffoldMessenger.of(context)
                                .showSnackBar(
                              SnackBar(
                                content:
                                Text("Account created successfully"),
                              ),
                            );

                            /// 🔥 يرجع لـ Login Screen
                            navigateWithAnimation(context, LoginScreen());

                          }
                        },
                        child: Text("Sign Up",
                            style: TextStyle(
                                fontSize: 16,
                                color: Colors.white)),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Color(0xff2563eb),
                          minimumSize: Size(double.infinity, 55),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(18)),
                        ),
                      ),
                      SizedBox(height: 20),

                      Row(
                        children: [
                          Expanded(child: Divider()),
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 8),
                            child: Text("OR"),
                          ),
                          Expanded(child: Divider()),
                        ],
                      ),

                      SizedBox(height: 24),

                      Material(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(14),
                        elevation: 2,
                        child: InkWell(
                          borderRadius: BorderRadius.circular(14),
                          onTap: () {
                            print("Google button pressed");
                          },
                          child: Container(
                            width: double.infinity,
                            height: 55,
                            padding: EdgeInsets.symmetric(horizontal: 16),
                            child: Row(
                              children: [
                                Image.network(
                                  "https://developers.google.com/identity/images/g-logo.png",
                                  height: 24,
                                ),

                                SizedBox(width: 14),

                                Expanded(
                                  child: Text(
                                    "Continue with Google",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w600,
                                      color: Colors.black87,
                                    ),
                                  ),
                                ),

                                SizedBox(width: 38),
                              ],
                            ),
                          ),
                        ),
                      ),




                      SizedBox(height: 10),

                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          TextButton(
                            onPressed: () => Navigator.pop(context),
                            child: Row(
                              children: [
                                Text(
                                  "Already have an account?",
                                  style: TextStyle(
                                    fontSize: 16,
                                    color: Colors.black,
                                  ),
                                ),

                                SizedBox(width: 4),

                                Text(
                                  " Log In",
                                  style: TextStyle(
                                    fontSize: 16,
                                    color: Colors.blue.shade800,
                                    fontWeight: FontWeight.bold,
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
