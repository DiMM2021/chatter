part of 'message_bloc.dart';

@immutable
sealed class MessageState {}

final class MessageInitial extends MessageState {}

class MessageLoading extends MessageState {}

class MessageLoaded extends MessageState {
  final List<Message> messages;
  MessageLoaded(this.messages);
}

class RecordingState extends MessageState {
  final int duration;
  final double progress;
  RecordingState({required this.duration, required this.progress});
}

class RecordingStopped extends MessageState {
  final int duration;
  RecordingStopped({required this.duration});
}