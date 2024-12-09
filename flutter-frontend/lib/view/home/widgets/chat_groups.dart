import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:news_pulse/provider/auth/user_provider.dart';
import 'package:news_pulse/view/chat/chat_screen.dart';

class ChatGroups extends ConsumerWidget {
  const ChatGroups({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var groupList = ref.watch(userProvider)!.groupList;
    return Center(
      child: ListView.separated(
        itemBuilder: (context, index) =>  ListTile(
          onTap: () => Navigator.of(context).push(MaterialPageRoute(builder:(context) => ChatScreen())),
          title:  Text(groupList[index])?? const Text('Group Name'),
          subtitle:const  Text('Last message'),
          leading:  CircleAvatar(
            child:  Text(groupList[index][0]?? 'G'),
          ),
          trailing: const Text('12:00'),
        ),
        itemCount: groupList.length??10,
        separatorBuilder: (context, index) => const Divider(),
      ),
    );
  }
}
