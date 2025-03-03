// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'message_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class MessageAdapter extends TypeAdapter<Message> {
  @override
  final int typeId = 1;

  @override
  Message read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Message(
      text: fields[0] as String,
      time: fields[1] as DateTime,
      isSentByMe: fields[2] as bool,
      avatarUrl: fields[3] as String,
      firstName: fields[4] as String,
      lastName: fields[5] as String,
      isOnline: fields[6] as bool,
      chatId: fields[7] as String,
      imagePath: fields[8] as String?,
      audioPath: fields[9] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, Message obj) {
    writer
      ..writeByte(10)
      ..writeByte(0)
      ..write(obj.text)
      ..writeByte(1)
      ..write(obj.time)
      ..writeByte(2)
      ..write(obj.isSentByMe)
      ..writeByte(3)
      ..write(obj.avatarUrl)
      ..writeByte(4)
      ..write(obj.firstName)
      ..writeByte(5)
      ..write(obj.lastName)
      ..writeByte(6)
      ..write(obj.isOnline)
      ..writeByte(7)
      ..write(obj.chatId)
      ..writeByte(8)
      ..write(obj.imagePath)
      ..writeByte(9)
      ..write(obj.audioPath);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is MessageAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
