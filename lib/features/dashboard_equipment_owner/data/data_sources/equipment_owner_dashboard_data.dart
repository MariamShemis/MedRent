import 'package:dio/dio.dart';
import 'package:med_rent/core/network/api_client.dart';
import 'package:med_rent/core/service/session_service.dart';
import 'package:med_rent/features/dashboard_equipment_owner/data/models/equipment_owner_dashboard_model.dart';

class EquipmentOwnerDashboardData {
  final ApiClient apiClient;

  EquipmentOwnerDashboardData(this.apiClient);

  Future<EquipmentOwnerDashboardModel> fetchDashboard() async {
    final token = await SessionService.getAuthToken();
    if (token == null || token.isEmpty) {
      throw Exception('No auth token found');
    }

    final response = await apiClient.get(
      '/EquipmentOwner/EquipmentOwner/dashboard',
      options: Options(
        headers: {
          'Authorization': 'Bearer $token',
        },
      ),
    );

    return EquipmentOwnerDashboardModel.fromJson(response.data);
  }
}