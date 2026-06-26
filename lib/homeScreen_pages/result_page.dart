import 'package:flutter/material.dart';

import '../l10n/app_localizations.dart';

class ResultPage extends StatelessWidget {
  final String disease;
  final double con;
  final String reco;
  ResultPage({
    super.key,
    required this.disease,
    required this.con,
    required this.reco,
  });
  @override
  Widget build(BuildContext context) {
    final lang = AppLocalizations.of(context)!;

    final size = MediaQuery.of(context).size;
    final width = size.width;
    final height = size.height;

    double confidence = con * 100;
    int value = confidence.round();

    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xff1e3a8a), Color(0xff2563eb), Color(0xff60a5fa)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),

        child: SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: width * 0.05,
              vertical: height * 0.03,
            ),

            child: Column(
              children: [
                //================ back button =================
                Align(
                  alignment: Alignment.centerLeft,
                  child: IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: const Icon(Icons.arrow_back),
                    color: Colors.white,
                  ),
                ),

                SizedBox(height: height * 0.04),

                //================ title =================
                Text(
                  lang.test_result,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: width * 0.07 > 28 ? 28 : width * 0.07,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 1.2,
                  ),
                ),

                SizedBox(height: height * 0.05),

                //================ card =================
                Expanded(
                  child: Center(
                    child: SingleChildScrollView(
                      child: Container(
                        width: width > 600 ? 500 : double.infinity,

                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(20),
                          boxShadow: const [
                            BoxShadow(
                              color: Colors.black26,
                              blurRadius: 12,
                              offset: Offset(0, 6),
                            ),
                          ],
                        ),

                        child: Padding(
                          padding: EdgeInsets.all(width * 0.05),
                          child: Column(
                            children: [
                              // optional spacing row (removed empty row)
                              Text(
                                lang.disease,
                                style: TextStyle(
                                  color: Colors.grey,
                                  fontSize: width * 0.04,
                                ),
                              ),

                              SizedBox(height: height * 0.01),

                              Text(
                                disease,
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize: width * 0.06 > 24
                                      ? 24
                                      : width * 0.06,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),

                              SizedBox(height: height * 0.03),

                              Text(
                                lang.confidence,
                                style: TextStyle(
                                  color: Colors.grey,
                                  fontSize: width * 0.04,
                                ),
                              ),

                              SizedBox(height: height * 0.01),

                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    value.toString(),
                                    style: TextStyle(
                                      fontSize: width * 0.06 > 24
                                          ? 24
                                          : width * 0.06,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  Text(
                                    " %",
                                    style: TextStyle(
                                      fontSize: width * 0.06 > 24
                                          ? 24
                                          : width * 0.06,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),

                              SizedBox(height: height * 0.03),

                              Text(
                                lang.recommendation,
                                style: TextStyle(
                                  color: Colors.grey,
                                  fontSize: width * 0.04,
                                ),
                              ),

                              SizedBox(height: height * 0.01),

                              Text(
                                reco,
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize: width * 0.05 > 20
                                      ? 20
                                      : width * 0.05,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),

                              SizedBox(height: height * 0.02),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
