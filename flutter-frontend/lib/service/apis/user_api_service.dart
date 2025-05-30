import 'dart:convert';
import 'dart:developer';

import 'package:http/http.dart' as http;
import 'package:news_pulse/constants/baseurl.dart';
import 'package:news_pulse/model/user.dart';


class UserApiService {

  Future<bool> signIn(User user) async {
    log('in the service layer');
    String url = '$baseUrl/user/register';
    var body = jsonEncode({
      'username': user.username,
      'password': user.password,
      'isLoggedIn': user.loggedIn,
      'groupList': user.groupList
    });
    var headers = {'Content-Type': 'application/json'};

    try {
      final response = await http.post(
        Uri.parse(url),
        body: body,
        headers: headers,
      );
      log('service response');

      if (response.statusCode == 201) {
        log(response.body);
        return true;
      } else {
        log(response.body);
        return false;
      }
    } catch (e) {
      log(e.toString());
      return false;
    }
  }

  Future<bool> logOut(String username) async {
    String url = '$baseUrl/user/logout/$username';
    try {
      final response = await http.post(Uri.parse(url));
      if (response.statusCode == 200) {
        log(response.body);
        return true;
      } else {
        log(response.body);
        return false;
      }
    } catch (e) {
      log(e.toString());
      return false;
    }
  }

  Future<User?> login(Map<String, String> userData) async {
    String url = '$baseUrl/user/login';
    var body = jsonEncode(userData);
    var headers = {'Content-Type': 'application/json'};
    try {
      final response = await http.post(
        Uri.parse(url),
        body: body,
        headers: headers,
      );
      if (response.statusCode == 200) {
        log(response.body);
        var data = jsonDecode(response.body);
        log(data['message']);
        return User.fromJson(data);
      } else {
        log(response.body);
        return null;
      }
    } catch (e) {
      log(e.toString());
      return null;
    }
  }
}
