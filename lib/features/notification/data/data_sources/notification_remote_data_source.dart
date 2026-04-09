import 'package:dio/dio.dart';
import 'package:med_rent/core/service/session_service.dart';
import 'package:med_rent/features/notification/data/models/notification_model.dart';
import '../../../../core/network/api_client.dart';

class NotificationRemoteDataSource {
  final ApiClient _apiClient;
  NotificationRemoteDataSource(this._apiClient);

  Future<List<NotificationModel>> getMyNotifications() async {
    final token = await SessionService.getAuthToken();
    final response = await _apiClient.get(
      '/Notification/my',
      options: Options(headers: {'Authorization': 'Bearer $token'}),
    );
    return (response.data as List)
        .map((e) => NotificationModel.fromJson(e))
        .toList();
  }
}