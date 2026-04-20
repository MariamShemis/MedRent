import 'package:dio/dio.dart';
import 'package:med_rent/core/network/api_client.dart';
import 'package:med_rent/core/service/session_service.dart';
import '../models/user_model.dart';

class AdminUsersDataSource {
  final ApiClient _apiClient;

  AdminUsersDataSource(this._apiClient);

  Future<Options> _getOptions() async {
    final token = await SessionService.getAuthToken();
    return Options(
      headers: {
        'Authorization': 'Bearer $token',
      },
    );
  }

  Future<List<UserModel>> getAllUsers() async {
    final response = await _apiClient.get(
      '/Admin/users',
      options: await _getOptions(),
    );
    return (response.data as List)
        .map((user) => UserModel.fromJson(user))
        .toList();
  }

  Future<List<UserModel>> searchUsers(String query) async {
    final response = await _apiClient.get(
      '/Admin/search-users',
      queryParameters: {'search': query},
      options: await _getOptions(),
    );
    return (response.data as List)
        .map((user) => UserModel.fromJson(user))
        .toList();
  }

  Future<String> toggleBlockUser(int userId) async {
    final response = await _apiClient.get(
      '/Admin/users/toggle-block/$userId',
      options: await _getOptions(),
    );
    return response.data['message'];
  }
}