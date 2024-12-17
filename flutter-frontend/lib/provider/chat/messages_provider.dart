import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:news_pulse/model/message.dart';

class MessagesNotifier extends StateNotifier<List<Message>>{
  // final MessageApiService apiService;
  MessagesNotifier() : super([]);

  void addMessage(Message message){
    state = [...state, message];
  }

  void addMessages(List<Message> messages){
    state = messages;
  }

}

// final messageServiceProvider = Provider((ref) => MessageApiService());

final messagesProvider = StateNotifierProvider<MessagesNotifier, List<Message>>((ref) => MessagesNotifier());