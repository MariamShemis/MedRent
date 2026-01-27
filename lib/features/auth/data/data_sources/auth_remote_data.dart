import 'package:dio/dio.dart';
import 'package:med_rent/features/auth/data/models/login_model.dart';

class AuthRemoteData {
    static const String baseUrl = 'http://graduationprojectapi.somee.com/api/Auth';

  static Future<LoginModel> login({required String email, required String password}) async {
    Dio dio = Dio();
    try {
      var response = await dio.post(
        '$baseUrl/login',
        data: {"email": email, "password": password},
      );
      return LoginModel.fromJson(response.data);
    } on DioException catch (e) {
      throw Exception(e.response?.data['message'] ?? 'Error occurred');
    }
  }
}






