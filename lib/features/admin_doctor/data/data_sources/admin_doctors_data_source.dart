import 'package:dio/dio.dart';
import 'package:med_rent/core/network/api_client.dart';
import 'package:med_rent/core/service/session_service.dart';

import '../models/admin_doctor_model.dart';

class AdminDoctorsDataSource {
  final ApiClient _apiClient;

  AdminDoctorsDataSource(this._apiClient);

  Future<Options> _getOptions() async {
    final token = await SessionService.getAuthToken();
    return Options(headers: {'Authorization': 'Bearer $token'});
  }

  Future<List<AdminDoctorModel>> getAdminDoctors() async {
    final response = await _apiClient.get(
      '/Admin/doctors',
      options: await _getOptions(),
    );

    return (response.data as List)
        .map((doctor) => AdminDoctorModel.fromJson(doctor))
        .toList();
  }

  Future<List<AdminDoctorModel>> searchDoctors({
    String? name,
    String? specialization,
  }) async {
    final response = await _apiClient.get(
      '/Admin/search-doctors',
      queryParameters: {
        if (name != null && name.isNotEmpty) 'name': name,
        if (specialization != null && specialization.isNotEmpty)
          'specialization': specialization,
      },
      options: await _getOptions(),
    );

    return (response.data as List)
        .map((doctor) => AdminDoctorModel.fromJson(doctor))
        .toList();
  }
}
