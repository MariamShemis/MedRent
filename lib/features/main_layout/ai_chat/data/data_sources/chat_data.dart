import 'package:dio/dio.dart';
import 'package:med_rent/features/main_layout/ai_chat/data/models/chat_response_model.dart';

class ChatData {
  final Dio dio;
  ChatData(this.dio);
  Future<ChatResponseModel> analyzeMessage(String message) async {
    try {
      final response = await dio.post(
        'http://GraduationProject.somee.com/api/Chat/analyze',
        data: {'message': message},
        options: Options(headers: {'Content-Type': 'application/json'},
                validateStatus: (status) => true,
),
      );

      if (response.statusCode == 200) {
        if (response.data is Map<String, dynamic>) {
          return ChatResponseModel.fromJson(response.data);
        } else {
          throw Exception("Unexpected data format from server");
        }
      } else {
        throw Exception("Server Error: ${response.statusCode}");
      }
    } on DioException catch (e) {
      throw Exception("Network Error: ${e.message}");
    } catch (e) {
      throw Exception("Error: $e");
    }
  }
}
