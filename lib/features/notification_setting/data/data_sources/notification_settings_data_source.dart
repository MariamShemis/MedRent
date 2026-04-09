import 'package:dio/dio.dart';
import 'package:med_rent/core/service/session_service.dart';
import 'package:med_rent/features/notification_setting/data/models/notification_settings_model.dart';
import '../../../../core/network/api_client.dart';

class NotificationSettingsDataSource {
  final ApiClient _apiClient;

  NotificationSettingsDataSource(this._apiClient);

  Future<NotificationSettingsModel> getSettings() async {
    final token = await SessionService.getAuthToken();

    final response = await _apiClient.get(
      '/NotificationSettings',
      options: Options(
        headers: {
          'Authorization': 'Bearer $token',
        },
      ),
    );
    return NotificationSettingsModel.fromJson(response.data);
  }

  Future<void> updateSettings(NotificationSettingsModel settings) async {
    final token = await SessionService.getAuthToken();
    await _apiClient.put(
      '/NotificationSettings',
      data: settings.toJson(),
      options: Options(
        headers: {
          'Authorization': 'Bearer $token',
        },
      ),
    );
  }
}