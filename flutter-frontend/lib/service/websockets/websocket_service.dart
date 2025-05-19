import 'dart:convert';
import 'dart:developer';

import 'package:news_pulse/model/message.dart';
import 'package:stomp_dart_client/stomp_dart_client.dart';

class WebsocketService {
  StompClient? stompClient;
  String groupName;
  String? subscriptionId;

  WebsocketService({required this.groupName});

  void connect() {
    stompClient = StompClient(
      config: StompConfig(
        url: 'ws://3.7.79.69:8081/ws',
        onConnect: onConnect,
        onWebSocketError: (dynamic error) => log(
          'Error: $error',
        ),
        onStompError: (StompFrame frame) => log(
          'Error: ${frame.body}',
        ),
        onDisconnect: (frame) => log('Disconnected'),
        onDebugMessage: (p0) => log('Debug: $p0'),
        onWebSocketDone: () => log('Websocket connection closed'),
      ),
    );

    stompClient!.activate();
  }

  void onConnect(StompFrame frame) {
    log("Connected to websocket!");
    _subscribeToGroup(groupName);
  }

  void setGroup(String newGroupName) {
    if (stompClient != null && stompClient!.connected) {
      groupName = newGroupName;
      _subscribeToGroup(newGroupName); // Subscribe to the new group
    } else {
      log("Error: Cannot change group because the StompClient is not connected.");
    }
  }

  void _subscribeToGroup(String group) {
    if (stompClient != null && stompClient!.connected) {
      subscriptionId = '/chat/$group'; // Use group name as a unique ID
      stompClient!.subscribe(
        destination: subscriptionId!,
        callback: (StompFrame frame) {
          log("Received message in group $group: ${frame.body}");
        },
      );
      log("Subscribed to group: $group");
    }
  }

  

  void sendMessage(Message message) {
    if (stompClient != null && stompClient!.connected) {
      if (groupName.isEmpty) {
        log('Error: Group name is empty. Cannot send message.');
        return;
      }

      stompClient!.send(
        destination: '/app/chat/$groupName/send-message',
        body: jsonEncode(message.toJson()),
      );
      log('Message sent: ${message.toJson()}');
    } else {
      log('Error: StompClient not connected.');
    }
  }

  void disconnect() {
    if (stompClient != null && stompClient!.connected) {
      stompClient!.deactivate();
    }
    log('Websocket connection deactivated');
  }
}
