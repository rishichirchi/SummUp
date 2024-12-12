import 'package:news_pulse/model/message.dart';
import 'package:news_pulse/model/user.dart';

class Group {
  final String groupName;
  final List<User> members;
  final String description;
  final List<Message> messages;
  final Message? lastMessage;

  Group({
    required this.groupName,
    required this.members,
    required this.description,
    required this.messages,
    required this.lastMessage,
  });
}
