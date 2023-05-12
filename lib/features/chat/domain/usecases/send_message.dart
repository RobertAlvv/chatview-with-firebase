import 'package:chatview/chatview.dart';
import 'package:dartz/dartz.dart';

import '../repositories/chat_repository.dart';

class UCSendMessage {
  final ChatRepository _repository;

  UCSendMessage({required ChatRepository repository})
      : _repository = repository;

  Future<Either<dynamic, bool>> call(Message params) async {
    return await _repository.sendMessage(params);
  }
}
