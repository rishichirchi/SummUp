import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:news_pulse/view/home/widgets/chat_groups.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('SummUp'),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.person_add_alt_1),
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
