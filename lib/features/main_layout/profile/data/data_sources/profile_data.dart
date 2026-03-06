import 'package:dio/dio.dart';
import 'package:med_rent/core/constants/assets_manager.dart';
import 'package:med_rent/features/main_layout/profile/data/models/profile_model.dart';
import 'dart:convert';

class ProfileData {
  final Dio dio = Dio();
  final String baseUrl = ApiConstants.baseUrlNew;
  Future<ProfileModel> fetchProfile(String token) async {
    try {
      final response = await dio.get(
        '$baseUrl/Profile',
        options: Options(
          headers: {
            'Authorization': 'Bearer $token', 
            'Accept': 'application/json',
          },
        ),
      );
      if (response.statusCode == 200) {
        final data = response.data is String
            ? jsonDecode(response.data)
            : response.data;

        return ProfileModel.fromJson(data);
      } else {
        throw Exception("${response.statusCode}");
      }
    } on DioException catch (e) {
      String errorMessage;

      if (e.response?.data is Map) {
        errorMessage = e.response?.data['message'] ?? "error";
      } else {
        errorMessage = e.response?.data.toString() ?? "error";
      }
      throw Exception(errorMessage);
    }
  }

  Future<String> uploadProfileImage(String token, String filePath) async {
    try {
      FormData formData = FormData.fromMap({
        'file': await MultipartFile.fromFile(filePath,
            filename: filePath.split('/').last),
      });

      final response = await dio.post(
        ApiConstants.uploadImage,
        data: formData,
        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
            'Accept': 'application/json',
          },
        ),
      );

      if (response.statusCode == 200) {
        return response.data['imageUrl']; 
      } else {
        throw Exception("Failed to upload image");
      }
    } on DioException catch (e) {
      throw Exception(e.response?.data['message'] ?? "Error uploading image");
    }
  }
}
