import 'package:hive/hive.dart';

part 'chat_model.g.dart';

@HiveType(typeId: 0)
class Chat extends HiveObject {
  @HiveField(0)
  final String id;

  @HiveField(1)
  final String name;

  @HiveField(2)
  final String avatarUrl;

  @HiveField(3)
  final String lastMessage;

  @HiveField(4)
  final DateTime lastMessageTime;

  @HiveField(5)
  final String firstName;

  @HiveField(6)
  final String lastName;

  @HiveField(7)
  final bool isOnline;

  Chat({
    required this.id,
    required this.name,
    required this.avatarUrl,
    required this.lastMessage,
    required this.lastMessageTime,
    required this.firstName,
    required this.lastName,
    required this.isOnline,
  });
}
