import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:news_pulse/model/message.dart';
import 'package:news_pulse/provider/auth/user_provider.dart';

class ChatBubble extends ConsumerStatefulWidget {
  final Message message;

  const ChatBubble({super.key, required this.message});

  @override
  ConsumerState<ChatBubble> createState() => _ChatBubbleState();
}

class _ChatBubbleState extends ConsumerState<ChatBubble> {
  late bool isSent;
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var username = ref.watch(userProvider)!.username;
    isSent = username == widget.message.user.username ? true : false;
    return Align(
      alignment: isSent ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        decoration: BoxDecoration(
          color: isSent ? Colors.blue : const Color.fromARGB(255, 27, 202, 91),
          borderRadius: BorderRadius.only(
            topLeft: const Radius.circular(12),
            topRight: const Radius.circular(12),
            bottomLeft: isSent ? const Radius.circular(12) : Radius.zero,
            bottomRight: isSent ? Radius.zero : const Radius.circular(12),
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if(!isSent)
              Text(
                widget.message.user.username,
                style: const TextStyle(color: Colors.black, fontSize: 12),
              ),
            const SizedBox(width: 4),
            Text(
              widget.message.message,
              style: const TextStyle(color: Colors.white, fontSize: 16),
            ),
          ],
        ),
      ),
    );
  }
}
