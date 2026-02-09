// LoginScreen.dart
import 'package:flutter/material.dart';
import 'SignUpScreen.dart';

class LoginScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("Login", style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold)),
            SizedBox(height: 30),
            TextField(
              decoration: InputDecoration(labelText: "Username / Email", border: OutlineInputBorder()),
            ),
            SizedBox(height: 20),
            TextField(
              obscureText: true,
              decoration: InputDecoration(labelText: "Password", border: OutlineInputBorder()),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // هنا تضيف عملية تسجيل الدخول
              },
              child: Text("Log In"),
              style: ElevatedButton.styleFrom(minimumSize: Size(double.infinity, 50)),
            ),
            SizedBox(height: 10),
            TextButton(
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => SignUpScreen()));
              },
              child: Text("Don't have an account? Sign Up"),
            ),
            SizedBox(height: 20),
            Text("Or log in with"),
            SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(onPressed: () {}, icon: Icon(Icons.apple)),
                IconButton(onPressed: () {}, icon: Icon(Icons.g_mobiledata)),
                IconButton(onPressed: () {}, icon: Icon(Icons.facebook)),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
