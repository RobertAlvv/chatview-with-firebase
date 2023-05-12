import 'dart:async';
import 'dart:math';

import 'package:chat_edessis/features/chat/domain/repositories/chat_repository.dart';
import 'package:firebase_database/firebase_database.dart';

import '../../../../../core/data/repositories/core_repository_impl.dart';
import '../../entities/message_dto.dart';

class ChatRemoteDataSource {
  final CoreRepositoryImpl _datasource;

  ChatRemoteDataSource({required CoreRepositoryImpl dataSource})
      : _datasource = dataSource;

  Future<bool> sendMessage(MessageDTO message) async {
    final messageMap = message.toMap();

    final ref = _datasource.ref("/messages").push();
    await ref.set(messageMap);

    return true;
  }

  Future<List<MessageDTO>> receiveInitialMessages() async {
    final snapshot = await _datasource.ref("/messages").get();

    if (!snapshot.exists) {
      return [];
    }

    final messagesDTOs = messagesDTOFromSnapshot(snapshot);

    return messagesDTOs;
  }

  Stream<MessageDTO?> receiveMessages() async* {
    StreamController<MessageDTO?> messagesController =
        StreamController<MessageDTO?>.broadcast();

    _datasource.ref("/messages").onChildAdded.listen((event) {
      if (!event.snapshot.exists) {
        messagesController.add(null);
      }

      final messagesDTO = MessageDTO.fromSnapshot(event.snapshot);
      messagesController.add(messagesDTO);
    });

    yield* messagesController.stream;
  }
}
