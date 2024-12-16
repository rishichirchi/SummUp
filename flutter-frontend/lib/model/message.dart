import 'package:news_pulse/model/user.dart';

class Message {
  final String message;
  final User user;
  final String groupName;
  final String timeStamp;

  Message({
    required this.message,
    required this.user,
    required this.groupName,
    required this.timeStamp,
  });

  factory Message.fromJson(Map<String, dynamic> json){
    return Message(
      message: json['message'],
      user: User.fromJson(json['user']),
      groupName: json['groupName'],
      timeStamp: json['timeStamp'],
    );
  }

  Map<String, dynamic> toJson(){
    return {
      'message': message,
      'user': user.toJson(),
      'groupName': groupName,
      'timeStamp': timeStamp,
    };
  }
}
