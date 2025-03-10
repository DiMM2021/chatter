part of 'chat_bloc.dart';

@immutable
abstract class ChatEvent {}

class LoadChats extends ChatEvent {}

class DeleteChat extends ChatEvent {
  final String chatId;
  DeleteChat(this.chatId);
}

class UpdateChat extends ChatEvent {
  final Chat chat;
  UpdateChat(this.chat);
}

class UpdateLastMessage extends ChatEvent {
  final String chatId;
  final String lastMessage;
  final DateTime lastMessageTime;

  UpdateLastMessage({
    required this.chatId,
    required this.lastMessage,
    required this.lastMessageTime,
  });
}

class SearchChats extends ChatEvent {
  final String query;
  SearchChats(this.query);
}
