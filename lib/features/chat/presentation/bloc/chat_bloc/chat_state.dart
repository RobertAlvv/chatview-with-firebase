part of 'chat_bloc.dart';

class ChatState extends Equatable {
  final ChatController? controller;
  final bool isLoading;

  const ChatState({
    this.controller,
    this.isLoading = true,
  });

  ChatState copyWith({
    bool? isLoading,
    ChatController? controller,
  }) =>
      ChatState(
        isLoading: isLoading ?? this.isLoading,
        controller: controller ?? this.controller,
      );

  @override
  List<Object?> get props => [controller, isLoading];
}
