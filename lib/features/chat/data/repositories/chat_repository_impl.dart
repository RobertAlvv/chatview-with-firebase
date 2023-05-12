import 'dart:async';

import 'package:chat_edessis/features/chat/domain/extensions/extension_message.dart';
import 'package:chatview/chatview.dart';

import 'package:dartz/dartz.dart';

import '../../domain/repositories/chat_repository.dart';
import '../datasources/remote/chat_remote_datasource.dart';

class ChatRepositoryImpl implements ChatRepository {
  final ChatRemoteDataSource _dataSource;

  ChatRepositoryImpl({
    required ChatRemoteDataSource dataSource,
  }) : _dataSource = dataSource;

  @override
  Future<Either<dynamic, bool>> sendMessage(Message messageParams) async {
    try {
      return Right(await _dataSource.sendMessage(messageParams.toDTO()));
    } catch (e) {
      return const Left(null);
    }
  }

  @override
  Future<Either<dynamic, List<Message>>> receiveInitialMessages() async {
    try {
      final resp = await _dataSource.receiveInitialMessages();

      final model = resp.map((e) => e.toModel()).toList();

      return Right(model);
    } catch (e) {
      return const Left(null);
    }
  }

  @override
  Either<dynamic, Stream<Message?>> receiveMessages() {
    try {
      final resp = _dataSource.receiveMessages();

      StreamController<Message?> controller =
          StreamController<Message?>.broadcast();

      resp.listen((event) {
        if (event != null) {
          final model = event.toModel();
          controller.add(model);
        }
      });

      return Right(controller.stream);
    } catch (e) {
      return const Left(null);
    }
  }
}
