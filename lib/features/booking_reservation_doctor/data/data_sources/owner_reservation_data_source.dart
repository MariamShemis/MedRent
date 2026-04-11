import 'package:dio/dio.dart';
import 'package:med_rent/core/network/api_client.dart';
import 'package:med_rent/core/service/session_service.dart';
import 'package:med_rent/features/booking_reservation_doctor/data/models/reservation_details_model.dart';
import 'package:med_rent/features/booking_reservation_doctor/data/models/reservation_model.dart';

class OwnerReservationDataSource {
  final ApiClient _apiClient;
  OwnerReservationDataSource(this._apiClient);

  Future<List<ReservationModel>> getOwnerBookings({String? status, String? search}) async {
    final token = await SessionService.getAuthToken();
    final response = await _apiClient.get(
      '/EquipmentOwner/bookings',
      queryParameters: {
        'status': status ?? 'booked',
        'search': search ?? '',
      },
      options: Options(headers: {'Authorization': 'Bearer $token'}),
    );
    return (response.data as List).map((e) => ReservationModel.fromJson(e)).toList();
  }

  Future<ReservationDetailsModel> getOwnerBookingDetails(int rentalId) async {
    final token = await SessionService.getAuthToken();
    print("Fetching details for Rental ID: $rentalId");
    final response = await _apiClient.get(
      '/EquipmentOwner/booking/$rentalId',
      options: Options(headers: {'Authorization': 'Bearer $token'}),
    );
    print("API Response for ID $rentalId: ${response.data}");
    return ReservationDetailsModel.fromJson(response.data);
  }
}