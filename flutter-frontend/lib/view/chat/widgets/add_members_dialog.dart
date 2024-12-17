import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:news_pulse/model/message.dart';
import 'package:news_pulse/provider/auth/user_provider.dart';
import 'package:news_pulse/provider/groups/group_provider.dart';

class AddMembersDialog extends ConsumerStatefulWidget {
  final String groupName;
  const AddMembersDialog({super.key, required this.groupName});

  @override
  ConsumerState<AddMembersDialog> createState() => _AddMembersDialogState();
}

class _AddMembersDialogState extends ConsumerState<AddMembersDialog> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController usernameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Add New Member'),
      content: Form(
        key: _formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Group Name Field
            TextFormField(
              controller: usernameController,
              decoration: const InputDecoration(
                labelText: 'UserName',
                border: OutlineInputBorder(),
              ),
              validator: (value) {
                if (value == null || value.trim().isEmpty) {
                  return 'Username is required';
                }
                return null;
              },
            ),
            const SizedBox(height: 16),
          ],
        ),
      ),
      actions: [
        // Cancel Button
        TextButton(
          onPressed: () async {
            Navigator.of(context).pop();
          },
          child: const Text('Cancel'),
        ),
        // Create Group Button
        ElevatedButton(
          onPressed: () {
            if (_formKey.currentState!.validate()) {
              final String groupName = widget.groupName;
              final String username = usernameController.text;
              

            ref.read(groupProvider.notifier).addMember(groupName, username);

              // Pass data back to the parent widget
              Navigator.of(context).pop();
            }
          },
          child: const Text('Add'),
        ),
      ],
    );
  }

  @override
  void dispose() {
    usernameController.dispose();
    super.dispose();
  }
}
