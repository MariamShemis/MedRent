import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:med_rent/core/network/api_client.dart';
import 'package:med_rent/features/main_layout/profile/data/models/profile_model.dart';

class ProfileData {
  final ApiClient _apiClient;

  ProfileData({required ApiClient apiClient}) : _apiClient = apiClient;

  Future<ProfileModel> fetchProfile(String token) async {
    try {
      final response = await _apiClient.get(
        '/Profile',
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
      }

      throw Exception("${response.statusCode}");
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
        'file': await MultipartFile.fromFile(
          filePath,
          filename: filePath.split('/').last,
        ),
      });

      final response = await _apiClient.post(
        '/Profile/upload-image',
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
      }

      throw Exception("Failed to upload image");
    } on DioException catch (e) {
      throw Exception(
        e.response?.data['message'] ?? "Error uploading image",
      );
    }
  }
}