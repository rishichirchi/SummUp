import 'dart:developer';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:news_pulse/model/group.dart';
import 'package:news_pulse/model/message.dart';
import 'package:news_pulse/model/user.dart';
import 'package:news_pulse/service/apis/group_api_service.dart';

class GroupNotifier extends StateNotifier<List<Group>> {
  final GroupApiService apiService;
  GroupNotifier(this.apiService) : super([]);

  Future<bool> createGroup(String groupName, List<User> members,
      String description, List<Message> messages, Message? lastMessage) async {
    log("in create group provider");
    final group = Group(
        groupName: groupName,
        members: members,
        description: description,
        messages: messages,
        lastMessage: lastMessage);
    final response = await apiService.createGroupChat(group);

    if (response != null) {
      getGroups(members[0].username);
      return true;
    }
    return false;
  }

  Future<void> getGroups(String username) async {
    state = [];
    List<Group> groups = await apiService.getGroupsForUser(username);
    state = groups;
  }

  Future<void> addMember(String groupName, String username) async{
    await apiService.addMember(groupName, username);
  }

  
}

final apiServiceProvider =
    Provider<GroupApiService>((ref) => GroupApiService());

final groupProvider = StateNotifierProvider<GroupNotifier, List<Group>>(
    (ref) => GroupNotifier(ref.read(apiServiceProvider)));
