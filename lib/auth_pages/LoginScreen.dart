import 'package:flutter/material.dart';
import '../info_pages/custom/CustomButton.dart';
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
              decoration: InputDecoration(labelText: "Email", border: OutlineInputBorder()),
            ),
            SizedBox(height: 20),
            TextField(
              obscureText: true,
              decoration: InputDecoration(labelText: "Password", border: OutlineInputBorder()),
            ),
            SizedBox(height: 30),
            CustomButton(onTap: () {  }, text: 'Login',),
            SizedBox(height: 10),
            TextButton(
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => SignUpScreen()));
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Don't have an account?",style: TextStyle(color: Colors.black,fontSize: 16),),
                  Text(" Sign Up",style: TextStyle(color: Color(0xff2563eb),fontSize: 20),)
                ],
              ),
            ),
            SizedBox(height: 20),
            Text("Or log in with"),
            SizedBox(height: 10),
        ElevatedButton(
          onPressed: (){},
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.blue[300],
            minimumSize: const Size(double.infinity, 55),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(30),
            ),
          ),
         child: Row(
           mainAxisAlignment: MainAxisAlignment.center,
           children: [
             Icon(Icons.g_mobiledata_outlined,size: 40,color: Colors.deepOrange,),
             Text("  Login With Google", style: const TextStyle(
               fontSize: 18,
               fontWeight: FontWeight.bold,
               color: Colors.white,
             ),),
           ],
         ),

          ),
          ],
        ),
      ),
    );
  }
}
