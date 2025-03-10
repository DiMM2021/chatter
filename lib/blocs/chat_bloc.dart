import 'package:bloc/bloc.dart';
import 'package:chatter/models/chat_model.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:meta/meta.dart';

part 'chat_event.dart';
part 'chat_state.dart';

class ChatBloc extends Bloc<ChatEvent, ChatState> {
  final Box<Chat> chatBox;
  List<Chat> allChats = [];

  ChatBloc(this.chatBox) : super(ChatInitial()) {
    on<LoadChats>(_onLoadChats);
    on<DeleteChat>(_onDeleteChat);
    on<UpdateChat>(_onUpdateChat);
    on<UpdateLastMessage>(_onUpdateLastMessage);
    on<SearchChats>(_onSearchChats);
  }

  void _onLoadChats(LoadChats event, Emitter<ChatState> emit) {
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

    allChats = chatBox.values.toList();
    emit(ChatLoaded(allChats));
  }

  void _onDeleteChat(DeleteChat event, Emitter<ChatState> emit) async {
    await chatBox.delete(event.chatId);
    allChats = chatBox.values.toList();
    emit(ChatLoaded(allChats));
  }

  void _onUpdateChat(UpdateChat event, Emitter<ChatState> emit) async {
    await chatBox.put(event.chat.id, event.chat);
    allChats = chatBox.values.toList();
    emit(ChatLoaded(allChats));
  }

  void _onUpdateLastMessage(
      UpdateLastMessage event, Emitter<ChatState> emit) async {
    if (state is ChatLoaded) {
      final updatedChats = (state as ChatLoaded).chats.map((chat) {
        if (chat.id == event.chatId) {
          return Chat(
            id: chat.id,
            name: chat.name,
            avatarUrl: chat.avatarUrl,
            lastMessage: event.lastMessage,
            lastMessageTime: event.lastMessageTime,
            firstName: chat.firstName,
            lastName: chat.lastName,
            isOnline: chat.isOnline,
          );
        }
        return chat;
      }).toList();

      emit(ChatLoaded(updatedChats));
    }
  }

  void _onSearchChats(SearchChats event, Emitter<ChatState> emit) {
    final query = event.query.trim().toLowerCase();

    if (query.isEmpty) {
      emit(ChatLoaded(allChats));
      return;
    }

    final filteredChats = allChats.where((chat) {
      final firstNameStarts = chat.firstName.toLowerCase().startsWith(query);
      final lastNameStarts = chat.lastName.toLowerCase().startsWith(query);
      return firstNameStarts || lastNameStarts; 
    }).toList();

    emit(ChatLoaded(filteredChats));
  }
}
