import 'dart:io';
import 'package:chatter/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:path_provider/path_provider.dart';
import 'package:record/record.dart';
import 'package:audioplayers/audioplayers.dart';

class ChatAudio extends StatefulWidget {
  final Function(File?) onAudioRecorded;
  final Function() onSendMessage;

  const ChatAudio({
    super.key,
    required this.onAudioRecorded,
    required this.onSendMessage,
  });

  @override
  State<ChatAudio> createState() => ChatAudioState();
}

class ChatAudioState extends State<ChatAudio> {
  late AudioPlayer player;
  late AudioRecorder audioRecorder;
  String? _filePath;

  @override
  void initState() {
    super.initState();
    player = AudioPlayer();
    audioRecorder = AudioRecorder();
  }

  @override
  void dispose() {
    player.dispose();
    audioRecorder.dispose();
    super.dispose();
  }

  Future<void> startRecording() async {
    try {
      if (await audioRecorder.hasPermission()) {
        final dir = await getApplicationDocumentsDirectory();
        _filePath = '${dir.path}/${_generateFileName()}';

        await audioRecorder.start(
          RecordConfig(encoder: AudioEncoder.aacLc),
          path: _filePath!,
        );

        debugPrint("Запись началась: $_filePath");
      } else {
        debugPrint("Нет разрешения на запись аудио.");
      }
    } catch (e) {
      debugPrint("Ошибка при старте записи: $e");
    }
  }

  Future<void> stopRecording() async {
    try {
      if (await audioRecorder.isRecording()) {
        await audioRecorder.stop();
        widget.onAudioRecorded(_filePath != null ? File(_filePath!) : null);
        widget.onSendMessage();
        debugPrint("Запись остановлена: $_filePath");
      } else {
        debugPrint("Запись не велась.");
      }
    } catch (e) {
      debugPrint("Ошибка при остановке записи: $e");
    }
  }

  String _generateFileName() {
    final now = DateTime.now();
    return 'audio_${now.millisecondsSinceEpoch}.m4a';
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onLongPress: () async => await startRecording(),
      onLongPressUp: () async => await stopRecording(),
      child: Container(
        padding: const EdgeInsets.all(3.0),
        decoration: BoxDecoration(
          color: stroke,
          borderRadius: BorderRadius.circular(10),
        ),
        child: IconButton(
          icon: SvgPicture.asset('assets/icons/custom_audio.svg'),
          onPressed: widget.onSendMessage,
        ),
      ),
    );
  }
}
