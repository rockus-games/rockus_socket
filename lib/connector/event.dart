// ignore_for_file: camel_case_types

import 'dart:convert';

class Event {
  String type = "";
  Map<String, dynamic>? data = {};

  Event({
    this.type = "",
    this.data = const {},
  });

  Event.parse(String data) {
    var dataJson = jsonDecode(data);
    type = dataJson["type"];
    this.data = dataJson["data"];
  }

  @override
  String toString() {
    return 'Event{type: $type, data: $data}';
  }

  String toJson() {
    return jsonEncode({
      "type": type,
      "data": data,
    });
  }
}
