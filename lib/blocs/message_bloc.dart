import 'package:bloc/bloc.dart';
import 'package:chatter/blocs/chat_bloc.dart';
import 'package:chatter/models/chat_model.dart';
import 'package:chatter/models/message_model.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:meta/meta.dart';

part 'message_event.dart';
part 'message_state.dart';

class MessageBloc extends Bloc<MessageEvent, MessageState> {
  final Box<Message> messageBox;
  final Box<Chat> chatBox;
  final ChatBloc chatBloc;  

  MessageBloc(this.messageBox, this.chatBox, this.chatBloc) : super(MessageInitial()) {
    on<LoadMessages>((event, emit) {
      List<Message> messages = getMessagesByChatId(event.chatId);
      emit(MessageLoaded(messages));
    });

    on<SendMessage>((event, emit) async {
      await messageBox.add(event.message);
      List<Message> messages = getMessagesByChatId(event.chatId);

      Chat? chat = chatBox.get(event.chatId);
      if (chat != null) {
        String formattedMessage = event.message.isSentByMe
            ? "Вы: ${event.message.text}" 
            : event.message.text;

        chatBox.put(
          event.chatId,
          Chat(
            id: chat.id,
            name: chat.name,
            avatarUrl: chat.avatarUrl,
            lastMessage: formattedMessage,
            lastMessageTime: event.message.time,
            firstName: chat.firstName,
            lastName: chat.lastName,
            isOnline: chat.isOnline,
          ),
        );

        chatBloc.add(LoadChats());
      }

      emit(MessageLoaded(messages));
    });
  }

  List<Message> getMessagesByChatId(String chatId) {
    return messageBox.values.where((msg) => msg.chatId == chatId).toList();
  }
}
