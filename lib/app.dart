import 'package:chatter/router/app_router.dart';
import 'package:chatter/theme/theme.dart';
import 'package:flutter/material.dart';

class MyApp extends StatelessWidget {
  final _appRouter = AppRouter();
   MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Flutter Chat',
      theme: chatTheme,
      debugShowCheckedModeBanner: false,
      routerConfig: _appRouter.config(),
    );
  }
}
