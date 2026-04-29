import 'package:dio/dio.dart';
import 'package:med_rent/core/network/api_client.dart';

class OwnerDevicesService {
  final ApiClient apiClient = ApiClient();
  Future<Response> getAllEquipments(String token ) async {
    return await apiClient.get("/EquipmentOwner/devices" , options: Options(headers: {"Authorization": "Bearer $token"}));

  }
}
