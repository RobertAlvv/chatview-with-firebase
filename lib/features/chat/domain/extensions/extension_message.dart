import 'package:chat_edessis/features/chat/data/entities/message_dto.dart';
import 'package:chatview/chatview.dart';

extension ConvertMessage on Message {
  MessageDTO toDTO() {
    return MessageDTO(
      id: id,
      createdAt: createdAt,
      message: message,
      sendBy: sendBy,
    );
  }
}
