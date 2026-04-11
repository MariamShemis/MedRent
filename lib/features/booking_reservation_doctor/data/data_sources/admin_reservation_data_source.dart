import 'package:dio/dio.dart';
import 'package:med_rent/core/network/api_client.dart';
import 'package:med_rent/core/service/session_service.dart';
import 'package:med_rent/features/booking_reservation_doctor/data/models/reservation_model.dart';

class AdminReservationDataSource {
  final ApiClient _apiClient;
  AdminReservationDataSource(this._apiClient);

  Future<List<ReservationModel>> getAllOperations() async {
    final token = await SessionService.getAuthToken();
    final response = await _apiClient.get(
      '/Admin/operations',
      options: Options(headers: {'Authorization': 'Bearer $token'}),
    );
    return (response.data as List).map((e) => ReservationModel.fromJson(e)).toList();
  }

  Future<List<ReservationModel>> searchOperations({required String status, required String search}) async {
    final token = await SessionService.getAuthToken();
    final response = await _apiClient.get(
      '/Admin/search-operations',
      queryParameters: {'status': status, 'search': search},
      options: Options(headers: {'Authorization': 'Bearer $token'}),
    );
    return (response.data as List).map((e) => ReservationModel.fromJson(e)).toList();
  }
}