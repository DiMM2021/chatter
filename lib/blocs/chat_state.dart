part of 'chat_bloc.dart';

@immutable
sealed class ChatState {}

final class ChatInitial extends ChatState {}

class ChatLoaded extends ChatState {
  final List<Chat> chats;
  ChatLoaded(this.chats);
}