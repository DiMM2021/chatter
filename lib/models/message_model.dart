import 'package:hive/hive.dart';

part 'message_model.g.dart';

@HiveType(typeId: 1)
class Message extends HiveObject {
  @HiveField(0)
  final String text;

  @HiveField(1)
  final DateTime time;

  @HiveField(2)
  final bool isSentByMe;

  @HiveField(3)
  final String avatarUrl;

  @HiveField(4)
  final String firstName;

  @HiveField(5)
  final String lastName;

  @HiveField(6)
  final bool isOnline;

  @HiveField(7)
  final String chatId;

  @HiveField(8)
  final String? imagePath;

@HiveField(9)
  final String? audioPath;


  Message({
    required this.text,
    required this.time,
    required this.isSentByMe,
    required this.avatarUrl,
    required this.firstName,
    required this.lastName,
    required this.isOnline,
    required this.chatId,
    this.imagePath,
    this.audioPath,
  });
}
