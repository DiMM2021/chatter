import 'package:chatter/widgets/list_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../blocs/message_bloc.dart';
import '../widgets/chat_message_list.dart';
import '../widgets/chat_input_field.dart';

class ChatScreen extends StatelessWidget {
  final String chatId;
  final String firstName;
  final String lastName;
  final String avatarUrl;
  final String lastMessage;
  final DateTime lastMessageTime;
  final bool isOnline;

  const ChatScreen({
    required this.chatId,
    required this.firstName,
    required this.lastName,
    required this.avatarUrl,
    required this.lastMessage,
    required this.lastMessageTime,
    required this.isOnline,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final TextEditingController messageController = TextEditingController();
    context.read<MessageBloc>().add(LoadMessages(chatId: chatId));

    return Scaffold(
      appBar: ListAppBar(
        firstName: firstName,
        lastName: lastName,
        avatarUrl: avatarUrl,
        isOnline: isOnline, 
      ),
      body: Column(
        children: [
          Expanded(child: ChatMessageList(chatId: chatId)),
          ChatInputField(
            chatId: chatId,
            avatarUrl: avatarUrl,
            firstName: firstName,
            lastName: lastName,
            isOnline: isOnline,
            messageController: messageController,
          ),
        ],
      ),
    );
  }
}
