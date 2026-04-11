import 'package:dio/dio.dart';
import 'package:med_rent/core/network/api_client.dart';
import 'package:med_rent/core/service/session_service.dart';
import 'package:med_rent/features/booking_reservation_doctor/data/models/reservation_details_model.dart';
import 'package:med_rent/features/booking_reservation_doctor/data/models/reservation_model.dart';

class DoctorReservationDataSource {
  final ApiClient _apiClient;
  DoctorReservationDataSource(this._apiClient);

  Future<List<ReservationModel>> getAllDoctorBookings() async {
    final token = await SessionService.getAuthToken();
    final response = await _apiClient.get(
      '/DoctorProfile/doctor/AllPatientbookings',
      options: Options(headers: {'Authorization': 'Bearer $token'}),
    );
    return (response.data as List).map((e) => ReservationModel.fromJson(e)).toList();
  }

  Future<List<ReservationModel>> searchDoctorBookings({required String status, required String search}) async {
    final token = await SessionService.getAuthToken();
    final response = await _apiClient.get(
      '/DoctorProfile/doctor/bookings',
      queryParameters: {'status': status, 'search': search},
      options: Options(headers: {'Authorization': 'Bearer $token'}),
    );
    return (response.data as List).map((e) => ReservationModel.fromJson(e)).toList();
  }

  Future<ReservationDetailsModel> getDoctorBookingDetails(int bookingId) async {
    final token = await SessionService.getAuthToken();
    final response = await _apiClient.get(
      '/DoctorProfile/doctor/booking/$bookingId',
      options: Options(headers: {'Authorization': 'Bearer $token'}),
    );
    return ReservationDetailsModel.fromJson(response.data);
  }
}