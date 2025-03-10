import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../blocs/chat_bloc.dart';
import '../widgets/chat_list_tile.dart';

class ChatListView extends StatelessWidget {
  final ValueNotifier<String> searchQueryNotifier;

  const ChatListView({super.key, required this.searchQueryNotifier});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ChatBloc, ChatState>(
      builder: (context, state) {
        if (state is ChatLoaded) {
          final sortedChats = List.of(state.chats)
            ..sort((a, b) => b.lastMessageTime.compareTo(a.lastMessageTime));

          final filteredChats = sortedChats.where((chat) {
            return chat.name
                .toLowerCase()
                .contains(searchQueryNotifier.value.toLowerCase());
          }).toList();

          return SliverList(
            delegate: SliverChildBuilderDelegate(
              (context, index) {
                final chat = filteredChats[index];
                return ChatListTile(chat: chat);
              },
              childCount: filteredChats.length,
            ),
          );
        }
        return const SliverFillRemaining(
            child: Center(child: CircularProgressIndicator()));
      },
    );
  }
}
