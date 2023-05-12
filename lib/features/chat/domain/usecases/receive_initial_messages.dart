import 'package:dartz/dartz.dart';
import 'package:chatview/chatview.dart';

import '../repositories/chat_repository.dart';

class UCReceiveInitialMessages {
  final ChatRepository _repository;

  UCReceiveInitialMessages({required ChatRepository repository})
      : _repository = repository;

  Future<Either<dynamic, List<Message>>> call() async {
    return await _repository.receiveInitialMessages();
  }
}
