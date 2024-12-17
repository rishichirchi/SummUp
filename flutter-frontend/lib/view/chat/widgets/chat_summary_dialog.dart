import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:news_pulse/model/message.dart';
import 'package:news_pulse/provider/chat/summary_provider.dart';

class ChatSummaryDialog extends ConsumerWidget {
  final List<Message> messages; // List of chat messages

  const ChatSummaryDialog({super.key, required this.messages});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(title: const Text('Chat Summary Example')),
      body: Center(
        child: ElevatedButton(
          onPressed: () => _showSummaryDialog(context, ref),
          child: const Text('Summarize Chat'),
        ),
      ),
    );
  }

  void _showSummaryDialog(BuildContext context, WidgetRef ref) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // Trigger the provider to fetch the summary
        ref.read(summaryProvider.notifier).updateSummary(messages);

        return Dialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          child: SizedBox(
            width: 300,
            child: Consumer(
              builder: (context, ref, child) {
                final summaryState = ref.watch(summaryProvider);

                if (summaryState == null) {
                  // Show loading indicator while fetching
                  return const Padding(
                    padding: EdgeInsets.all(20.0),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        CircularProgressIndicator(),
                        SizedBox(height: 20),
                        Text('Fetching chat summary...',
                            style: TextStyle(fontSize: 16)),
                      ],
                    ),
                  );
                }

                // Show the summary and mood once fetched
                return Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        "Chat Summary",
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 10),
                      Text("Summary: ${summaryState['summary']}",
                          style: const TextStyle(fontSize: 16)),
                      const SizedBox(height: 10),
                      Text("Mood: ${summaryState['mood']}",
                          style: const TextStyle(
                              fontSize: 16, fontWeight: FontWeight.w600)),
                      const SizedBox(height: 20),
                      Align(
                        alignment: Alignment.centerRight,
                        child: ElevatedButton(
                          onPressed: () => Navigator.of(context).pop(),
                          child: const Text("Close"),
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        );
      },
    );
  }
}
