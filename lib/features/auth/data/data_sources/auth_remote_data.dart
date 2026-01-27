import 'package:dio/dio.dart';
import 'package:med_rent/features/auth/data/models/login_model.dart';

class AuthRemoteData {
  static const String baseUrl =
      'http://graduationprojectapi.somee.com/api/Auth';

  static Future<LoginModel> login({
    required String email,
    required String password,
  }) async {
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

  static Future<String> register({
    required String name,
    required String email,
    required String password,
    required String phone,
  }) async {
    Dio dio = Dio();
    try{
      var response = await dio.post('$baseUrl/register' , data :{
        "name" : name ,
        "email" : email ,
        "password" : password ,
        "phone" : phone ,
      } );
      if (response.statusCode == 200) {
      return "Successfully registered";
    } else {
      throw Exception("Registration failed");
    }
  } on DioException catch (e) {
    if (e.response?.statusCode == 400) {
      throw Exception("This email is already registered");
    }
    throw Exception(e.response?.data.toString() ?? "An unexpected error occurred");
  }
  }
}









