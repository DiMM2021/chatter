import 'package:flutter/material.dart';
import '../widgets/search_bar.dart';
import '../theme/theme.dart';

class ChatAppBar extends StatelessWidget {
  final ValueNotifier<String> searchQueryNotifier;

  const ChatAppBar(
      {super.key,
      required this.searchQueryNotifier,
      required String firstName});

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
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
            ChatSearchBar(searchQueryNotifier: searchQueryNotifier),
            Container(height: 1.0, color: stroke),
          ],
        ),
      ),
    );
  }
}
