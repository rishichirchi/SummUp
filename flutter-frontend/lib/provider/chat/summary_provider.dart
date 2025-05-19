import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:news_pulse/model/message.dart';
import 'package:news_pulse/service/gemini/gemini_api_service.dart';

class SummaryNotifier extends StateNotifier<Map<String, String>?> {
  final GeminiService apiService;
  SummaryNotifier(this.apiService) : super(null);

  void updateSummary(List<Message> messages)async {
    var response = await apiService.summarizeChat(messages);
    state = response;
  }
}

final geminiAPIProvider = Provider((ref) => GeminiService());

final summaryProvider =
    StateNotifierProvider<SummaryNotifier, Map<String, String>?>(
        (ref) => SummaryNotifier(ref.read(geminiAPIProvider)));
