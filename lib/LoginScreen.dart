import 'package:flutter/material.dart';
import 'SignUpScreen.dart';

//================== class animation ======================
void navigateWithAnimation(BuildContext context, Widget page) {
  Navigator.push(
    context,
    PageRouteBuilder(
      transitionDuration: Duration(milliseconds: 500),
      pageBuilder: (_, __, ___) => page,
      transitionsBuilder: (_, animation, __, child) {
        final slide = Tween(
          begin: Offset(1, 0),
          end: Offset.zero,
        ).animate(CurvedAnimation(
          parent: animation,
          curve: Curves.easeInOut,
        ));

        final fade = Tween<double>(begin: 0, end: 1).animate(animation);

        return FadeTransition(
          opacity: fade,
          child: SlideTransition(
            position: slide,
            child: child,
          ),
        );
      },
    ),
  );
}

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  bool obscure = true;
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
        borderSide: BorderSide(color: Color(0xff2563eb), width: 2),
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
            colors: [Color(0xff1e3a8a), Color(0xff3b82f6)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),

        child: Center(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(20),

              //==================== card ===================
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

                // ===================== form ================
                child: Form(
                  key: _formKey,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [

                     //================ logo ==================
                      CircleAvatar(
                        radius: 40,
                        backgroundColor: Color(0xff2563eb),
                        child: Icon(Icons.local_hospital,
                            color: Colors.white, size: 40),
                      ),

                      SizedBox(height: 15),

                      Text("Welcome Back",
                          style: TextStyle(
                              fontSize: 26,
                              fontWeight: FontWeight.bold)),

                      SizedBox(height: 25),

                      //============= email ================
                      TextFormField(
                        decoration: input("Email", Icons.email),
                        validator: (v) {
                          if (v == null || v.isEmpty) return "Enter email";
                          if (!v.contains("@")) return "Must contain @";
                          if (!v.contains(".com")) return "Must contain .com";
                          return null;
                        },
                      ),

                      SizedBox(height: 18),

                     //============= password ================
                      TextFormField(
                        obscureText: obscure,
                        decoration: input("Password", Icons.lock)
                            .copyWith(
                          suffixIcon: IconButton(
                            icon: Icon(
                                obscure
                                    ? Icons.visibility_off
                                    : Icons.visibility,
                                color: Colors.grey),
                            onPressed: () =>
                                setState(() => obscure = !obscure),
                          ),
                        ),
                      ),

                      SizedBox(height: 25),

                      //=============== login button ================
                      ElevatedButton(
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {}
                        },
                        child: Text("Log In",
                            style: TextStyle(
                                fontSize: 16, color: Colors.white)),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Color(0xff2563eb),
                          minimumSize: Size(double.infinity, 55),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(18)),
                          elevation: 6,
                        ),
                      ),

                      SizedBox(height: 18),

                      Text("Or continue with"),

                      SizedBox(height: 12),

                      //================= google button ==================
                      OutlinedButton.icon(
                        onPressed: () {},
                        icon: Image.network(
                          "https://cdn-icons-png.flaticon.com/512/300/300221.png",
                          height: 22,
                        ),
                        label: Text("Google",
                            style: TextStyle(fontSize: 16)),
                        style: OutlinedButton.styleFrom(
                          minimumSize:
                          Size(double.infinity, 50),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15),
                          ),
                        ),
                      ),

                      SizedBox(height: 10),

                      //======================== create new account ====================
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                      TextButton(
                        onPressed: () {
                          navigateWithAnimation(context, SignUpScreen());

                        },
                        child: Text("Create new account",style: TextStyle(
                          fontSize: 16,
                          color: Colors.black,
                        ),),
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
