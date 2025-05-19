import 'package:flutter_gemini/flutter_gemini.dart';
import 'package:news_pulse/model/message.dart';

class GeminiService {
  final gemini = Gemini.instance; // Singleton instance

  Future<Map<String, String>> summarizeChat(List<Message> messages) async {
    try {
      // Prepare chat prompt
      final chatPrompt = _generatePrompt(messages);

      // Send request
      final response = await gemini.text(chatPrompt);

      // Extract response
      final summaryData = _extractMoodAndSummary(response?.output ?? '');

      return summaryData;
    } catch (e) {
      throw Exception('Error summarizing chat: $e');
    }
  }

  String _generatePrompt(List<Message> messages) {
    final messageString = messages.map((msg) => "${msg.user.username}: ${msg.message}").join("\n");

    return '''
You are an assistant summarizing a chat conversation.
Here is the conversation:
$messageString

Task:
1. Summarize the conversation in 2-3 sentences.
2. Determine the mood of the conversation as one of the following:
   - Depressed 😔
   - Neutral 😐
   - Positive 😊
Return the result in this format:
Summary: <summary>
Mood: <mood>
''';
  }

  Map<String, String> _extractMoodAndSummary(String responseText) {
    // Extract summary and mood
    final summaryMatch = RegExp(r"Summary: (.*?)\n", dotAll: true).firstMatch(responseText);
    final moodMatch = RegExp(r"Mood: (.*)", dotAll: true).firstMatch(responseText);

    final summary = summaryMatch?.group(1)?.trim() ?? "No summary available";
    final mood = moodMatch?.group(1)?.trim() ?? "Neutral 😐";

    return {
      'summary': summary,
      'mood': mood,
    };
  }
}
