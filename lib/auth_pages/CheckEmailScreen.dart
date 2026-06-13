
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'OtpScreen.dart';

class ForgotPasswordScreen extends StatefulWidget {
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
"https://yourapi.com/forgot-password",
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

if (response.statusCode == 200) {

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
content: Text("Email not found"),
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
Widget build(BuildContext context) {

return Scaffold(
body: Container(

decoration: BoxDecoration(
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
padding: EdgeInsets.all(20),

child: Container(
padding: EdgeInsets.all(25),

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
size: 90,
color: Color(0xff2563eb),
),

SizedBox(height: 20),

Text(
"Forgot Password",
style: TextStyle(
fontSize: 26,
fontWeight: FontWeight.bold,
),
),

SizedBox(height: 10),

Text(
"Enter your email to receive OTP",
textAlign: TextAlign.center,
),

SizedBox(height: 25),

TextFormField(
controller: emailController,

decoration: input(
"Email",
Icons.email,
),

validator: (v) {

if (v == null || v.isEmpty) {
return "Enter Email";
}

return null;
},
),

SizedBox(height: 25),

ElevatedButton(

onPressed: () {

if (_formKey.currentState!
    .validate()) {

sendOtp();
}
},

style: ElevatedButton.styleFrom(
backgroundColor:
Color(0xff2563eb),

minimumSize:
Size(double.infinity, 55),
),

child: isLoading
? CircularProgressIndicator(
color: Colors.white,
)
    : Text(
"Send OTP",
style: TextStyle(
color: Colors.white,
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

