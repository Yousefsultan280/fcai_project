
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../homeScreen_pages/home_page.dart';
import 'CheckEmailScreen.dart';
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
CurvedAnimation(
parent: animation,
curve: Curves.easeInOut,
),
);

final fade = Tween<double>(
begin: 0,
end: 1,
).animate(animation);

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
_LoginScreenState createState() =>
_LoginScreenState();
}

class _LoginScreenState
extends State<LoginScreen> {

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

"email":
emailController.text.trim(),

"password":
passwordController.text.trim(),
}),
);

final data =
jsonDecode(response.body);

if (response.statusCode == 200) {

ScaffoldMessenger.of(context)
    .showSnackBar(

SnackBar(
content:
Text("Login Success"),

backgroundColor:
Colors.green,
),
);

navigateWithAnimation(
context,
HomePage(),
);

} else {

ScaffoldMessenger.of(context)
    .showSnackBar(

SnackBar(
content: Text(
data["message"] ??
"Login Failed",
),

backgroundColor:
Colors.red,
),
);
}

} catch (e) {

ScaffoldMessenger.of(context)
    .showSnackBar(

SnackBar(
content: Text(
"Error: $e",
),

backgroundColor:
Colors.red,
),
);

} finally {

setState(() {
isLoading = false;
});
}
}

//===================== input decoration =====================
InputDecoration input(
String label,
IconData icon,
) {

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
padding: const EdgeInsets.all(20),

//==================== card ===================
child: Container(

padding: EdgeInsets.all(25),

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

// ===================== form ================
child: Form(

key: _formKey,

child: Column(

mainAxisSize:
MainAxisSize.min,

children: [

//================ logo ==================
CircleAvatar(
radius: 60,
backgroundColor:
Colors.white,

backgroundImage:
AssetImage(
"assets/images/lung.png",
),
),

SizedBox(height: 15),

Text(
"Welcome Back",

style: TextStyle(
fontSize: 26,
fontWeight:
FontWeight.bold,
),
),

SizedBox(height: 25),

//============= email ================
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

return
"Please Enter Email";
}

if (!v.contains("@") ||
!v.contains(".com")) {

return
"Enter Valid Email";
}

return null;
},
),

SizedBox(height: 18),

//============= password ================
TextFormField(

controller:
passwordController,

obscureText: obscure,

validator: (v) {

if (v == null ||
v.isEmpty) {

return
"Please Enter Password";
}

if (v.length < 6) {

return
"Min 6 characters";
}

return null;
},

decoration: input(
"Password",
Icons.lock,
).copyWith(

suffixIcon:
IconButton(

icon: Icon(

obscure
? Icons
    .visibility_off
    : Icons
    .visibility,

color: Colors.grey,
),

onPressed: () {

setState(() {
obscure =
!obscure;
});
},
),
),
),

//================ Forgot Password =================
Align(
alignment:
Alignment.centerRight,

child: TextButton(

onPressed: () {

Navigator.push(
context,

MaterialPageRoute(
builder: (_) =>
ForgotPasswordScreen(),
),
);
},

child: Text(
"Forgot Password?",

style: TextStyle(
color:
Color(0xff2563eb),

fontWeight:
FontWeight.bold,
),
),
),
),

SizedBox(height: 10),

//================ Login Button =================
ElevatedButton(

onPressed: () {

if (_formKey
    .currentState!
    .validate()) {

login();
}
},

style:
ElevatedButton
    .styleFrom(

backgroundColor:
Color(0xff2563eb),

minimumSize:
Size(
double.infinity,
55,
),

shape:
RoundedRectangleBorder(
borderRadius:
BorderRadius.circular(
18,
),
),

elevation: 6,
),

child: isLoading

? CircularProgressIndicator(
color: Colors.white,
)

    : Text(

"Log In",

style: TextStyle(
fontSize: 16,
color:
Colors.white,
),
),
),

SizedBox(height: 18),

Text("Or continue with"),

SizedBox(height: 12),

//================= google button ==================
OutlinedButton.icon(

onPressed: () {},

icon: Image.asset(
'assets/images/google.png',
height: 20,
width: 20,
),

label: Text(
"Google",

style: TextStyle(
fontSize: 16,
),
),

style:
OutlinedButton
    .styleFrom(

minimumSize:
Size(
double.infinity,
50,
),

shape:
RoundedRectangleBorder(
borderRadius:
BorderRadius.circular(
15,
),
),
),
),

SizedBox(height: 10),

Row(

mainAxisAlignment:
MainAxisAlignment.center,

children: [

TextButton(

onPressed: () {

navigateWithAnimation(
context,
SignUpScreen(),
);
},

child: Text(

"Create new account",

style: TextStyle(
fontSize: 16,
color: Colors.black,
),
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

