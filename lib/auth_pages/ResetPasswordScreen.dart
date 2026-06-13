
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class ResetPasswordScreen extends StatefulWidget {

final String email;
final String otp;

ResetPasswordScreen({
required this.email,
required this.otp,
});

@override
State<ResetPasswordScreen> createState() =>
_ResetPasswordScreenState();
}

class _ResetPasswordScreenState
extends State<ResetPasswordScreen> {

final _formKey = GlobalKey<FormState>();

bool obscure1 = true;
bool obscure2 = true;

final TextEditingController passwordController =
TextEditingController();

final TextEditingController confirmController =
TextEditingController();

Future<void> resetPassword() async {

final url = Uri.parse(
"https://yourapi.com/reset-password",
);

final response = await http.post(
url,
headers: {
'Content-Type': 'application/json',
},
body: jsonEncode({

"email": widget.email,
"otp": widget.otp,
"newPassword":
passwordController.text.trim(),
}),
);

if (response.statusCode == 200) {

ScaffoldMessenger.of(context).showSnackBar(
SnackBar(
content: Text(
"Password Reset Success",
),
),
);

Navigator.popUntil(
context,
(route) => route.isFirst,
);

} else {

ScaffoldMessenger.of(context).showSnackBar(
SnackBar(
content: Text(
"Reset Failed",
),
),
);
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
Icons.password,
size: 90,
color: Color(0xff2563eb),
),

SizedBox(height: 20),

Text(
"Reset Password",
style: TextStyle(
fontSize: 26,
fontWeight: FontWeight.bold,
),
),

SizedBox(height: 25),

TextFormField(
controller: passwordController,
obscureText: obscure1,

decoration: InputDecoration(
labelText: "New Password",

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
),

SizedBox(height: 20),

TextFormField(
controller: confirmController,
obscureText: obscure2,

decoration: InputDecoration(
labelText:
"Confirm Password",

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

if (v !=
passwordController.text) {

return
"Password not match";
}

return null;
},
),

SizedBox(height: 25),

ElevatedButton(

onPressed: () {

if (_formKey.currentState!
    .validate()) {

resetPassword();
}
},

style: ElevatedButton.styleFrom(
backgroundColor:
Color(0xff2563eb),

minimumSize:
Size(double.infinity, 55),
),

child: Text(
"Reset Password",
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

