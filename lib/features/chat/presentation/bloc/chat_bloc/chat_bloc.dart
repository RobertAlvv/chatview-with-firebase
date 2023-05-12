import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:chatview/chatview.dart';
import 'package:equatable/equatable.dart';

import '../../../domain/usecases/receive_initial_messages.dart';
import '../../../domain/usecases/receive_messages.dart';
import '../../../domain/usecases/send_message.dart';

part 'chat_event.dart';
part 'chat_state.dart';

class ChatBloc extends Bloc<ChatEvent, ChatState> {
  final UCSendMessage sendMessage;
  final UCReceiveInitialMessages receiveInitialMessages;
  final UCReceiveMessages receiveMessages;

  ChatBloc({
    required this.sendMessage,
    required this.receiveInitialMessages,
    required this.receiveMessages,
  }) : super(const ChatState()) {
    on<OnInitChat>(_onInitChat);
    on<OnSendMessage>(_onSendMessage);
    on<OnReceiveMessage>(_onReceiveMessage);
  }

  _onInitChat(OnInitChat event, Emitter<ChatState> emit) async {
    emit(state.copyWith(isLoading: true));
    final resp = await receiveInitialMessages();

    resp.fold(
      (error) => emit(state.copyWith(isLoading: false)),
      (messages) {
        event.chatController.initialMessageList = messages;
        emit(
          state.copyWith(
            isLoading: false,
            controller: event.chatController,
          ),
        );
      },
    );
  }

  _onSendMessage(OnSendMessage event, Emitter<ChatState> emit) async {
    final resp = await sendMessage(event.message);
    resp.fold(
      (error) => emit(state.copyWith(isLoading: false)),
      (message) => emit(state.copyWith(isLoading: false)),
    );
  }

  _onReceiveMessage(OnReceiveMessage event, Emitter<ChatState> emit) {
    final resp = receiveMessages();
    ChatController? _controller;

    emit(state.copyWith(controller: event.chatController));

    resp.fold((l) => null, (r) {
      r.listen((message) {
        if (state.controller != null && message != null) {
          _controller = state.controller!;
          _controller!.addMessage(message);
        }
      });
    });

    if (state.controller != null) {
      emit(state.copyWith(controller: _controller, isLoading: false));
    }
  }
}
