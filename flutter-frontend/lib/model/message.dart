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
}
