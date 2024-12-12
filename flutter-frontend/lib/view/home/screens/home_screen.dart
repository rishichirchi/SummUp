import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:news_pulse/provider/auth/user_provider.dart';
import 'package:news_pulse/view/home/widgets/chat_groups.dart';
import 'package:news_pulse/view/home/widgets/create_group_dialog.dart';
import 'package:news_pulse/view/home/widgets/logout_dialog.dart';
import 'package:go_router/go_router.dart';

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    void showCreateGroupDialog(BuildContext context) {
      showDialog(
        context: context,
        builder: (context) => const CreateGroupDialog(),
      );

      setState(() {
        
      });
    }
    void showSignOutDialog(BuildContext context) async {
      bool? result = await showDialog(
        context: context,
        builder: (context) => const LogoutDialog(),
      );
      setState(() {});
      if (result == true) {
        ref.read(userProvider.notifier).logOut();
        context.go('/login');
      }
    }

    String username = ref.watch(userProvider)!.username;

    return Scaffold(
      appBar: AppBar(
        title:  Text('Hey $username!'),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () => showCreateGroupDialog(context),
            icon: const Icon(Icons.group_add_outlined),
          ),
          const Gap(10),
          IconButton(
            onPressed: () => showSignOutDialog(context),
            icon: const Icon(Icons.logout),
          ),
          const Gap(10)
        ],
      ),
      body: const Center(
        child: ChatGroups(),
      ),
    );
  }
}
