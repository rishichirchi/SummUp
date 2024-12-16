import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:news_pulse/provider/groups/group_provider.dart';
import 'package:news_pulse/view/chat/chat_screen.dart';

class ChatGroups extends ConsumerWidget {
  const ChatGroups({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var groupList = ref.watch(groupProvider);

    return Center(
      child: groupList.isEmpty
          ? const Text('No groups available')
          : ListView.separated(
              itemBuilder: (context, index) => ListTile(
                onTap: () => Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => const ChatScreen(),
                  ),
                ),
                title: Text(groupList[index].groupName ),
                subtitle: Text(
                    groupList[index].lastMessage?.message ?? 'No messages yet'),
                leading: CircleAvatar(
                  child: Text(
                    groupList[index].groupName[0].toUpperCase(),
                  ),
                ),
                trailing: Text(DateFormat('hh:mm a').format(DateTime.now())),
              ),
              itemCount: groupList.length,
              separatorBuilder: (context, index) => const Divider(),
            ),
    );
  }
}
