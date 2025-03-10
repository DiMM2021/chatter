import 'package:chatter/widgets/chat_avatar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class ListAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String firstName;
  final String lastName;
  final String avatarUrl;
  final bool isOnline;

  const ListAppBar({
    super.key,
    required this.firstName,
    required this.lastName,
    required this.avatarUrl,
    required this.isOnline,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      leading: IconButton(
        icon: Icon(Icons.arrow_back),
        onPressed: () => Navigator.pop(context),
      ),
      title: Row(
        children: [
          ChatAvatar(imageUrl: avatarUrl, name: "$firstName $lastName"),
          SizedBox(width: 10),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("$firstName $lastName",
                  style: Theme.of(context).textTheme.labelMedium),
              Text(isOnline ? "В сети" : "Не в сети",
                  style: Theme.of(context).textTheme.labelSmall),
            ],
          ),
        ],
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}
