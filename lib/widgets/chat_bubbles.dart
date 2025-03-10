import 'package:chatter/blocs/audio_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:chat_bubbles/chat_bubbles.dart';
import 'package:chatter/theme/theme.dart';
import 'dart:io';
import 'audio_bubble.dart';

class ChatBubble extends StatelessWidget {
  final String message;
  final bool isSender;
  final String time;
  final bool tail;
  final String imagePath;
  final bool delivered;
  final String audioPath;

  const ChatBubble({
    super.key,
    required this.message,
    required this.isSender,
    required this.time,
    required this.tail,
    required this.imagePath,
    required this.delivered,
    this.audioPath = '',
  });

  @override
  Widget build(BuildContext context) {
    final audioBloc = AudioCubit()..loadAudio(audioPath);

    return BlocProvider.value(
      value: audioBloc,
      child: Dismissible(
        key: Key(audioPath),
        onDismissed: (_) => audioBloc.close(),
        child: Align(
          alignment: isSender ? Alignment.centerRight : Alignment.centerLeft,
          child: Column(
            crossAxisAlignment: isSender ? CrossAxisAlignment.end : CrossAxisAlignment.start,
            children: [
              if (imagePath.isNotEmpty)
                BubbleNormalImage(
                  id: imagePath,
                  image: Image.file(
                    File(imagePath),
                    width: 200,
                    height: 200,
                    fit: BoxFit.cover,
                  ),
                  color: isSender ? green : stroke,
                  tail: tail,
                ),
              if (message.isNotEmpty)
                BubbleSpecialThree(
                  text: message,
                  color: isSender ? green : stroke,
                  tail: tail,
                  isSender: isSender,
                  textStyle: TextStyle(
                    color: isSender ? darkGreen : gray,
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              if (message.isNotEmpty)
                Padding(
                  padding: const EdgeInsets.only(top: 2, right: 6),
                  child: _buildTimeAndCheckmarks(),
                ),
              if (audioPath.isNotEmpty) AudioBubble(audioPath: audioPath),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTimeAndCheckmarks() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 3),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            time,
            style: const TextStyle(
              color: Color.fromARGB(255, 107, 104, 104),
              fontSize: 12,
            ),
          ),
          const SizedBox(width: 4),
          if (isSender && delivered)
            const Icon(Icons.done_all, color: Colors.blue, size: 18),
        ],
      ),
    );
  }
}