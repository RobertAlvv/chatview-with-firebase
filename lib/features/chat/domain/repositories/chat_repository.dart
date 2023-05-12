// ignore: implementation_imports
import 'package:chatview/src/models/message.dart';
import 'package:dartz/dartz.dart';

abstract class ChatRepository {
  Future<Either<dynamic, bool>> sendMessage(Message messageParams);
  Future<Either<dynamic, List<Message>>> receiveInitialMessages();
  Either<dynamic, Stream<Message?>> receiveMessages();
}
