part of 'chat_ai_cubit.dart';

@immutable
sealed class ChatAiState {}

final class ChatAiInitial extends ChatAiState {}
class ChatAiLoading extends ChatAiState {}
class ChatAiSuccess extends ChatAiState {
  final List<ChatMessage> messages;
  ChatAiSuccess(this.messages);
}
class ChatAiError extends ChatAiState {
  final String error;
  final List<ChatMessage> messages;
  ChatAiError(this.error , this.messages );
}