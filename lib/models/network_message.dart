import 'dart:convert';
class NetworkMessage{
  final String msg;

  NetworkMessage({required this.msg});

  factory NetworkMessage.fromRawJson(String str) => NetworkMessage.fromJson(json.decode(str));

  factory NetworkMessage.fromJson(Map<String, dynamic> json) =>
      NetworkMessage(
          msg: json["message"]??"--"
      );

  Map<String, dynamic> toJson() => {msg: "message"};
}