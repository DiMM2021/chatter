import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../blocs/message_bloc.dart';
import '../widgets/chat_audio.dart';
import '../widgets/chat_attachment.dart';
import '../models/message_model.dart';
import '../theme/theme.dart';

class ChatInputField extends StatelessWidget {
  final String chatId;
  final String avatarUrl;
  final String firstName;
  final String lastName;
  final bool isOnline;
  final TextEditingController messageController;

  const ChatInputField({
    super.key,
    required this.chatId,
    required this.avatarUrl,
    required this.firstName,
    required this.lastName,
    required this.isOnline,
    required this.messageController,
  });

  void _sendMessage(BuildContext context) {
    if (messageController.text.trim().isNotEmpty) {
      final message = Message(
        text: messageController.text.trim(),
        time: DateTime.now(),
        isSentByMe: true,
        avatarUrl: avatarUrl,
        firstName: firstName,
        lastName: lastName,
        isOnline: isOnline,
        chatId: chatId,
      );

      context.read<MessageBloc>().add(SendMessage(chatId, message));
      messageController.clear();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          ChatAttachment(
            onImageSelected: (imagePath) {
              final message = Message(
                text: '',
                time: DateTime.now(),
                isSentByMe: true,
                avatarUrl: avatarUrl,
                firstName: firstName,
                lastName: lastName,
                isOnline: isOnline,
                chatId: chatId,
                imagePath: imagePath,
              );
              context.read<MessageBloc>().add(SendMessage(chatId, message));
            },
          ),
          const SizedBox(width: 5),
          Expanded(
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxHeight: 150),
              child: Container(
                decoration: BoxDecoration(
                  color: stroke,
                  borderRadius: BorderRadius.circular(30),
                ),
                child: TextField(
                  controller: messageController,
                  maxLines: null,
                  decoration: InputDecoration(
                    hintText: "Сообщение",
                    hintStyle: Theme.of(context).textTheme.labelLarge,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide.none,
                    ),
                    filled: true,
                    fillColor: stroke,
                    contentPadding: const EdgeInsets.symmetric(
                        vertical: 15, horizontal: 15),
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(width: 5),
          ValueListenableBuilder<TextEditingValue>(
            valueListenable: messageController,
            builder: (context, value, child) {
              return Container(
                child: value.text.trim().isNotEmpty
                    ? IconButton(
                        icon: const Icon(Icons.send, color: Colors.green),
                        onPressed: () => _sendMessage(context),
                      )
                    : ChatAudio(
                        onAudioRecorded: (audioFile) {
                          if (audioFile != null) {
                            final message = Message(
                              text: '',
                              time: DateTime.now(),
                              isSentByMe: true,
                              avatarUrl: avatarUrl,
                              firstName: firstName,
                              lastName: lastName,
                              isOnline: isOnline,
                              chatId: chatId,
                              audioPath: audioFile.path,
                            );
                            context
                                .read<MessageBloc>()
                                .add(SendMessage(chatId, message));
                          }
                        },
                        onSendMessage: () => _sendMessage(context),
                      ),
              );
            },
          ),
        ],
      ),
    );
  }
}
