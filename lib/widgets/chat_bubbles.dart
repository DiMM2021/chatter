import 'package:flutter/material.dart';
import 'dart:io';
import 'package:chat_bubbles/chat_bubbles.dart';
import 'package:chatter/theme/theme.dart';

class ChatBubble extends StatelessWidget {
  final String message;
  final bool isSender;
  final String time;
  final bool tail;
  final String imagePath;
  final bool delivered;

  const ChatBubble({
    super.key,
    required this.message,
    required this.isSender,
    required this.time,
    required this.tail,
    required this.imagePath,
    required this.delivered,
  });

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: isSender ? Alignment.centerRight : Alignment.centerLeft,
      child: Column(
        crossAxisAlignment:
            isSender ? CrossAxisAlignment.end : CrossAxisAlignment.start,
        children: [
          if (imagePath.isNotEmpty)
            Stack(
              children: [
                BubbleNormalImage(
                  id: imagePath,
                  image: _image(imagePath),
                  color: isSender ? green : stroke,
                  tail: tail,
                ),
                Positioned(
                  bottom: 8,
                  right: 8,
                  child: _buildTimeAndCheckmarks(),
                ),
              ],
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
        ],
      ),
    );
  }

  Widget _image(String imageUrl) {
    return Image.file(
      File(imageUrl),
      width: 200,
      height: 200,
      fit: BoxFit.cover,
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
