import 'package:flutter/material.dart';
import 'package:flutter_sound/flutter_sound.dart';
import 'package:permission_handler/permission_handler.dart';

class RecordPage extends StatefulWidget {
  const RecordPage({super.key});

  @override
  State<RecordPage> createState() => _RecordPageState();
}

class _RecordPageState extends State<RecordPage> with SingleTickerProviderStateMixin {
  final FlutterSoundRecorder _recorder = FlutterSoundRecorder();
  bool _isRecording = false;
  String? _filePath;
  late AnimationController _animationController;

  @override
  void initState() {
    super.initState();
    _initRecorder();
    _animationController =
    AnimationController(vsync: this, duration: const Duration(seconds: 1))
      ..repeat(reverse: true);
  }

  Future<void> _initRecorder() async {
    await Permission.microphone.request();
    await _recorder.openRecorder();
  }

  Future<void> _toggleRecording() async {
    if (_isRecording) {
      final result = await _recorder.stopRecorder();
      setState(() {
        _filePath = result;
        _isRecording = false;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          backgroundColor: Colors.white,
          content: Text(
            '🎙️ Recording saved at: $_filePath',
            style: const TextStyle(color: Colors.black87),
          ),
        ),
      );
    } else {
      await _recorder.startRecorder(toFile: 'voice_record.aac');
      setState(() => _isRecording = true);
    }
  }

  @override
  void dispose() {
    _recorder.closeRecorder();
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xff1e3a8a), Color(0xff2563eb), Color(0xff60a5fa)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 100),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              // Header
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  Text(
                    "Hello, ",
                    style: TextStyle(color: Colors.white, fontSize: 22),
                  ),
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

              const SizedBox(height: 100),

              // Animated Mic Icon
              AnimatedBuilder(
                animation: _animationController,
                builder: (context, child) {
                  double scale = 1 + (_isRecording ? 0.2 * _animationController.value : 0);
                  return Transform.scale(
                    scale: scale,
                    child: Icon(
                      Icons.mic,
                      color: _isRecording ? Colors.redAccent : Colors.white,
                      size: 120,
                    ),
                  );
                },
              ),

              const SizedBox(height: 25),

              // Recording text
              Text(
                _isRecording ? 'Recording in progress...' : 'Tap to start recording',
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 50),

              // Record Button
              ElevatedButton.icon(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.white.withOpacity(0.9),
                  padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(35),
                  ),
                  elevation: 8,
                ),
                onPressed: _toggleRecording,
                icon: Icon(
                  _isRecording ? Icons.stop : Icons.mic,
                  color: Colors.indigo[800],
                  size: 28,
                ),
                label: Text(
                  _isRecording ? 'Stop Recording' : 'Start Recording',
                  style: const TextStyle(
                    color: Colors.indigo,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),

              const Spacer(),

              // if (_filePath != null)
              //   Column(
              //     children: [
              //       const Text(
              //         "Last recording saved at:",
              //         style: TextStyle(color: Colors.white70, fontSize: 16),
              //       ),
              //       const SizedBox(height: 4),
              //       Text(
              //         _filePath!,
              //         textAlign: TextAlign.center,
              //         style: const TextStyle(
              //           color: Colors.white,
              //           fontSize: 14,
              //           fontStyle: FontStyle.italic,
              //         ),
              //       ),
              //     ],
               // ),
            ],
          ),
        ),
      ),
    );
  }
}