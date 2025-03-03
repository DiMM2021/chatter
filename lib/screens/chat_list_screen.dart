import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../blocs/chat_bloc.dart';
import '../screens/chat_screen.dart';
import '../widgets/chat_avatar.dart';
import '../theme/theme.dart';
import '../utils/date_utils.dart';

class ChatListScreen extends StatefulWidget {
  @override
  _ChatListScreenState createState() => _ChatListScreenState();
}

class _ChatListScreenState extends State<ChatListScreen> {
  final TextEditingController searchQueryController = TextEditingController();

  @override
  void initState() {
    super.initState();
    context.read<ChatBloc>().add(LoadChats());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            title: Padding(
              padding: const EdgeInsets.only(top: 15.0, left: 8.0),
              child: Text(
                "Чаты",
                style: Theme.of(context).textTheme.titleLarge,
              ),
            ),
            floating: true,
            pinned: true,
            expandedHeight: 125.0,
            bottom: PreferredSize(
              preferredSize: const Size.fromHeight(75.0),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(
                        left: 20.0, right: 20.0, top: 12.0, bottom: 20.0),
                    child: TextField(
                      controller: searchQueryController,
                      decoration: InputDecoration(
                        hintText: "Поиск",
                        hintStyle: Theme.of(context).textTheme.labelLarge,
                        prefixIcon: Padding(
                          padding: EdgeInsets.all(9.0),
                          child: SvgPicture.asset(
                              'assets/icons/custom_search.svg'),
                        ),
                      ),
                      onChanged: (value) {
                        setState(() {});
                      },
                    ),
                  ),
                  Container(height: 1.0, color: stroke),
                ],
              ),
            ),
          ),
          BlocBuilder<ChatBloc, ChatState>(
            builder: (context, state) {
              if (state is ChatLoaded) {
                final filteredChats = state.chats
                    .where((chat) => chat.name
                        .toLowerCase()
                        .contains(searchQueryController.text.toLowerCase()))
                    .toList()
                  ..sort(
                      (a, b) => b.lastMessageTime.compareTo(a.lastMessageTime));

                return SliverList(
                  delegate: SliverChildBuilderDelegate(
                    (context, index) {
                      final chat = filteredChats[index];

                      return Dismissible(
                        key: Key(chat.id),
                        direction: DismissDirection.endToStart,
                        background: Container(
                          color: Colors.red,
                          alignment: Alignment.centerRight,
                          padding: const EdgeInsets.symmetric(horizontal: 20.0),
                          child: Icon(Icons.delete, color: Colors.white),
                        ),
                        onDismissed: (direction) {
                          context.read<ChatBloc>().add(DeleteChat(chat.id));
                        },
                        child: Column(
                          children: [
                            ListTile(
                              leading: ChatAvatar(
                                  imageUrl: chat.avatarUrl, name: chat.name),
                              title: Text(chat.name,
                                  style:
                                      Theme.of(context).textTheme.labelMedium),
                              subtitle: RichText(
                                text: TextSpan(
                                  style: Theme.of(context).textTheme.labelSmall,
                                  children: [
                                    if (chat.lastMessage.startsWith("Вы: "))
                                      TextSpan(
                                        text: "Вы: ",
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: Colors.black,
                                        ),
                                      ),
                                    TextSpan(
                                      text: chat.lastMessage
                                          .replaceFirst("Вы: ", ""),
                                      style: TextStyle(
                                        fontWeight: FontWeight.normal,
                                        color: Colors.black54,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              trailing: Text(
                                formatChatDate(chat.lastMessageTime),
                                style: Theme.of(context).textTheme.labelSmall,
                              ),
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => ChatScreen(
                                      chatId: chat.id,
                                      firstName: chat.firstName,
                                      lastMessage: chat.lastMessage,
                                      lastMessageTime: chat.lastMessageTime,
                                      lastName: chat.lastName,
                                      avatarUrl: chat.avatarUrl,
                                      isOnline: chat.isOnline,
                                    ),
                                  ),
                                );
                              },
                            ),
                            Divider(color: stroke, thickness: 1.0),
                          ],
                        ),
                      );
                    },
                    childCount: filteredChats.length,
                  ),
                );
              }
              return SliverFillRemaining(
                  child: Center(child: CircularProgressIndicator()));
            },
          ),
        ],
      ),
    );
  }
}
