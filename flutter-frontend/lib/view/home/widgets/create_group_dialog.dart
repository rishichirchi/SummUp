import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:news_pulse/model/message.dart';
import 'package:news_pulse/provider/auth/user_provider.dart';
import 'package:news_pulse/provider/groups/group_provider.dart';

class CreateGroupDialog extends ConsumerStatefulWidget {
  const CreateGroupDialog({super.key});

  @override
  ConsumerState<CreateGroupDialog> createState() => _CreateGroupDialogState();
}

class _CreateGroupDialogState extends ConsumerState<CreateGroupDialog> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _groupNameController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Create New Group'),
      content: Form(
        key: _formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Group Name Field
            TextFormField(
              controller: _groupNameController,
              decoration: const InputDecoration(
                labelText: 'Group Name',
                border: OutlineInputBorder(),
              ),
              validator: (value) {
                if (value == null || value.trim().isEmpty) {
                  return 'Group name is required';
                }
                return null;
              },
            ),
            const SizedBox(height: 16),
            // Description Field (Optional)
            TextFormField(
              controller: _descriptionController,
              decoration: const InputDecoration(
                labelText: 'Description (Optional)',
                border: OutlineInputBorder(),
              ),
            ),
          ],
        ),
      ),
      actions: [
        // Cancel Button
        TextButton(
          onPressed: () async{
            Navigator.of(context).pop();
          },
          child: const Text('Cancel'),
        ),
        // Create Group Button
        ElevatedButton(
          onPressed: () {
            if (_formKey.currentState!.validate()) {
              final groupName = _groupNameController.text.trim();
              final description = _descriptionController.text.trim();
              final user = ref.watch(userProvider);
              final List<Message> messages = []; // Empty list for messages
              final Message? lastMessage = null;

              ref.read(groupProvider.notifier).createGroup(
                  groupName, [user!], description, messages, lastMessage);

              // Pass data back to the parent widget
              Navigator.of(context).pop({
                'groupName': groupName,
                'members': ['self'], // Include self as the initial member
                'description': description,
              });
            }
          },
          child: const Text('Create Group'),
        ),
      ],
    );
  }

  @override
  void dispose() {
    _groupNameController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }
}
