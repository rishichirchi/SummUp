import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:news_pulse/model/group.dart';
import 'package:news_pulse/model/message.dart';
import 'package:news_pulse/model/user.dart';
import 'package:news_pulse/provider/auth/user_provider.dart';
import 'package:news_pulse/provider/chat/messages_provider.dart';
import 'package:news_pulse/provider/groups/group_provider.dart';
import 'package:news_pulse/utils/websockets/websocket_service.dart';
import 'package:news_pulse/view/chat/widgets/add_members_dialog.dart';
import 'package:news_pulse/view/chat/widgets/chat_bubble.dart';
import 'package:news_pulse/view/chat/widgets/chat_summary_dialog.dart';

class ChatScreen extends ConsumerStatefulWidget {
  final Group group;
  const ChatScreen({super.key, required this.group});

  @override
  ConsumerState<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends ConsumerState<ChatScreen> {
  final _messageController = TextEditingController();
  late WebsocketService _websocketService;

  @override
  void initState() {
    super.initState();
    _websocketService = WebsocketService(groupName: widget.group.groupName);
    _websocketService.connect();
  }

  @override
  void dispose() {
    _websocketService.disconnect();
    super.dispose();
  }

  void sendMessage() async {
    var user = ref.watch(userProvider);
    Message message = Message(
      message: _messageController.text,
      groupName: widget.group.groupName,
      user: user!,
      timestamp: DateFormat('hh:mm a').format(DateTime.now()),
    );
    try {
      _websocketService.sendMessage(message);
    } catch (e) {
      log(e.toString());
    }

    try {
      ref.read(messagesProvider.notifier).addMessage(message);
      _messageController.clear();
    } catch (e) {
      log(e.toString());
    }
  }

  void showAddMemberDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AddMembersDialog(
        groupName: widget.group.groupName,
      ),
    );

    setState(() {});
  }

  void showSummary(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => ChatSummaryDialog(messages: ref.watch(messagesProvider)),
    );

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    List<Message> messages = ref.watch(messagesProvider);
    log(messages.toString());

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.grey[900],
        leading: const BackButton(color: Colors.white),
        title: Text(
          widget.group.groupName,
          style: const TextStyle(color: Colors.white),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.group, color: Colors.white),
            onPressed: () => showAddMemberDialog(context),
          ),
        ],
      ),
      body: Column(
        children: [
          // Message list
          Expanded(
            child: ListView.builder(
              itemCount: messages.length,
              itemBuilder: (context, index) {
                return ChatBubble(
                  message: messages[index],
                );
              },
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
            color: Colors.grey[900],
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    style: const TextStyle(color: Colors.white),
                    decoration: InputDecoration(
                      hintText: "Type your message...",
                      hintStyle: TextStyle(color: Colors.grey[500]),
                      filled: true,
                      fillColor: Colors.grey[800],
                      contentPadding:
                          const EdgeInsets.symmetric(horizontal: 16),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                        borderSide: BorderSide.none,
                      ),
                    ),
                    controller: _messageController,
                  ),
                ),
                const SizedBox(width: 8),
                CircleAvatar(
                  backgroundColor: Colors.blue,
                  child: IconButton(
                    icon: const Icon(Icons.summarize, color: Colors.white),
                    onPressed: () => showSummary(context),
                  ),
                ),
                const SizedBox(width: 8),
                CircleAvatar(
                  backgroundColor: Colors.blue,
                  child: IconButton(
                    icon: const Icon(Icons.send, color: Colors.white),
                    onPressed: sendMessage,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
