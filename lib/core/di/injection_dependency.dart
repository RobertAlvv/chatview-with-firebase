import 'package:chat_edessis/features/chat/data/repositories/chat_repository_impl.dart';
import 'package:chat_edessis/features/chat/presentation/bloc/chat_bloc/chat_bloc.dart';
import 'package:get_it/get_it.dart';

import '../../features/chat/data/datasources/remote/chat_remote_datasource.dart';
import '../../features/chat/domain/repositories/chat_repository.dart';
import '../../features/chat/domain/usecases/receive_initial_messages.dart';
import '../../features/chat/domain/usecases/receive_messages.dart';
import '../../features/chat/domain/usecases/send_message.dart';
import '../data/datasources/remote/firebase_data_source.dart';
import '../data/repositories/core_repository_impl.dart';

final locator = GetIt.instance;

void init() {
  //* Use Cases
  locator
      .registerFactory(() => UCReceiveInitialMessages(repository: locator()));
  locator.registerFactory(() => UCReceiveMessages(repository: locator()));
  locator.registerFactory(() => UCSendMessage(repository: locator()));

  //* Repositories
  locator.registerFactory<ChatRepository>(
      () => ChatRepositoryImpl(dataSource: locator()));

  //* DataSources
  locator.registerFactory(() => ChatRemoteDataSource(dataSource: locator()));
  locator.registerFactory(() => CoreRepositoryImpl(dataSource: locator()));

  //* Firebase Database
  locator.registerFactory(() => FirebaseDataSource());

  //* Blocs
  locator.registerFactory(() => ChatBloc(
        sendMessage: locator(),
        receiveMessages: locator(),
        receiveInitialMessages: locator(),
      ));
}
