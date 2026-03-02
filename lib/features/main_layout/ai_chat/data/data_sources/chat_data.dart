import 'package:dio/dio.dart';
import 'package:med_rent/features/main_layout/ai_chat/data/models/chat_response_model.dart';

class ChatData {
  final Dio dio;
  ChatData(this.dio);
  Future<ChatResponseModel> analyzeMessage(String message) async {
    try {
      final response = await dio.post(
        'http://graduationprojectapi.somee.com/api/Chat/analyze',
        data: {'message': message},
        
        
      );

      return ChatResponseModel.fromJson(response.data);
    } on DioException catch (e) {
      if (e.response?.statusCode == 404) throw "Service not found (404)";
      throw "Network error: Please check your connection";
    } catch (e) {
      throw "Something went wrong, please try again";
    }
  }
}
