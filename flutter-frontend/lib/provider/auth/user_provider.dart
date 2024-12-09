import 'dart:developer';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:news_pulse/model/user.dart';
import 'package:news_pulse/utils/apis/user_api_service.dart';

class UserNotifier extends StateNotifier<User?> {
  final UserApiService apiService;
  UserNotifier(this.apiService) : super(null);

  Future<bool> newUserSignIn(String username, String password) async {
    log('in the provider');
    final user = User(
        username: username, password: password, loggedIn: true, groupList: []);
    var response = await apiService.signIn(user);
    log('provider response');
    if (response) state = user;
    return response;
  }

  Future<bool> logOut() async {
    final username = state!.username;
    var response = await apiService.logOut(username);
    if (response) state = null;
    return response;
  }

  Future<bool> login(String username, String password) async {
    var userData = {'username': username, 'password': password};
    var response = await apiService.login(userData);
    if (response != null) state = response;
    return response != null? true : false;
  }

}

final apiServiceProvider = Provider<UserApiService>((ref) => UserApiService());
final userProvider = StateNotifierProvider<UserNotifier, User?>(
    (ref) => UserNotifier(ref.read(apiServiceProvider)));
