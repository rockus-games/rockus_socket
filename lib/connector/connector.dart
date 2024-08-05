import 'dart:io';
import 'package:rockus_socket/connector/event.dart';
import 'package:flutter/material.dart';

class WebSocketManager {
  WebSocketManager({
    this.ip = "ws://127.0.0.1:8080",
  });
  String ip;

  WebSocket? ws;

  final Map<String, List<Function(Event)>> _handlers = {};

  addHandler(String event, Function(Event) handler) {
    if (_handlers.containsKey(event)) {
      _handlers[event]!.add(handler);
    } else {
      _handlers[event] = [handler];
    }
  }

  removeHandler(String event, Function handler) {
    if (_handlers.containsKey(event)) {
      _handlers[event]!.remove(handler);
    }
  }

  removeLastHandler(String event) {
    if (_handlers.containsKey(event) && _handlers[event]!.isNotEmpty) {
      _handlers[event]!.removeLast();
    }
  }

  removeAllHandlers(String event) {
    if (_handlers.containsKey(event)) {
      _handlers[event]!.clear();
    }
  }

  Future init() async {
    ws = await WebSocket.connect(ip, headers: {"Origin": "allowed"});
    if (ws == null) {
      debugPrint("Error while connecting to server");
    } else {
      debugPrint("Successfully connected to server");
    }

    if (_handlers.containsKey("onConnected") &&
        _handlers["onConnected"]!.isNotEmpty) {
      for (var handler in _handlers["onConnected"]!) {
        handler(Event(type: "onConnected"));
      }
    } else {
      debugPrint("Unhandled event type: ${"onConnected"}");
    }

    ws?.listen(
      readMessages,
      onDone: () {
        debugPrint("Connection closed");
        init();
      },
      onError: (e) => debugPrint(e.toString()),
    );
  }

  void readMessages(data) {
    Event event = Event.parse(data);

    if (_handlers.containsKey(event.type) &&
        _handlers[event.type]!.isNotEmpty) {
      for (var handler in _handlers[event.type]!) {
        handler(event);
      }
    } else {
      debugPrint("Unhandled event type: ${event.type}");
    }
  }

  void writeMessage(Event event) {
    debugPrint(event.toString());
    ws?.add(event.toJson());
  }
}
