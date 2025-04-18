import 'package:chatter/api/firebase_api.dart';
import 'package:chatter/blocs/audio_cubit.dart';
import 'package:chatter/blocs/auth_bloc.dart';
import 'package:chatter/blocs/theme_cubit.dart';
import 'package:chatter/firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:chatter/app.dart';
import 'package:chatter/models/chat_model.dart';
import 'package:chatter/models/message_model.dart';
import 'package:chatter/blocs/chat_bloc.dart';
import 'package:chatter/blocs/message_bloc.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await FirebaseApi().initNotifications();

  await Hive.initFlutter();

  if (!Hive.isAdapterRegistered(0)) {
    Hive.registerAdapter(ChatAdapter());
  }
  if (!Hive.isAdapterRegistered(1)) {
    Hive.registerAdapter(MessageAdapter());
  }

  final chatBox = await Hive.openBox<Chat>('chats');
  final messageBox = await Hive.openBox<Message>('messages');

  final chatBloc = ChatBloc(chatBox)..add(LoadChats());
  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => ThemeCubit()),
        BlocProvider(create: (context) => AuthBloc()),
        BlocProvider(create: (context) => AudioCubit()),
        BlocProvider(create: (context) => chatBloc),
        BlocProvider(
            create: (context) => MessageBloc(messageBox, chatBox, chatBloc)),
      ],
      child: MyApp(),
    ),
  );
}
