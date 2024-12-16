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

  factory Group.fromJson(Map<String, dynamic> json) {
    return Group(
      groupName: json['groupName'],
      members: List<User>.from(json['members'].map((member) => User.fromJson(member))),
      description: json['description'],
      messages: List<Message>.from(json['messages'].map((message) => Message.fromJson(message))),
      lastMessage: json['lastMessage'] != null ? Message.fromJson(json['lastMessage']) : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'groupName': groupName,
      'members': members.map((member) => member.toJson()).toList(),
      'description': description,
      'messages': messages.map((message) => message.toJson()).toList(),
      'lastMessage': lastMessage?.toJson(),
    };
  }
}
