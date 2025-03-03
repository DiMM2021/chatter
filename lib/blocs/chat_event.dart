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

