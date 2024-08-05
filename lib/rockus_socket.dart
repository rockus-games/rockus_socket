library rockus_socket;

import 'package:rockus_socket/connector/connector.dart';
import 'package:rockus_socket/connector/event.dart';

class RSocket {
  RSocket({this.ip = "ws://127.0.0.1:8080"}) {
    ws = WebSocketManager(ip: ip);
    ws.init();
  }
  String ip;

  late final WebSocketManager ws;

  void on(String event, Function(Event) handler) {
    ws.addHandler(event, handler);
  }

  void off(String event, Function handler) {
    ws.removeHandler(event, handler);
  }

  void offAll(String event) {
    ws.removeAllHandlers(event);
  }

  void offLast(String event) {
    ws.removeLastHandler(event);
  }

  void disconnect() {
    ws.ws?.close();
  }

  void connect() {
    ws.init();
  }

  void send(Event event) {
    ws.writeMessage(event);
  }
}
