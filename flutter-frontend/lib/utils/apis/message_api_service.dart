import 'dart:convert';
import 'dart:developer';

import 'package:news_pulse/model/message.dart';
import 'package:http/http.dart' as http;

class MessageApiService {
    static const String baseUrl = 'http://192.168.193.94:8080';

  Future<List<Message>> getMessages(String groupName) async{
      String url = '$baseUrl/getMessages/$groupName';

      try {
        final response = await http.get(Uri.parse(url));

        if (response.statusCode == 200) {
          var data = jsonDecode(response.body);
          List<Message> messages = [];

          log(data.toString());

          for (var message in data) {
            messages.add(Message.fromJson(message));
          }

          log("Messages List after json decode:" + messages.toString());

          return messages;
        } else {
          log(response.body);
          return [];
        }
      } catch (e) {
        log("There is an exception:  ${e.toString()}");
        return [];
      }
    }
}