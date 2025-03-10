import 'package:chatter/models/chat_model.dart';
import 'package:chatter/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../screens/chat_screen.dart';
import '../widgets/chat_avatar.dart';
import '../utils/date_utils.dart';
import '../blocs/chat_bloc.dart';

class ChatListTile extends StatelessWidget {
  final Chat chat;

  const ChatListTile({super.key, required this.chat});

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: Key(chat.id),
      direction: DismissDirection.endToStart,
      background: Container(
        color: Colors.red,
        alignment: Alignment.centerRight,
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: const Icon(Icons.delete, color: Colors.white),
      ),
      onDismissed: (direction) {
        context.read<ChatBloc>().add(DeleteChat(chat.id));
      },
      child: Column(
        children: [
          ListTile(
            leading: ChatAvatar(imageUrl: chat.avatarUrl, name: chat.name),
            title:
                Text(chat.name, style: Theme.of(context).textTheme.labelMedium),
            subtitle: RichText(
              text: TextSpan(
                style: Theme.of(context).textTheme.labelSmall,
                children: [
                  if (chat.lastMessage.startsWith("Вы: "))
                    const TextSpan(
                      text: "Вы: ",
                      style: TextStyle(
                          fontWeight: FontWeight.bold, color: Colors.black),
                    ),
                  TextSpan(
                    text: chat.lastMessage.replaceFirst("Вы: ", ""),
                    style: const TextStyle(
                        fontWeight: FontWeight.normal, color: Colors.black54),
                  ),
                ],
              ),
            ),
            trailing: Text(
              formatChatDate(chat.lastMessageTime),
              style: Theme.of(context).textTheme.labelSmall,
            ),
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => ChatScreen(
                  chatId: chat.id,
                  firstName: chat.firstName,
                  lastMessage: chat.lastMessage,
                  lastMessageTime: chat.lastMessageTime,
                  lastName: chat.lastName,
                  avatarUrl: chat.avatarUrl,
                  isOnline: chat.isOnline,
                ),
              ),
            ),
          ),
          const Divider(color: stroke, thickness: 1.0),
        ],
      ),
    );
  }
}
