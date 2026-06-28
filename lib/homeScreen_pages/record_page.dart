import 'package:dio/dio.dart';
import 'package:fcai_project/homeScreen_pages/result_page.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:record/record.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../l10n/app_localizations.dart';
import '../main.dart';

class RecordPage extends StatefulWidget {
  const RecordPage({super.key});

  @override
  State<RecordPage> createState() => _RecordPageState();
}

class _RecordPageState extends State<RecordPage>
    with SingleTickerProviderStateMixin {
  final AudioRecorder _recorder = AudioRecorder();
  bool _isRecording = false;
  bool _isUploading = false;
  late AnimationController _animationController;
  String? disease;
  double? confidence;
  String? recommendation;

  @override
  void initState() {
    super.initState();
    loadName();
    _initRecorder();
    _isUploading = false;
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1),
    )..repeat(reverse: true);
  }

  Future<void> _initRecorder() async {
    await Permission.microphone.request();
    final hasPermission = await _recorder.hasPermission();

    if (!hasPermission) {
      final snackBar = SnackBar(
        content: Text(AppLocalizations.of(context)!.no_mic_permission),
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
      return;
    }
  }

  Future<void> setValue(String k, String v) async {
    final pref = await SharedPreferences.getInstance();
    await pref.setString(k, v);
  }

  Future<String?> getValue(String k) async {
    final pref = await SharedPreferences.getInstance();
    return pref.getString(k);
  }

  Future<dynamic> uploadRecord(String p, String t) async {
    Dio dio = Dio();
    final formData = FormData.fromMap({
      'audioFile': await MultipartFile.fromFile(p, filename: 'audio.wav'),
    });
    final res = await dio.post(
      "https://lungdiseases.runasp.net/api/Audio/analysis",
      data: formData,
      options: Options(headers: {"Authorization": "Bearer $t"}),
    );

    return res.data;
  }

  String? name;
  Future<void> loadName() async {
    final pref = await SharedPreferences.getInstance();
    final storedName = pref.getString("displayName");

    setState(() {
      name = storedName ?? "";
    });
  }

  Future<void> _start() async {
    if (_isUploading) return;
    try {
      final dir = await getApplicationDocumentsDirectory();
      final path = '${dir.path}/audio.wav';
      await _recorder.start(
        const RecordConfig(encoder: AudioEncoder.wav),
        path: path,
      );

      setState(() => _isRecording = true);
    } catch (e) {
      final snackBar1 = SnackBar(
        content: Text(AppLocalizations.of(context)!.please_try_again),
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar1);
    }
  }

  Future<void> _stop() async {
    try {
      final path = await _recorder.stop();

      setState(() => _isRecording = false);

      final pref = await SharedPreferences.getInstance();
      String? token = pref.getString("token");

      if (path != null && token != null) {
        setState(() {
          _isUploading = true;
        });
        final result = await uploadRecord(path, token);
        setState(() {
          _isUploading = false;
        });
        if (result == null) return;


        await setValue("disease", "${result["disease"]}");
        final pref = await SharedPreferences.getInstance();
        pref.setDouble(
          "confidence",
          (result["confidence"] as num).toDouble(),
        );
        await setValue("recommendation", "${result["recommendation"]}");

        disease = await getValue("disease");
        confidence=await pref.getDouble("confidence");
        recommendation = await getValue("recommendation");
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(AppLocalizations.of(context)!.please_login_again),
          ),
        );
      }
    } catch (e) {
      final snackBar1 = SnackBar(
        content: Text(AppLocalizations.of(context)!.please_try_again),
      );
      setState(() {
        _isUploading = false;
      });
      ScaffoldMessenger.of(context).showSnackBar(snackBar1);
    }
  }

  Future<void> _toggleRecording() async {
    _isRecording ? await _stop() : await _start();
  }


  Future<void> pickAndUploadAudio() async {
    try {
      FilePickerResult? result = await FilePicker.pickFiles(
        type: FileType.custom,
        allowedExtensions: ['wav'],
      );

      if (result == null || result.files.single.path == null) return;

      final pref = await SharedPreferences.getInstance();
      String? token = pref.getString("token");

      if (token == null) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(AppLocalizations.of(context)!.please_login_again),
          ),
        );
        return;
      }

      setState(() {
        _isUploading = true;
      });

      final response = await uploadRecord(
        result.files.single.path!,
        token,
      );

      await setValue("disease", "${response["disease"]}");

      await pref.setDouble(
        "confidence",
        (response["confidence"] as num).toDouble(),
      );

      await setValue(
        "recommendation",
        "${response["recommendation"]}",
      );

      disease = await getValue("disease");
      confidence = pref.getDouble("confidence");
      recommendation = await getValue("recommendation");
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(AppLocalizations.of(context)!.please_try_again),
        ),
      );
    } finally {
      setState(() {
        _isUploading = false;
      });
    }
  }

  @override
  void dispose() {
    _recorder.dispose();
    _animationController.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    final lang = AppLocalizations.of(context)!;

    final size = MediaQuery.of(context).size;
    final width = size.width;
    final height = size.height;

    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color(0xff1e3a8a),
              Color(0xff2563eb),
              Color(0xff60a5fa),
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),

        child: SafeArea(
          child: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.symmetric(
                horizontal: width * 0.05,
                vertical: height * 0.02,
              ),

              child: Column(
                children: [
                  SizedBox(height: height * 0.02),

                  //================ language switch =================
                  InkWell(
                    onTap: () {
                      setState(() {
                        MyApp.of(context)?.changeLanguage();
                      });
                    },
                    child: Row(
                      children: [
                        SizedBox(width: width * 0.02),
                        Text(
                          Localizations.localeOf(context)
                              .languageCode ==
                              "ar"
                              ? "EN"
                              : "العربية",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: width * 0.045,
                          ),
                        ),
                        SizedBox(width: width * 0.01),
                        const Icon(
                          Icons.language,
                          color: Colors.white,
                        ),
                      ],
                    ),
                  ),

                  SizedBox(height: height * 0.05),

                  //================ greeting =================
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        lang.hello,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize:
                          width * 0.06 > 22 ? 22 : width * 0.06,
                        ),
                      ),
                      Text(
                        name ?? "...",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize:
                          width * 0.065 > 24 ? 24 : width * 0.065,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),

                  SizedBox(height: height * 0.05),

                  //================ mic animation =================
                  AnimatedBuilder(
                    animation: _animationController,
                    builder: (context, child) {
                      double scale = 1 +
                          (_isRecording
                              ? 0.2 * _animationController.value
                              : 0);

                      return Transform.scale(
                        scale: scale,
                        child: Icon(
                          Icons.mic,
                          color: _isRecording
                              ? Colors.redAccent
                              : Colors.white,
                          size: width * 0.3 > 120 ? 120 : width * 0.3,
                        ),
                      );
                    },
                  ),

                  SizedBox(height: height * 0.03),

                  //================ status text =================
                  Text(
                    _isRecording
                        ? lang.recording_in_progress
                        : lang.tap_to_start_recording,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize:
                      width * 0.05 > 20 ? 20 : width * 0.05,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  SizedBox(height: height * 0.05),

                  //================ record button =================
                  SizedBox(
                    width: width * 0.7,
                    height: height * 0.07 > 55 ? 55 : height * 0.07,
                    child: ElevatedButton.icon(
                      style: ElevatedButton.styleFrom(
                        backgroundColor:
                        Colors.white.withOpacity(0.9),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(35),
                        ),
                        elevation: 8,
                      ),
                      onPressed:
                      _isUploading ? null : _toggleRecording,
                      icon: Icon(
                        _isRecording ? Icons.stop : Icons.mic,
                        color: Colors.indigo[800],
                        size: width * 0.06 > 28 ? 28 : width * 0.06,
                      ),
                      label: Text(
                        _isRecording
                            ? lang.stop_recording
                            : lang.start_recording,
                        style: TextStyle(
                          color: Colors.indigo,
                          fontSize:
                          width * 0.045 > 18 ? 18 : width * 0.045,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),

                  SizedBox(height: height * 0.02),

                  //================ upload button =================
                  SizedBox(
                    width: width * 0.7,
                    height: height * 0.07 > 55 ? 55 : height * 0.07,
                    child: ElevatedButton.icon(
                      style: ElevatedButton.styleFrom(
                        backgroundColor:
                        Colors.orange.withOpacity(0.9),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(35),
                        ),
                        elevation: 8,
                      ),
                      onPressed:
                      _isUploading ? null : pickAndUploadAudio,
                      icon: const Icon(
                        Icons.upload_file,
                        color: Colors.white,
                      ),
                      label: Text(
                        lang.upload_audio,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize:
                          width * 0.045 > 18 ? 18 : width * 0.045,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),

                  SizedBox(height: height * 0.02),

                  //================ result button =================
                  SizedBox(
                    width: double.infinity,
                    height: height * 0.07 > 55 ? 55 : height * 0.07,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor:
                        Colors.green.withOpacity(0.9),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(35),
                        ),
                        elevation: 8,
                      ),
                      onPressed: () {
                        if (!_isUploading) {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) => ResultPage(
                                disease: disease ?? "",
                                con: (confidence ?? 0).toDouble(),
                                reco: recommendation ?? "",
                              ),
                            ),
                          );
                        }
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            _isUploading
                                ? lang.analysis_progress
                                : lang.go_to_result,
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          if (_isUploading)
                            const Padding(
                              padding:
                              EdgeInsets.symmetric(horizontal: 10),
                              child: SizedBox(
                                width: 18,
                                height: 18,
                                child: CircularProgressIndicator(
                                  color: Colors.white,
                                ),
                              ),
                            ),
                        ],
                      ),
                    ),
                  ),

                  SizedBox(height: height * 0.03),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
