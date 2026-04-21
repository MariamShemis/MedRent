import 'package:dio/dio.dart';
import 'package:med_rent/core/network/api_client.dart';
import 'package:med_rent/features/devices-add_admin/data/model/add_devices_model.dart';


class AddDevicesData {
  final ApiClient _apiClient;

  AddDevicesData(this._apiClient);

  Future<Response> addDevice({
    required AddDeviceModel deviceData,
    required String token,
  }) async {
    FormData formData = FormData.fromMap(await deviceData.toMap());
    return await _apiClient.post(
    "/Admin/add-device", // الـ Endpoint
      data: formData,
      options: Options(
        headers: {
          "Authorization": "Bearer $token", // توكن الأدمن
        },
      ),
    );
  }
}