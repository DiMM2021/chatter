import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import '../widgets/chat_app_bar.dart';
import '../widgets/chat_list_view.dart';

@RoutePage()
class ChatListScreen extends StatelessWidget {
  final ValueNotifier<String> searchQueryNotifier = ValueNotifier("");

  ChatListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          ChatAppBar(searchQueryNotifier: searchQueryNotifier, firstName: '',),
          ChatListView(searchQueryNotifier: searchQueryNotifier),
        ],
      ),
    );
  }
}
