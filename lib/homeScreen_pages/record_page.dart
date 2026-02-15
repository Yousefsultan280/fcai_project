import 'package:flutter/material.dart';

class RecordPage extends StatefulWidget {
  const RecordPage({super.key});

  @override
  State<RecordPage> createState() => _RecordPageState();
}

class _RecordPageState extends State<RecordPage> {
  // final FlutterSoundRecorder _recorder = FlutterSoundRecorder();
  bool _isRecording = false;
  String? _filePath;

  @override
  void initState() {
    super.initState();
    _initRecorder();
  }

  Future<void> _initRecorder() async {
    // await Permission.microphone.request();
    // await _recorder.openRecorder();
  }

  Future<void> _toggleRecording() async {
    if (_isRecording) {
      // final result = await _recorder.stopRecorder();
      setState(() {
        // _filePath = result;
        _isRecording = false;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('🎧 Recording saved at: $_filePath')),
      );
    } else {
      // await _recorder.startRecorder(toFile: 'voice_record.aac');
      setState(() => _isRecording = true);
    }
  }

  @override
  void dispose() {
    // _recorder.closeRecorder();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return  Container(
      decoration:  BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Color(0xff60a5fa),
            Color(0xff2563eb),
          ],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.only(top: 100,left: 20,right: 20),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("Hello,", style: TextStyle(
                  color: Colors.white,
                  fontSize: 22,
                ),),
                 Text(
                  "Youssef Sultan",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
             SizedBox(height: 150),
            Icon(
              _isRecording ? Icons.mic : Icons.mic_none,
              color: Colors.white,
              size: 100,
            ),
             SizedBox(height: 20),
            Text(
              _isRecording ? 'Recording...' : 'Tap to start',
              style:  TextStyle(
                color: Colors.white,
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),
             SizedBox(height: 30),
            ElevatedButton.icon(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.white.withOpacity(0.9),
                padding:  EdgeInsets.symmetric(
                  horizontal: 32,
                  vertical: 14,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
              ),
              onPressed: _toggleRecording,
              icon: Icon(
                _isRecording ? Icons.stop : Icons.mic,
                color: Colors.indigo,
              ),
              label: Text(
                _isRecording ? 'Stop' : 'Start Recording',
                style:  TextStyle(
                  color: Colors.indigo,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
