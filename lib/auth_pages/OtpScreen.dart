
import 'package:flutter/material.dart';

import 'ResetPasswordScreen.dart';

class OtpScreen extends StatefulWidget {

final String email;

OtpScreen({required this.email});

@override
State<OtpScreen> createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> {

final TextEditingController otpController =
TextEditingController();

final _formKey = GlobalKey<FormState>();

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
Icons.security,
size: 90,
color: Color(0xff2563eb),
),

SizedBox(height: 20),

Text(
"OTP Verification",
style: TextStyle(
fontSize: 26,
fontWeight: FontWeight.bold,
),
),

SizedBox(height: 10),

Text(
"Enter the OTP sent to your email",
textAlign: TextAlign.center,
),

SizedBox(height: 25),

TextFormField(
controller: otpController,

keyboardType:
TextInputType.number,

decoration: InputDecoration(
labelText: "OTP",
prefixIcon:
Icon(Icons.numbers),
),

validator: (v) {

if (v == null || v.isEmpty) {
return "Enter OTP";
}

return null;
},
),

SizedBox(height: 25),

ElevatedButton(

onPressed: () {

if (_formKey.currentState!
    .validate()) {

Navigator.push(
context,
MaterialPageRoute(
builder: (_) =>
ResetPasswordScreen(
email: widget.email,
otp: otpController.text,
),
),
);
}
},

style: ElevatedButton.styleFrom(
backgroundColor:
Color(0xff2563eb),

minimumSize:
Size(double.infinity, 55),
),

child: Text(
"Verify OTP",
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
);
}
}

