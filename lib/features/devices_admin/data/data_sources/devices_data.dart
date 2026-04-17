import 'package:dio/dio.dart';
import 'package:med_rent/core/network/api_client.dart';

class DevicesData {
  final ApiClient apiClient = ApiClient();

  Future<Response> getAllEquipments(String token) async {
    return await apiClient.get(
      "/Admin/equipments",
      options: Options(headers: {'Authorization': 'Bearer $token'}),
    );
  }

  Future<Response> searchEquipments(String token, String name) async {
    return await apiClient.get(
      "/Admin/search-equipments",
      queryParameters: {'name': name},
      options: Options(headers: {'Authorization': 'Bearer $token'}),
    );
  }
}