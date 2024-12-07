import 'package:flutter/material.dart';

class ChatGroups extends StatelessWidget {
  const ChatGroups({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ListView.separated(
        itemBuilder: (context, index) => const ListTile(
          title: Text('Group Name'),
          subtitle: Text('Last message'),
          leading: CircleAvatar(
            child: Text('A'),
          ),
          trailing: Text('12:00'),
        ),
        itemCount: 10,
        separatorBuilder: (context, index) => const Divider(),
      ),
    );
  }
}
