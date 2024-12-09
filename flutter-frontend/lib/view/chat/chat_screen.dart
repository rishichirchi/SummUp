import 'package:flutter/material.dart';

class ChatScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Group Name", style: TextStyle(fontSize: 18)),
            Text(
              "3 participants",
              style: TextStyle(fontSize: 14, color: Colors.grey[300]),
            ),
          ],
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () {},
          ),
          IconButton(
            icon: Icon(Icons.more_vert),
            onPressed: () {},
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              reverse: true, // Messages start from the bottom
              itemCount: 10, // Example messages
              itemBuilder: (context, index) {
                return ChatBubble(
                  message: index % 2 == 0
                      ? "Hello, how are you?"
                      : "I'm good, what about you?",
                  isSentByMe: index % 2 == 0,
                );
              },
            ),
          ),
          ChatInputField(),
        ],
      ),
    );
  }
}

class ChatBubble extends StatelessWidget {
  final String message;
  final bool isSentByMe;

  const ChatBubble({required this.message, required this.isSentByMe});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: isSentByMe ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 4, horizontal: 8),
        padding: EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: isSentByMe ? Colors.green[300] : Colors.grey[300],
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(12),
            topRight: Radius.circular(12),
            bottomLeft: isSentByMe ? Radius.circular(12) : Radius.zero,
            bottomRight: isSentByMe ? Radius.zero : Radius.circular(12),
          ),
        ),
        child: Text(
          message,
          style: TextStyle(
            color: isSentByMe ? Colors.white : Colors.black,
            fontSize: 16,
          ),
        ),
      ),
    );
  }
}

class ChatInputField extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final TextEditingController _controller = TextEditingController();

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: [
          IconButton(
            icon: Icon(Icons.emoji_emotions_outlined, color: Colors.grey[600]),
            onPressed: () {},
          ),
          Expanded(
            child: TextField(
              controller: _controller,
              decoration: InputDecoration(
                hintText: "Type a message",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(24),
                  borderSide: BorderSide.none,
                ),
                filled: true,
                fillColor: Colors.grey[200],
                contentPadding: EdgeInsets.symmetric(horizontal: 16),
              ),
            ),
          ),
          IconButton(
            icon: Icon(Icons.attach_file, color: Colors.grey[600]),
            onPressed: () {},
          ),
          IconButton(
            icon: Icon(Icons.send, color: Colors.green),
            onPressed: () {
              // Send message logic (to be added later)
              _controller.clear();
            },
          ),
        ],
      ),
    );
  }
}
