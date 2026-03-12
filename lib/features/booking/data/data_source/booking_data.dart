import 'dart:io';
import 'package:dio/dio.dart';
import 'package:med_rent/core/network/api_client.dart';
import 'package:med_rent/core/network/network_checker.dart';
import 'package:med_rent/features/booking/data/model/booking_model.dart';

class BookingData {
  final ApiClient _apiClient;

  BookingData({required ApiClient apiClient}) : _apiClient = apiClient;

  Future<HospitalModel> getHospitalBookingDetails(int hospitalId) async {
    final hasInternet = await NetworkChecker.hasInternetConnection();

    if (!hasInternet) {
      throw DioException(
        requestOptions: RequestOptions(path: ''),
        error: const SocketException('No Internet'),
      );
    }

    final response = await _apiClient.get(
      '/Hospital/$hospitalId/booking-details',
    );

    if (response.statusCode == 200) {
      return HospitalModel.fromJson(response.data);
    }

    throw DioException(
      requestOptions: response.requestOptions,
      response: response,
      type: DioExceptionType.badResponse,
    );
  }

  Future<List<AvailableTimeModel>> getDoctorAvailableTimes({
    required int doctorId,
    required DateTime date,
  }) async {
    final hasInternet = await NetworkChecker.hasInternetConnection();

    if (!hasInternet) {
      throw DioException(
        requestOptions: RequestOptions(path: ''),
        error: const SocketException('No Internet'),
      );
    }

    final formattedDate = '${date.month}/${date.day}/${date.year}';

    final response = await _apiClient.get(
      '/Hospital/doctor/$doctorId/available-times',
      queryParameters: {
        "date": formattedDate,
      },
    );

    if (response.statusCode == 200) {
      final List data = response.data;
      return AvailableTimeModel.fromJsonList(data);
    }

    throw DioException(
      requestOptions: response.requestOptions,
      response: response,
      type: DioExceptionType.badResponse,
    );
  }
}