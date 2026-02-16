import 'package:flutter/material.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor:  Color(0xfff5f9ff),
      appBar: AppBar(
        backgroundColor:  Color(0xff2563eb),
        leading: Icon(Icons.arrow_back_rounded,color: Color(0xff2563eb),),
        title:  Text(
          "My Profile",
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.only(top: 80,right: 20,left: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                 SizedBox(height: 20),
                Column(
                  children: [
                    _infoCard(
                      icon: Icons.email_outlined,
                      title: "Email",
                      value: "yousefsultan280@gmail.com",
                    ),
                    _infoCard(
                      icon: Icons.person,
                      title: "Name",
                      value: "yousef sultan",
                    ),
                    _infoCard(
                      icon: Icons.password_outlined,
                      title: "Password",
                      value: "********",
                    ),
                  ],
                ),
                 SizedBox(height: 25),
                _actionButton(
                  icon: Icons.logout_rounded,
                  text: "Logout",
                  color: Colors.red.shade600,
                  onTap: () {},
                ),
              ],
            ),
          ),
        ),
    );
  }

  Widget _infoCard({
    required IconData icon,
    required String title,
    required String value,
  }) {
    return Card(
      color: Colors.white,
      elevation: 3,
      margin: const EdgeInsets.symmetric(vertical: 8),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor:  Color(0xff2563eb),
          child: Icon(icon, color:  Colors.white),
        ),
        title: Text(title, style:  TextStyle(fontWeight: FontWeight.bold)),
        subtitle: Text(value, style:  TextStyle(fontSize: 15)),
        trailing: Icon(Icons.arrow_forward_ios_outlined,color: Color(0xff2563eb),),
      ),
    );
  }

  Widget _actionButton({
    required IconData icon,
    required String text,
    required Color color,
    required void Function() onTap,
  }) {
    return ElevatedButton.icon(
      onPressed: onTap,
      style: ElevatedButton.styleFrom(
        backgroundColor: color,
        minimumSize: const Size(double.infinity, 55),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30),
        ),
      ),
      icon: Icon(icon, color: Colors.white,size: 25,),
      label: Text(
        text,
        style: const TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
      ),
    );
  }
}