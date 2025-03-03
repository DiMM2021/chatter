part of 'message_bloc.dart';

@immutable
sealed class MessageEvent {}

class LoadMessages extends MessageEvent {
  final String chatId;
  LoadMessages(this.chatId);
}

class SendMessage extends MessageEvent {
  final String chatId;
  final Message message;
  SendMessage(this.chatId, this.message);
}