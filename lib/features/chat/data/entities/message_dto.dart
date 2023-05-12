import 'package:intl/intl.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:chatview/chatview.dart';

List<MessageDTO> messagesDTOFromSnapshot(DataSnapshot snapshot) {
  Map<dynamic, dynamic> data = (snapshot.value as Map);
  List<MessageDTO> messagesDTO = [];

  for (var value in data.values) {
    messagesDTO.add(MessageDTO.fromMap(value));
  }

  messagesDTO.sort((a, b) => int.parse(a.id).compareTo(int.parse(b.id)));

  return messagesDTO;
}

class MessageDTO {
  final String id;
  final String message;
  final DateTime createdAt;
  final String sendBy;

  MessageDTO({
    required this.id,
    required this.message,
    required this.createdAt,
    required this.sendBy,
  });

  factory MessageDTO.fromMap(Map<Object?, dynamic> map) {
    return MessageDTO(
      id: map["id"] ?? "",
      message: map["message"] ?? "",
      createdAt: DateFormat.jms().parse(map["createdAt"]),
      sendBy: map["sendBy"] ?? "",
    );
  }

  factory MessageDTO.fromSnapshot(DataSnapshot snapshot) {
    Map<dynamic, dynamic> map = (snapshot.value as Map);

    return MessageDTO(
      id: map["id"] ?? "",
      message: map["message"] ?? "",
      createdAt: DateFormat.jms().parse(map["createdAt"]),
      sendBy: map["sendBy"] ?? "",
    );
  }

  Message toModel() {
    return Message(
      id: id,
      message: message,
      createdAt: createdAt,
      sendBy: sendBy,
    );
  }

  Map<String, dynamic> toMap() {
    final createdAtString = DateFormat.jms().format(createdAt);

    return {
      "id": id,
      "message": message,
      "createdAt": createdAtString,
      "sendBy": sendBy,
    };
  }
}
