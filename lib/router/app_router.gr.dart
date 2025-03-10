// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouterGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

part of 'app_router.dart';

/// generated route for
/// [ChatListScreen]
class ChatListRoute extends PageRouteInfo<ChatListRouteArgs> {
  ChatListRoute({
    Key? key,
    List<PageRouteInfo>? children,
  }) : super(
          ChatListRoute.name,
          args: ChatListRouteArgs(key: key),
          initialChildren: children,
        );

  static const String name = 'ChatListRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<ChatListRouteArgs>(
          orElse: () => const ChatListRouteArgs());
      return ChatListScreen(key: args.key);
    },
  );
}

class ChatListRouteArgs {
  const ChatListRouteArgs({this.key});

  final Key? key;

  @override
  String toString() {
    return 'ChatListRouteArgs{key: $key}';
  }
}

/// generated route for
/// [ChatScreen]
class ChatRoute extends PageRouteInfo<ChatRouteArgs> {
  ChatRoute({
    required String chatId,
    required String firstName,
    required String lastName,
    required String avatarUrl,
    required String lastMessage,
    required DateTime lastMessageTime,
    required bool isOnline,
    Key? key,
    List<PageRouteInfo>? children,
  }) : super(
          ChatRoute.name,
          args: ChatRouteArgs(
            chatId: chatId,
            firstName: firstName,
            lastName: lastName,
            avatarUrl: avatarUrl,
            lastMessage: lastMessage,
            lastMessageTime: lastMessageTime,
            isOnline: isOnline,
            key: key,
          ),
          initialChildren: children,
        );

  static const String name = 'ChatRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<ChatRouteArgs>();
      return ChatScreen(
        chatId: args.chatId,
        firstName: args.firstName,
        lastName: args.lastName,
        avatarUrl: args.avatarUrl,
        lastMessage: args.lastMessage,
        lastMessageTime: args.lastMessageTime,
        isOnline: args.isOnline,
        key: args.key,
      );
    },
  );
}

class ChatRouteArgs {
  const ChatRouteArgs({
    required this.chatId,
    required this.firstName,
    required this.lastName,
    required this.avatarUrl,
    required this.lastMessage,
    required this.lastMessageTime,
    required this.isOnline,
    this.key,
  });

  final String chatId;

  final String firstName;

  final String lastName;

  final String avatarUrl;

  final String lastMessage;

  final DateTime lastMessageTime;

  final bool isOnline;

  final Key? key;

  @override
  String toString() {
    return 'ChatRouteArgs{chatId: $chatId, firstName: $firstName, lastName: $lastName, avatarUrl: $avatarUrl, lastMessage: $lastMessage, lastMessageTime: $lastMessageTime, isOnline: $isOnline, key: $key}';
  }
}

/// generated route for
/// [FirebaseStreamPage]
class FirebaseStreamRoute extends PageRouteInfo<void> {
  const FirebaseStreamRoute({List<PageRouteInfo>? children})
      : super(
          FirebaseStreamRoute.name,
          initialChildren: children,
        );

  static const String name = 'FirebaseStreamRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const FirebaseStreamPage();
    },
  );
}

/// generated route for
/// [ResetPasswordPage]
class ResetPasswordRoute extends PageRouteInfo<ResetPasswordRouteArgs> {
  ResetPasswordRoute({
    Key? key,
    List<PageRouteInfo>? children,
  }) : super(
          ResetPasswordRoute.name,
          args: ResetPasswordRouteArgs(key: key),
          initialChildren: children,
        );

  static const String name = 'ResetPasswordRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<ResetPasswordRouteArgs>(
          orElse: () => const ResetPasswordRouteArgs());
      return ResetPasswordPage(key: args.key);
    },
  );
}

class ResetPasswordRouteArgs {
  const ResetPasswordRouteArgs({this.key});

  final Key? key;

  @override
  String toString() {
    return 'ResetPasswordRouteArgs{key: $key}';
  }
}

/// generated route for
/// [SigninPage]
class SigninRoute extends PageRouteInfo<SigninRouteArgs> {
  SigninRoute({
    Key? key,
    List<PageRouteInfo>? children,
  }) : super(
          SigninRoute.name,
          args: SigninRouteArgs(key: key),
          initialChildren: children,
        );

  static const String name = 'SigninRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      final args =
          data.argsAs<SigninRouteArgs>(orElse: () => const SigninRouteArgs());
      return SigninPage(key: args.key);
    },
  );
}

class SigninRouteArgs {
  const SigninRouteArgs({this.key});

  final Key? key;

  @override
  String toString() {
    return 'SigninRouteArgs{key: $key}';
  }
}

/// generated route for
/// [SignupPage]
class SignupRoute extends PageRouteInfo<SignupRouteArgs> {
  SignupRoute({
    Key? key,
    List<PageRouteInfo>? children,
  }) : super(
          SignupRoute.name,
          args: SignupRouteArgs(key: key),
          initialChildren: children,
        );

  static const String name = 'SignupRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      final args =
          data.argsAs<SignupRouteArgs>(orElse: () => const SignupRouteArgs());
      return SignupPage(key: args.key);
    },
  );
}

class SignupRouteArgs {
  const SignupRouteArgs({this.key});

  final Key? key;

  @override
  String toString() {
    return 'SignupRouteArgs{key: $key}';
  }
}

/// generated route for
/// [VerifyEmailPage]
class VerifyEmailRoute extends PageRouteInfo<void> {
  const VerifyEmailRoute({List<PageRouteInfo>? children})
      : super(
          VerifyEmailRoute.name,
          initialChildren: children,
        );

  static const String name = 'VerifyEmailRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const VerifyEmailPage();
    },
  );
}
