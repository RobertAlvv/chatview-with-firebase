import 'package:dartz/dartz.dart';
import 'package:chatview/chatview.dart';

import '../repositories/chat_repository.dart';

class UCReceiveMessages {
  final ChatRepository _repository;

  UCReceiveMessages({required ChatRepository repository})
      : _repository = repository;

  Either<dynamic, Stream<Message?>> call() {
    return _repository.receiveMessages();
  }
}
