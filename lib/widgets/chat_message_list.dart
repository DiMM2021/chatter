import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import '../blocs/message_bloc.dart';
import '../models/message_model.dart';
import '../widgets/chat_bubbles.dart';
import '../utils/date_utils.dart';

class ChatMessageList extends StatelessWidget {
  final String chatId;

  const ChatMessageList({super.key, required this.chatId});

  bool shouldShowDateDivider(List<Message> messages, int index) {
    if (index == messages.length - 1) return true;
    final currentMessageDate = messages[messages.length - 1 - index].time;
    final previousMessageDate = messages[messages.length - index - 2].time;
    return formatChatDate(currentMessageDate) !=
        formatChatDate(previousMessageDate);
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MessageBloc, MessageState>(
      builder: (context, state) {
        if (state is MessageLoaded) {
          final messages = state.messages;

          return ListView.builder(
            reverse: true,
            padding: const EdgeInsets.all(10.0),
            itemCount: messages.length,
            itemBuilder: (context, index) {
              final message = messages[messages.length - 1 - index];
              final bool showDateDivider =
                  shouldShowDateDivider(messages, index);

              return Column(
                children: [
                  if (showDateDivider)
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Expanded(
                            child: Divider(
                              color: Colors.grey,
                              thickness: 1.0,
                              indent: 20,
                              endIndent: 10,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 10),
                            child: Text(
                              formatChatDate(message.time),
                              style: TextStyle(
                                  color: Colors.grey[600], fontSize: 12),
                            ),
                          ),
                          Expanded(
                            child: Divider(
                              color: Colors.grey,
                              thickness: 1.0,
                              indent: 10,
                              endIndent: 20,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ChatBubble(
                    message: message.text,
                    isSender: message.isSentByMe,
                    time: DateFormat('HH:mm').format(message.time),
                    tail: index == 0,
                    imagePath: message.imagePath ?? '',
                    audioPath: message.audioPath ?? '',
                    delivered: true,
                  ),
                ],
              );
            },
          );
        }
        return const Center(child: CircularProgressIndicator());
      },
    );
  }
}
