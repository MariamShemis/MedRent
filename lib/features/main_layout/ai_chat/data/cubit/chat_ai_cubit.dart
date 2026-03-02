import 'package:bloc/bloc.dart';
import 'package:med_rent/features/main_layout/ai_chat/data/data_sources/chat_data.dart';
import 'package:med_rent/features/main_layout/ai_chat/data/models/chat_response_model.dart';
import 'package:meta/meta.dart';

part 'chat_ai_state.dart';

class ChatAiCubit extends Cubit<ChatAiState> {
  final ChatData chatData;
  final List<ChatMessage> message = [];
  ChatAiCubit(this.chatData) : super(ChatAiInitial());
  // chat_ai_cubit.dart

  Future<void> sendMessage(String text) async {
    if (text.trim().isEmpty) return;

    message.add(ChatMessage(isUser: true, text: text));
    emit(ChatAiSuccess(List.from(message)));
    emit(ChatAiLoading());

    try {
      final responseModel = await chatData.analyzeMessage(text);

      message.add(
        ChatMessage(
          isUser: false,
          text: responseModel.department,
          fullResponse: responseModel,
        ),
      );

      emit(ChatAiSuccess(List.from(message)));
    } catch (e) {
      emit(ChatAiError(e.toString(), List.unmodifiable(message)));
    }
  }
}
