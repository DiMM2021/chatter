
import 'package:chatter/screens/chat_list_screen.dart';
import 'package:chatter/theme/theme.dart';
import 'package:flutter/material.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Chat',
      theme: chatTheme,
      debugShowCheckedModeBanner: false,
      home: ChatListScreen(),
    );
  }
}
