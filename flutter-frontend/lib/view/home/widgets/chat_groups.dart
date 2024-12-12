import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:news_pulse/provider/auth/user_provider.dart';
import 'package:news_pulse/provider/groups/group_provider.dart';
import 'package:news_pulse/view/chat/chat_screen.dart';
import 'package:news_pulse/model/group.dart';

class ChatGroups extends ConsumerWidget {
  const ChatGroups({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var username = ref.watch(userProvider)!.username;

    return Center(
      child: FutureBuilder<List<Group>>(
        future: ref.read(groupProvider.notifier).getGroups(username),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const CircularProgressIndicator();
          }
          if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          }
          if (snapshot.hasData) {
            var groupList = snapshot.data!;
            return ListView.separated(
              itemBuilder: (context, index) => ListTile(
                onTap: () => Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => const ChatScreen(),
                  ),
                ),
                title: Text(groupList[index].groupName ?? 'Group Name'),
                subtitle: Text(groupList[index].lastMessage?.message ?? 'No messages yet'),
                leading: CircleAvatar(
                  child: Text(
                    groupList[index].groupName[0].toUpperCase() ?? 'G',
                  ),
                ),
                trailing: const Text('12:00'),
              ),
              itemCount: groupList.length,
              separatorBuilder: (context, index) => const Divider(),
            );
          }
          return const Text('No groups available');
        },
      ),
    );
  }
}
