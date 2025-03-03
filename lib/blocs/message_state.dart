part of 'message_bloc.dart';

@immutable
sealed class MessageState {}

final class MessageInitial extends MessageState {}

class MessageLoaded extends MessageState {
  final List<Message> messages;
  MessageLoaded(this.messages);
}