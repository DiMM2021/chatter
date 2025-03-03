import 'package:bloc/bloc.dart';
import 'package:chatter/models/chat_model.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:meta/meta.dart';

part 'chat_event.dart';
part 'chat_state.dart';

class ChatBloc extends Bloc<ChatEvent, ChatState> {
  final Box<Chat> chatBox;

  ChatBloc(this.chatBox) : super(ChatInitial()) {
    on<LoadChats>((event, emit) {
      if (chatBox.isEmpty) {
        final defaultChats = [
          Chat(
            id: '1',
            name: 'Виктор Власов',
            avatarUrl: '',
            lastMessage: 'Как дела?',
            lastMessageTime: DateTime.now().subtract(Duration(minutes: 10)),
            firstName: 'Виктор',
            lastName: 'Власов',
            isOnline: true,
          ),
          Chat(
            id: '2',
            name: 'Саша Алексеев',
            avatarUrl: '',
            lastMessage: 'Привет!',
            lastMessageTime: DateTime.now().subtract(Duration(hours: 1)),
            firstName: 'Саша',
            lastName: 'Алексеев',
            isOnline: false,
          ),
          Chat(
            id: '3',
            name: 'Пётр Жаринов',
            avatarUrl: '',
            lastMessage: 'Увидимся завтра!',
            lastMessageTime: DateTime.now().subtract(Duration(days: 1)),
            firstName: 'Пётр',
            lastName: 'Жаринов',
            isOnline: true,
          ),
          Chat(
            id: '4',
            name: 'Алина Жукова',
            avatarUrl: '',
            lastMessage: 'До встречи!',
            lastMessageTime: DateTime.now().subtract(Duration(days: 2)),
            firstName: 'Алина',
            lastName: 'Жукова',
            isOnline: false,
          ),
        ];

        for (var chat in defaultChats) {
          chatBox.put(chat.id, chat);
        }
      }

      emit(ChatLoaded(chatBox.values.toList()));
    });

    on<DeleteChat>((event, emit) async {
      await chatBox.delete(event.chatId);
      emit(ChatLoaded(chatBox.values.toList()));
    });

    on<UpdateChat>((event, emit) async {
      await chatBox.put(event.chat.id, event.chat);
      emit(ChatLoaded(chatBox.values.toList()));
    });
  }
}
