import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../auth_pages/LoginScreen.dart';
import '../../l10n/app_localizations.dart';
import 'edit_display_name_page.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  void initState() {
    super.initState();
    loadUserInfo();
  }

  Future<dynamic> getUserInfo()async{
    final refer=await SharedPreferences.getInstance();
    String token= refer.getString("token")??"";
    try {
      Dio dio = Dio();
      final result = await dio.get(
          "https://lungdiseases.runasp.net/api/User/me", options: Options(
          contentType: "application/json",
          headers: {
            "Authorization": "Bearer $token",
          }
      ));
      return result.data;
    }
    catch(e){
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Error: Please login again"),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  Map <String,dynamic>? response;
  void loadUserInfo()async{
    final data=await getUserInfo();
    setState(() {
      response=data;
    });
  }
  @override
  Widget build(BuildContext context) {
    final lang = AppLocalizations.of(context)!;

    final size = MediaQuery.of(context).size;
    final width = size.width;
    final height = size.height;

    Future<void> logout() async {
      final pref = await SharedPreferences.getInstance();
      await pref.clear();

      // GoogleSignIn googleSignIn = GoogleSignIn();
      // await googleSignIn.disconnect();

      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (_) => LoginScreen()),
            (route) => false,
      );
    }

    return Scaffold(
      backgroundColor: const Color(0xfff5f9ff),

      appBar: AppBar(
        backgroundColor: const Color(0xff2563eb),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_rounded),
          color: Colors.white,
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          lang.my_profile,
          style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),

      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: width * 0.05,
            vertical: height * 0.03,
          ),

          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: height * 0.02),

              Column(
                children: [
                  _infoCard(
                    width: width,
                    icon: Icons.email_outlined,
                    title: lang.email,
                    value: response?["email"] ?? "...",
                  ),

                  InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) =>
                          const EditDisplayNamePage(),
                        ),
                      );
                    },
                    child: _infoCard(
                      width: width,
                      icon: Icons.person,
                      title: lang.display_name,
                      value:
                      response?["displayName"] ?? "...",
                      trailingIcon:
                      Icons.arrow_forward_ios,
                    ),
                  ),
                ],
              ),

              SizedBox(height: height * 0.03),

              _actionButton(
                width: width,
                icon: Icons.logout_rounded,
                text: lang.logout,
                color: Colors.red.shade600,
                onTap: logout,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _infoCard({
    required double width,
    required IconData icon,
    required String title,
    required String value,
    IconData? trailingIcon,
  }) {
    return Card(
      color: Colors.white,
      elevation: 3,
      margin: EdgeInsets.symmetric(
        vertical: width * 0.02,
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      child: ListTile(
        leading: CircleAvatar(
          radius: width * 0.06 > 26 ? 26 : width * 0.06,
          backgroundColor: const Color(0xff2563eb),
          child: Icon(icon, color: Colors.white),
        ),

        title: Text(
          title,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: width * 0.042,
          ),
        ),

        subtitle: Text(
          value,
          style: TextStyle(
            fontSize: width * 0.038,
          ),
        ),

        trailing: trailingIcon != null
            ? Icon(
          trailingIcon,
          color: const Color(0xff2563eb),
          size: width * 0.05,
        )
            : null,
      ),
    );
  }

  Widget _actionButton({
    required double width,
    required IconData icon,
    required String text,
    required Color color,
    required void Function() onTap,
  }) {
    return SizedBox(
      width: double.infinity,
      height: 55,
      child: ElevatedButton.icon(
        onPressed: onTap,
        style: ElevatedButton.styleFrom(
          backgroundColor: color,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30),
          ),
        ),
        icon: Icon(
          icon,
          color: Colors.white,
          size: width * 0.06 > 25 ? 25 : width * 0.06,
        ),
        label: Text(
          text,
          style: TextStyle(
            fontSize: width * 0.045,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
      ),
    );
  }}