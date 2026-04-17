import 'package:dio/dio.dart';
import 'package:med_rent/core/service/session_service.dart';
import '../../../../core/network/api_client.dart';
import '../models/admin_dashboard_model.dart';

class AdminDashboardDataSource {
  final ApiClient _apiClient;

  AdminDashboardDataSource(this._apiClient);

  Future<AdminDashboardModel> getDashboardData() async {
    final token = await SessionService.getAuthToken();

    final response = await _apiClient.get(
      '/Admin/dashboard',
      options: Options(
        headers: {
          'Authorization': 'Bearer $token',
        },
      ),
    );

    return AdminDashboardModel.fromJson(response.data);
  }
}