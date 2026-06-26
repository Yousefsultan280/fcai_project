import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../l10n/app_localizations.dart';

class EditDisplayNamePage extends StatefulWidget {
  const EditDisplayNamePage({super.key});

  @override
  State<EditDisplayNamePage> createState() => _EditDisplayNamePageState();
}

class _EditDisplayNamePageState extends State<EditDisplayNamePage> {
  final TextEditingController displayNameController =
  TextEditingController();

  final _formKey = GlobalKey<FormState>();
  bool isLoading = false;

  Future<void> updateDisplayName() async {
    setState(() {
      isLoading = true;
    });

      final pref = await SharedPreferences.getInstance();
      String token = pref.getString("token") ?? "";
      try {
      Dio dio = Dio();
      final response= await dio.put(
        "https://lungdiseases.runasp.net/api/User/profileUpdate",
        data: {
          "displayName": displayNameController.text,
        },
        options: Options(
          headers: {
            "Authorization": "Bearer $token",
          },
        ),
      );
      if(response.statusCode==200) {
        await pref.setString(
            "displayName",
            displayNameController.text,);

        ScaffoldMessenger.of(context).showSnackBar(
           SnackBar(
            content: Text(AppLocalizations.of(context)!.updatedSuccessfully),
          ),
        );
      }
      Navigator.pop(context, true);
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(AppLocalizations.of(context)!.nameAlreadyExists),
        ),
      );
    }

    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    final lang = AppLocalizations.of(context)!;

    final size = MediaQuery.of(context).size;
    final width = size.width;
    final height = size.height;

    return Scaffold(
      backgroundColor: Colors.white,

      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          color: Colors.white,
          onPressed: () => Navigator.pop(context),
        ),
        backgroundColor: const Color(0xff2563eb),
        title: Text(
          lang.editDisplayName,
          style: const TextStyle(color: Colors.white),
        ),
      ),

      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: width * 0.05,
              vertical: height * 0.03,
            ),

            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  TextFormField(
                    maxLines: 1,
                    controller: displayNameController,
                    decoration: input(lang.display_name).copyWith(
                      contentPadding: EdgeInsets.symmetric(
                        horizontal: width * 0.04,
                        vertical: height * 0.02,
                      ),
                    ),
                    validator: (v) {
                      if (v == null || v.isEmpty) {
                        return lang.enter_display_name;
                      }
                      if (v.length < 3) {
                        return lang.min_3_characters;
                      }
                      return null;
                    },
                  ),

                  SizedBox(height: height * 0.03),

                  SizedBox(
                    width: double.infinity,
                    height: height * 0.07 > 55 ? 55 : height * 0.07,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xff2563eb),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(18),
                        ),
                      ),
                      onPressed: isLoading
                          ? null
                          : () {
                        if (_formKey.currentState!.validate()) {
                          updateDisplayName();
                        }
                      },
                      child: isLoading
                          ? const CircularProgressIndicator(
                        color: Colors.white,
                      )
                          : Text(
                        lang.save,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: width * 0.045,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

InputDecoration input(String label,) {
  return InputDecoration(
    labelText: label,
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
      borderSide: BorderSide(
        color: Color(0xff2563eb),
        width: 2,
      ),
    ),
  );
}