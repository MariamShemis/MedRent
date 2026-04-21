import 'package:dio/dio.dart';
import 'package:med_rent/core/network/api_client.dart';
import 'package:med_rent/features/devices_add_owner/data/model/add_device_owner_model.dart';

class AddDeviceOwnerService {
  final ApiClient apiClient;

  AddDeviceOwnerService(this.apiClient);

  Future<Response> addDeviceOwner({
    required AddDeviceOwnerModel deviceOwnerDData,
    required String token,
  }) async {
        FormData formData = FormData.fromMap(await deviceOwnerDData.toMap());

    return await apiClient.post(
      "/EquipmentOwner/add-device",
      data: formData,
      options: Options(
        headers: {
          "Authorization": "Bearer $token", // توكن المستخدم
        },
      ),
    );
  }
}