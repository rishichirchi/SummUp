import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:news_pulse/provider/chat/messages_provider.dart';
import 'package:news_pulse/provider/groups/group_provider.dart';
import 'package:news_pulse/view/chat/screens/chat_screen.dart';

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
                onTap: () {
                  ref
                      .read(messagesProvider.notifier)
                      .addMessages(groupList[index].messages);
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => ChatScreen(
                        group: groupList[index],
                      ),
                    ),
                  );
                },
                title: Text(groupList[index].groupName),
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
