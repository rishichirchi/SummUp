import 'dart:convert';
import 'dart:developer';
import 'package:http/http.dart' as http;

import 'package:news_pulse/model/group.dart';

class GroupApiService {
  static const String baseUrl = 'http://192.168.193.94:8080';

  Future<String?> createGroupChat(Group group) async {
    const String url = '$baseUrl/createGroupChat';
    log("in create group service");

    log("before try catch block");

    try {
      var body = jsonEncode({
        'groupName': group.groupName,
        'members': group.members,
        'description': group.description,
        'messages': group.messages,
        'lastMessage': group.lastMessage,
      });

      var headers = {'Content-Type': 'application/json'};

      log("before making the request");
      final response =
          await http.post(Uri.parse(url), body: body, headers: headers);

      log("after making the request");

      if (response.statusCode == 201) {
        var data = jsonDecode(response.body);

        log(data['message']);
        return data['message'];
      } else {
        log(response.body);
        return null;
      }
    } catch (e) {
      log(e.toString());
      return null;
    }
  }

    Future<List<Group>> getGroupsForUser(String username) async {
      String url = '$baseUrl/getGroupsForUser/$username';

      try {
        final response = await http.get(Uri.parse(url));

        if (response.statusCode == 200) {
          var data = jsonDecode(response.body);
          List<Group> groups = [];

          log(data.toString());

          for (var group in data['groups']) {
            groups.add(Group.fromJson(group));
          }

          log("Groups List after json decode:" + groups.toString());

          return groups;
        } else {
          log(response.body);
          return [];
        }
      } catch (e) {
        log("There is an exception: "+ e.toString());
        return [];
      }
    }
}
