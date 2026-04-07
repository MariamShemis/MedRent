import 'package:dio/dio.dart';
import 'package:med_rent/features/dashboard_doctor/data/models/dashboard_model.dart';
import '../../../../core/network/api_client.dart';

class DoctorDashboardRemoteDataSource {
  final ApiClient apiClient;

  DoctorDashboardRemoteDataSource(this.apiClient);

  Future<DoctorDashboardModel> getDashboard(String token) async {
    final response = await apiClient.get(
      '/DoctorProfile/doctor/dashboard',
      options: Options(
        headers: {
          "Authorization": "Bearer $token",
        },
      ),
    );

    return DoctorDashboardModel.fromJson(response.data);
  }
}