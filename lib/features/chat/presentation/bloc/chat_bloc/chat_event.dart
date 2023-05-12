part of 'chat_bloc.dart';

abstract class ChatEvent {}

class OnInitChat extends ChatEvent {
  final ChatController chatController;

  OnInitChat(this.chatController);
}

class OnSendMessage extends ChatEvent {
  final Message message;

  OnSendMessage(this.message);
}

class OnReceiveMessage extends ChatEvent {
  final ChatController chatController;

  OnReceiveMessage(this.chatController);
}
