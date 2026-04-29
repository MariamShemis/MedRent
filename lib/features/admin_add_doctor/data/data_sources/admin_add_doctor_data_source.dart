import 'package:dio/dio.dart';
import 'package:med_rent/core/network/api_client.dart';
import 'package:med_rent/core/service/session_service.dart';
import 'package:med_rent/features/admin_add_doctor/data/models/add_doctor_department_model.dart';
import 'package:med_rent/features/admin_add_doctor/data/models/add_doctor_hospital_model.dart';
import 'package:med_rent/features/admin_add_doctor/data/models/add_doctor_model.dart';

class AdminAddDoctorDataSource {
  final ApiClient _apiClient;

  AdminAddDoctorDataSource(this._apiClient);

  Future<Options> _getHeaders() async {
    final token = await SessionService.getAuthToken();
    return Options(headers: {"Authorization": "Bearer $token"});
  }

  Future<List<AddDoctorHospitalModel>> getHospitals() async {
    final response = await _apiClient.get(
      "/Admin/hospitals",
      options: await _getHeaders(),
    );
    return (response.data as List)
        .map((e) => AddDoctorHospitalModel.fromJson(e))
        .toList();
  }

  Future<List<AddDoctorDepartmentModel>> getDepartments(int hospitalId) async {
    final response = await _apiClient.get(
      "/Admin/departments/by-hospital/$hospitalId",
      options: await _getHeaders(),
    );
    return (response.data as List)
        .map((e) => AddDoctorDepartmentModel.fromJson(e))
        .toList();
  }

  Future<String> addDoctor(AddDoctorModel doctor) async {
    final response = await _apiClient.post(
      "/Admin/add-doctor",
      data: doctor.toJson(),
      options: await _getHeaders(),
    );
    return response.data.toString();
  }
}