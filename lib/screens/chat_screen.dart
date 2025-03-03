import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../blocs/message_bloc.dart';
import '../models/message_model.dart';
import '../widgets/chat_avatar.dart';
import '../widgets/chat_bubbles.dart';
import '../theme/theme.dart';
import '../utils/date_utils.dart';
import '../widgets/chat_attachment.dart';
import '../widgets/chat_audio.dart';

class ChatScreen extends StatefulWidget {
  final String chatId;
  final String firstName;
  final String lastName;
  final String avatarUrl;
  final String lastMessage;
  final DateTime lastMessageTime;
  final bool isOnline;
  final String? imagePath;
  final String? audioPath;

  ChatScreen({
    required this.chatId,
    required this.firstName,
    required this.lastName,
    required this.avatarUrl,
    required this.lastMessage,
    required this.lastMessageTime,
    required this.isOnline,
    this.imagePath,
    this.audioPath,
    Key? key,
  }) : super(key: key);

  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final TextEditingController _messageController = TextEditingController();
  bool _isTyping = false;
  File? _audioFile;

  final GlobalKey<ChatAudioState> _chatAudioKey = GlobalKey<ChatAudioState>();

  @override
  void initState() {
    super.initState();
    context.read<MessageBloc>().add(LoadMessages(widget.chatId));

    WidgetsBinding.instance.addPostFrameCallback((_) {
      final state = context.read<MessageBloc>().state;
      if (state is MessageLoaded && state.messages.isEmpty) {
        final existingMessages =
            context.read<MessageBloc>().getMessagesByChatId(widget.chatId);
        if (existingMessages.isEmpty) {
          final initialMessage = Message(
            text: widget.lastMessage,
            time: widget.lastMessageTime,
            isSentByMe: false,
            avatarUrl: widget.avatarUrl,
            firstName: widget.firstName,
            lastName: widget.lastName,
            isOnline: widget.isOnline,
            chatId: widget.chatId,
            imagePath: widget.imagePath,
            audioPath: widget.audioPath,
          );
          context
              .read<MessageBloc>()
              .add(SendMessage(widget.chatId, initialMessage));
        }
      }
    });

    _messageController.addListener(() {
      setState(() {
        _isTyping = _messageController.text.trim().isNotEmpty;
      });
    });
  }

  void _sendMessage() {
    if (_messageController.text.trim().isNotEmpty || _audioFile != null) {
      final message = Message(
        text: _messageController.text,
        time: DateTime.now(),
        isSentByMe: true,
        avatarUrl: widget.avatarUrl,
        firstName: widget.firstName,
        lastName: widget.lastName,
        isOnline: widget.isOnline,
        chatId: widget.chatId,
        imagePath: widget.imagePath,
        audioPath: _audioFile?.path,
      );

      context.read<MessageBloc>().add(SendMessage(widget.chatId, message));
      _messageController.clear();
      setState(() {
        _audioFile = null;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
        title: Row(
          children: [
            ChatAvatar(
                imageUrl: widget.avatarUrl,
                name: "${widget.firstName} ${widget.lastName}"),
            SizedBox(width: 10),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("${widget.firstName} ${widget.lastName}",
                    style: Theme.of(context).textTheme.labelMedium),
                Text(widget.isOnline ? "В сети" : "Не в сети",
                    style: Theme.of(context).textTheme.labelSmall),
              ],
            ),
          ],
        ),
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(10.0),
          child: Container(height: 1.0, color: stroke),
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: BlocBuilder<MessageBloc, MessageState>(
              builder: (context, state) {
                if (state is MessageLoaded) {
                  return ListView.builder(
                    reverse: true,
                    padding: EdgeInsets.all(10.0),
                    itemCount: state.messages.length,
                    itemBuilder: (context, index) {
                      final message =
                          state.messages[state.messages.length - 1 - index];

                      final bool showDateDivider = index ==
                              state.messages.length - 1 ||
                          DateFormat('yyyy-MM-dd').format(message.time) !=
                              DateFormat('yyyy-MM-dd').format(state
                                  .messages[state.messages.length - index - 2]
                                  .time);

                      return Column(
                        children: [
                          if (showDateDivider)
                            Padding(
                              padding: EdgeInsets.symmetric(vertical: 10),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Expanded(
                                      child: Divider(
                                          color: Colors.grey[400],
                                          thickness: 1.0,
                                          indent: 10,
                                          endIndent: 10)),
                                  Text(formatChatDate(message.time),
                                      style: TextStyle(
                                          color: Colors.grey[600],
                                          fontSize: 12)),
                                  Expanded(
                                      child: Divider(
                                          color: Colors.grey[400],
                                          thickness: 1.0,
                                          indent: 10,
                                          endIndent: 10)),
                                ],
                              ),
                            ),
                          ChatBubble(
                            message: message.text,
                            isSender: message.isSentByMe,
                            time: DateFormat('HH:mm').format(message.time),
                            tail: index == 0,
                            imagePath: message.imagePath ?? '',
                            delivered: true,
                          )
                        ],
                      );
                    },
                  );
                }
                return Center(child: CircularProgressIndicator());
              },
            ),
          ),
          Padding(
            padding: EdgeInsets.only(bottom: 15.0),
            child: Container(height: 1.0, color: stroke),
          ),
          Container(
            padding: EdgeInsets.only(
                left: 20.0, right: 20.0, bottom: 50.0, top: 10.0),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20), topRight: Radius.circular(20)),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                ChatAttachment(
                  onImageSelected: (imagePath) {
                    final message = Message(
                      text: '',
                      time: DateTime.now(),
                      isSentByMe: true,
                      avatarUrl: widget.avatarUrl,
                      firstName: widget.firstName,
                      lastName: widget.lastName,
                      isOnline: widget.isOnline,
                      chatId: widget.chatId,
                      imagePath: imagePath,
                    );

                    context
                        .read<MessageBloc>()
                        .add(SendMessage(widget.chatId, message));
                  },
                ),
                SizedBox(width: 5),
                Expanded(
                  child: ConstrainedBox(
                    constraints: BoxConstraints(maxHeight: 150),
                    child: Container(
                      decoration: BoxDecoration(
                        color: stroke,
                        borderRadius: BorderRadius.circular(30),
                      ),
                      child: TextField(
                        controller: _messageController,
                        maxLines: null,
                        keyboardType: TextInputType.multiline,
                        decoration: InputDecoration(
                          hintText: "Сообщение",
                          hintStyle: Theme.of(context).textTheme.labelLarge,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide.none,
                          ),
                          filled: true,
                          fillColor: stroke,
                          contentPadding: EdgeInsets.symmetric(
                              vertical: 15, horizontal: 15),
                        ),
                        onChanged: (text) {
                          setState(() {
                            _isTyping = text.trim().isNotEmpty;
                          });
                        },
                      ),
                    ),
                  ),
                ),
                SizedBox(width: 5),
                ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Container(
                    color: stroke,
                    child: GestureDetector(
                      onLongPress: () =>
                          _chatAudioKey.currentState?.startRecording(),
                      onLongPressUp: () =>
                          _chatAudioKey.currentState?.stopRecording(),
                      child: IconButton(
                        padding: const EdgeInsets.all(15.0),
                        constraints: const BoxConstraints(),
                        icon: _isTyping
                            ? const Icon(Icons.send, color: darkGreen)
                            : SvgPicture.asset('assets/icons/custom_audio.svg'),
                        onPressed: _isTyping ? _sendMessage : null,
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
